// Eliza Elephant
class Jungle1 extends Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background; 
  PImage animal_not_talking = loadImage("data/eliza_elephant.gif");
  
  int frame;
  int numTalkingFrames = 16;

  int animalLeft = 500;
  int animalTop = 100;

  
  Jungle1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.animal_not_talking = loadImage("data/eliza_elephant.gif");
   this.background = loadImage("data/jungle_1.png");
  }

    //displays this habitat's background
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
    image(GIFS_ELEPHANT_TALKING[frame], animalLeft, animalTop);
  }
  
  //display the not talking animal 
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }
  
  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  void mousePressedInHabitat() {
    if (cursorOverAnimal()) {
      ELIZA_ELEPHANT_TEST.trigger(); //sound 
      ANIMAL_TALKING = true;
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
     
