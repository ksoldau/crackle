// Intro class for when animal first coming out of box
// after user has hit the start button
class Intro {
  
  Intro() {}
  
PImage img;
  void display() {
    img = loadImage("data/box.png"); 
    image(img, 0, 0);
  }
}
