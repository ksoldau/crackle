// Gerry Giraffe
class Africa2 extends Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  PImage animal_not_talking;
  
  int animalLeft = 500;
  int animalTop = 100;
  
  Africa2(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
     this.animal_not_talking = loadImage("data/gerry_giraffe.gif");
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
    boolean ans = ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    return ans;
  }
 
  
  void mousePressedInHabitat() {
    if (cursorOverAnimal()) {
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
    
  
