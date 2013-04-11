// Lion
class Africa3 {
  int state;
  boolean isSleeping;
  PImage background;
  
  Africa3(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/africa_3.png");
  }
  
  // display the scene
  void display() {
    img = background; 
    image(img, 0, 0);
  }
}
    
  
