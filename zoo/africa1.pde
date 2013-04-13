// Calvin Camel
class Africa1 extends Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  
  // position of animal 
  int animalLeft = 500;
  int animalTop = 100;
  
  PImage animal_static_image = loadImage("data/calvin_camel.gif");
  PImage animal_dynamic_image = loadImage("data/calvin_camel_motion.gif");

  
  Africa1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/africa_1.png"); //background of habitat
  }
 
  void talkingCamelTest() {
    image(GIF_CAMEL_TALKING, 10, 10);
  }
  
  //displays the background for the habitat
   public void display() {
    img = background;
    image(img, 0, 0);
  }
  
  //determines if the animal in the habitat was clicked on
  void displayAnimal() {
    // img.resize(0,1); how we will resize, it's kind of cheating, but it works
    image(animal_dynamic_image, animalLeft, animalTop);
  }
  
  void displayAnimalMoving() {
    image(animal_dynamic_image, animalLeft, animalTop);
     GIF_CAMEL_TALKING.play();
  }
  
  //displays GIF of the animal talking
  void displayAnimalTalking() {
      image(GIF_CAMEL_TALKING, animalLeft, animalTop);
      GIF_CAMEL_TALKING.play();
  }
  
  //decides which actions to take if mouse was pressed 
  void mousePressedInHabitat() {
    if (mousePressedAnimal()) {
      displayAnimalMoving();
      baron.trigger(); //sound
    }
  }
  
  //determines if the mouse get pressed on the Camel
  boolean mousePressedAnimal() {
    return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
  }
}
     
  
