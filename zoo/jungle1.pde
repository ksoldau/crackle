// Eliza Elephant
class Jungle1 {
  int state;
  boolean isSleeping;
  PImage background;
  
  Jungle1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/jungle_1.png");
  }
  
  // display the scene
  void display() {
    img = this.background;
    image(img, 0, 0);
  }
}
    
  
