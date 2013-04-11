// Elephant
class Jungle2 {
  int state;
  boolean isSleeping;
  PImage background;
  
  Jungle2(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/jungle_2.png");
  }
  
  // display the scene
  void display() {
    img = background;
    image(img, 0, 0);
  }
}
