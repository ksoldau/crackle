// Arrows
class Arrows {
  PImage background;
  
  Arrows() {
    this.background = loadImage("data/arrows.png");
  }
  
  // display the scene
  void display() {
    img = this.background;
    image(img, 0, 0);
  }
}
    
  
