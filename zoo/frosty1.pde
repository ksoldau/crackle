// Penguin
class Frosty1 {
  int state;
  boolean isSleeping;
  PImage background;
  
  Frosty1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/frosty_1.png");
  }
  
  // display the scene
  void display() {
    img = background;
    image(img, 0, 0);
  }
}
    
  
