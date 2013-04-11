// Giraffe
class Africa2 {
  int state;
  boolean isSleeping;
  PImage background;
  
  Africa2(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/africa_2.png");
  }
  
  // display the scene
  void display() {
    img = background;
    image(img, 0, 0);
  }
}
    
  
