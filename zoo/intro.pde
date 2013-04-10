class Intro {
  
  Intro() {}
PImage img;
  void display() {
    img = loadImage("data/youwin.png"); //note: not the correct graphic
    image(img, 0, 0);
  }
}
