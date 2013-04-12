// Gerry Giraffe
class Africa2 {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  PImage animal_static_image = loadImage("data/gerry_giraffe.gif");
  
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
  
  void displayAnimal() {
    // img.resize(0,1); how we will resize, it's kind of cheating, but it works
    image(animal_static_image, 500, 100);
  }
}
    
  
