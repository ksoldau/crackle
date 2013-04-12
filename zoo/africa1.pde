// Calvin Camel
class Africa1 {
  int state;
  boolean isSleeping;
  PImage background;
  
  Africa1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/africa_1.png");
  }
  
  // display the scene
  void display() {
    img = background;
    image(img, 0, 0);
  }
  
  void displayCamel() {
    img = loadImage("data/calvin_camel.gif");
    // img.resize(0,1); how we will resize, it's kind of cheating, but it works
    image(img, 600, 100);
  }
}
    
  
