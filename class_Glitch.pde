import java.util.Random;

class Glitch {

  color[] currentImg;
  boolean isVisible = false;
  boolean isFirst = true;
  PImage result;
  int amountOfShift;
  int pixelLength;
  int randomLength;
  boolean pixelShiftStatic;

  Random rnd = new Random();

  Glitch(boolean pxlshftsttc) {
    pixelShiftStatic = pxlshftsttc;
  }


  //*****These are method you call*****
  void glitchOn() {
    if ( isFirst ) {    
      isVisible = true;
      amountOfShift = randomInt(pixelLength);
      isFirst = false;
    }
  }
 
  void display() {
    if ( isVisible ) {
      //Get a window's image
      currentImg = get().pixels;
      pixelLength = currentImg.length;
      result = effect( currentImg );
      //Overwrite window
      image(result, 0, 0);
    }
    if ( !pixelShiftStatic ) {
      amountOfShift = randomInt(pixelLength);
    }
  }

  void glitchOff() {
    isVisible = false;
    isFirst = true;
  }
  //*****/////////////////////////*****


  PImage effect (color[] pix ) {

    //Repeat three times when this function called.
    for ( int j = 0; j < 3; j++ ) {
      randomLength = myRandomInt(pixelLength);

      int beginIndex = randomInt(pixelLength);
      int endIndex = beginIndex + randomLength;

      int type = randomInt(8);

      switch ( type ) {
        //duplication
      case 0:
        {
          int rand = myRandomInt(randomInt(10))+1;
          for (int i = beginIndex; i < endIndex; i++) {
            pix[i%pixelLength] =pix[(abs(i*rand))%pixelLength];
          }
          break;
        }
        //replication
      case 1:
        {
          int rand = myRandomInt(pixelLength);
          for (int i = beginIndex; i < endIndex; i++) {
            pix[i%pixelLength] =pix[(i+rand)%pixelLength];
          }
          break;
        }
        //bit operation - pixel OR shifted pixel's red or green or blue 
      case 2:
        {
          int rand = myRandomInt(pixelLength/8);
          color[] original = pix.clone();
          int swtch = randomInt(3);
          switch(swtch) {
          case 0: 
            {
              for (int i = beginIndex; i < endIndex; i++) {
                pix[i%pixelLength] = pix[i%pixelLength] | getR(original[(i+rand)%pixelLength]) ;
              }
              break;
            }
          case 1: 
            {
              for (int i = beginIndex; i < endIndex; i++) {
                pix[i%pixelLength] = pix[i%pixelLength] | getG(original[(i+rand)%pixelLength]) ;
              }
              break;
            }
          case 2: 
            {
              for (int i = beginIndex; i < endIndex; i++) {
                pix[i%pixelLength] = pix[i%pixelLength] | getB(original[(i+rand)%pixelLength]) ;
              }
              break;
            }
          }
          break;
        }
        //bit operation - pixel OR shifted pixel (this is not additive synthesis)
      case 3:
        {
          int rand = myRandomInt(pixelLength);
          for (int i = beginIndex; i < endIndex; i++) {
            pix[i%pixelLength] |= pix[(i+rand)%pixelLength];
          }
          break;
        }
        //bit operation - pixel AND shifted pixel 
      case 4:
        {
          color[] original = pix.clone();
          int rand = myRandomInt(pixelLength);
          for (int i = beginIndex; i < endIndex; i++) {
            pix[i%pixelLength] &= original[(i+rand)%pixelLength];
          }
          break;
        }
        //SUBTRACT shifted pixel FROM pixel (this is not subtractive synthesis)
      case 5:
        {
          color[] original = pix.clone();
          int rand = myRandomInt(pixelLength);
          for (int i = beginIndex; i < endIndex; i++) {
            pix[i%pixelLength] -= original[(i+rand)%pixelLength];
          }
          break;
        }
        //ADD shifted pixel TO pixel (this is not additive synthesis)
      case 6:
        {
          color[] original = pix.clone();
          int rand = myRandomInt(pixelLength);
          for (int i = beginIndex; i < endIndex; i++) {
            pix[i%pixelLength] += original[(i+rand)%pixelLength];
          }
          break;
        }
        //MULTIPLY pixel BY shifted pixel (this is not multiplicative synthesis)
      case 7:
        {
          color[] original = pix.clone();
          int rand = myRandomInt(pixelLength);
          for (int i = beginIndex; i < endIndex; i++) {
            pix[i%pixelLength] *= original[(i+rand)%pixelLength];
          }
          break;
        }
      }
    }
    //Shift pixel.
    pix = shiftPixel(pix);
    //New PImage for return
    PImage _img = createImage(width, height, RGB);
    _img.pixels = pix;
    return _img;
  }

  int[] shiftPixel( int[] input) {
    int[] ret = new int[input.length];
    for (int i = 0; i < pixelLength; i++) {
      ret[i] = input[(i+amountOfShift)%pixelLength];
    }
    return ret;
  }

  int getR (int c) {
    c = c & 0xFF0000;
    return c;
  }
  int getG (int c) {
    c = c & 0xFF00;
    return c;
  }
  int getB (int c) {
    c = c & 0xFF;
    return c;
  }

  int randomInt (int i) {
    return int(random(i));
  }
  int randomInt (int i, int j) {
    return int(random(i, j));
  }
  int myRandomInt(int i) {
    //return between 0 to i-1
    double num = -1;
    while (num < 0) {
      num = rnd.nextGaussian();
    }
    num *= i/2;
    return (int)(num%i);
  }
}