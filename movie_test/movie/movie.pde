import processing.video.*;
Movie myMovie;

void setup() {
  size(960, 540);
  myMovie = new Movie(this, "opening.mov");
  myMovie.loop();
}

void draw() {
  image(myMovie, 0, 0);
}

// Called every time a new frame is available to read
/*void movieEvent(Movie m) {
  m.read();
}

*/

