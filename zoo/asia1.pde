// Tina Tiger
class Asia1 {
  int state;
  boolean isSleeping;
  PImage background;
  
  Asia1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/asia_1.png");
  }
  
  // display the scene
  void display() {
    img = background;
    image(img, 0, 0);
  }
}
    
  
