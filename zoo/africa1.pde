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
  
  Africa1(int state, boolean isSleeping) { //isSleeping too
    super(isSleeping);
    this.state = state;
    this.isSleeping = isSleeping;
  }
  
  //display the background for this class
  public void display() {
    image(this.background, 0, 0);
  } 
 
 //display the correct animal image
 void displayAnimal() {
   if (isSleeping) {
     image(SLEEP_TEST, animalLeft, animalTop);
   }
   else if (ANIMAL_TALKING) {
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
    if (isSleeping) {}
    else if (cursorOverAnimal()) { 
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      CALVIN_CAMEL_TEST.trigger(); //sound
    }
  }
  
  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
  return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    
  }
  
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {}
    else if (USER == "GORILLA_B") {}
    else if (USER == "POLAR_A") {}
    else if (USER == "POLAR_B") {}
    else if (USER == "COBRA_A") {}
    else if (USER == "COBRA_B") {}
          return CALVIN_CAMEL_TEST; //this is just so it doesn't yell at us for now, delete it later!
  }
}
     
  
