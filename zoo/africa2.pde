// Gerry Giraffe
class Africa2 extends Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  PImage animal_not_talking = loadImage("data/gerry_giraffe.gif");
  
  int animalLeft = 500;
  int animalTop = 100;
  
  Africa2(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/africa_2.png");
  }
  //displays the background for the habitat
  public void display() {
    image(this.background, 0, 0);
  } 
  
  //determines if the animal in the habitat was clicked on
  void displayAnimal() {
    if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { displayAnimalNotTalking(); }
  }
 
  void displayAnimalTalking() {
   image(GIF_GIRAFFE_TALKING, animalLeft, animalTop);
  }
  
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }
  
  void playAnimalTalking() {
    GIF_GIRAFFE_TALKING.play();
  }
  
  //determines if the mouse was pressed on an animal
  boolean cursorOverAnimal() {
    return ((animalLeft < mouseX) && (mouseX < (animalLeft + 100)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 100)));
  }
 
  
  void mousePressedInHabitat() {
    if (true) {
      doAfrica2();
      ANIMAL_TALKING = true;
      playAnimalTalking();
      ANIMAL_TALKING_START_TIME = millis();
    }
  }
  
  int lengthCurrentTalk() { 
    return 5000; 
  }
}
    
  
