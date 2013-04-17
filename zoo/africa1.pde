int LENGTH_CAMEL_HOW_DOIN = 5700;

// Calvin Camel
class Africa1 extends Habitat {
  int state;
  boolean isSleeping;
  
  int frame;
  int numTalkingFrames = 6;
  
  int animalLeft = 500;
  int animalTop = 100;
  
  PImage animal_not_talking = loadImage("data/sam_sealion.gif");
  PImage background = loadImage("data/africa_1.png");
  
  Africa1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
  }
  
  //display the background for this class
  public void display() {
    image(this.background, 0, 0);
  } 
 
 //display the correct animal image
 void displayAnimal() {
   if (ANIMAL_TALKING) {
     displayAnimalTalking();
   }
   else { displayAnimalNotTalking(); }
 }
 
 //display the talking animal
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_CAMEL_TALKING[frame], animalLeft, animalTop);
  }
  
  //display the not talking animal 
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }
  
  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  void mousePressedInHabitat() {
    if (cursorOverAnimal()) { 
      ANIMAL_TALKING = true;
      CALVIN_CAMEL_TEST.trigger(); //sound
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
    }
  }
  
  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
  return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    
  }
  
  int lengthCurrentTalk() {
    return LENGTH_CAMEL_HOW_DOIN; //lol
  }
}
     
  
