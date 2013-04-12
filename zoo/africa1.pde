// Calvin Camel
class Africa1 implements Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  
  // position of animal 
  int animalLeft = 500;
  int animalTop = 100;
  
  PImage animal_static_image = loadImage("data/calvin_camel.gif");
  
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
  
  void displayAnimal() {
    // img.resize(0,1); how we will resize, it's kind of cheating, but it works
    image(animal_static_image, animalLeft, animalTop);
  }
  
  boolean mousePressedAnimal() {
    (animalLeft < mouseX && mouseX < 700) && 
    (animalTop < mouseY  && mouseY < (animalTop + 200));
  }
}
     
  
