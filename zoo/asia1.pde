// Tina Tiger
class Asia1 extends Habitat {
  int state;
  boolean isSleeping;
  PImage background;
  PImage animal_static_image = loadImage("data/tina_tiger.gif");
  
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
  
  //determines if the animal in the habitat was clicked on
  void displayAnimal() {
  // img.resize(0,1); how we will resize, it's kind of cheating, but it works
  image(animal_static_image, 500, 100);
  }
  
  void playAnimalTalking() {}
  
  boolean cursorOverAnimal() {    return false;
  }
  
  void mousePressedInHabitat() {}
}
    
  
