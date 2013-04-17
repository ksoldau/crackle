// Stanley Sloth
class Jungle2 extends Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  PImage animal_not_talking;
  
  int frame;
  int numTalkingFrames = 10;

  int animalLeft = 500;
  int animalTop = 100;

  
  Jungle2(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.animal_not_talking = loadImage("data/stanley_sloth.gif");
   this.background = loadImage("data/jungle_2.png");
  }
  
  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);}
  
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
    image(GIFS_SLOTH_TALKING[frame], animalLeft, animalTop);
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
      baron.trigger(); //sound
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
    }
  }
  
  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
  return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    
  }
  
  int lengthCurrentTalk() {
    return 3000; 
  }
}
     
