
//This program is an effect like glitch.
//This class use java.util.Random.


//********** sample program **********


//Set the movie path.
String MOVIE_DIR = "";

//Set the movie width and height.
int MOVIE_WIDTH = 640;
int MOVIE_HEIGHT = 360;

//If you set this parameter false,
//amount of shift of pixels are going to change
//when the function display() in the class Glitch called.
boolean PIXEL_SHIFT_STATIC = true;


//////////*//////////*//////////*//////////*//////////*//////////

import processing.video.*;

Movie movie;
Glitch g;

void settings(){
  size(MOVIE_WIDTH, MOVIE_HEIGHT);
}

void setup() {
  movie = new Movie (this, MOVIE_DIR);
  g = new Glitch(PIXEL_SHIFT_STATIC);
  movie.loop();
  frameRate(60);
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  image (movie, 0, 0);
  g.display();
}

void keyPressed() {
  g.glitchOn();
}

void keyReleased() {
  g.glitchOff();
}