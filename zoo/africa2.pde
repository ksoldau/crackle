// Gerry Giraffe
class Africa2 extends Habitat {
  int state;
  boolean isSleeping;
  
  int frame;
  int numTalkingFrames = 8;
  
  int animalLeft = 500;
  int animalTop = 100;
  
  PImage animal_not_talking = loadImage("data/gerry_giraffe.gif");
  PImage background = loadImage("data/africa_2.png");
  
  Africa2(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
  }
  //displays the background for the habitat
  public void display() {
    image(this.background, 0, 0);
  } 
  
  //determines if the animal in the habitat was clicked on
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
    image(GIFS_GIRAFFE_TALKING[frame], animalLeft, animalTop);
  }
  
  //display the not talking animal
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }
  
  //determines if the mouse was pressed on an animal
  boolean cursorOverAnimal() {
    boolean ans = ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    return ans;
  }
 
  void mousePressedInHabitat() {
    if (isSleeping) {}
    else if (cursorOverAnimal()) {
      GERRY_GIRAFFE_TEST.trigger(); //sound
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
    }
  }
  
  int lengthCurrentTalk() { 
    return 5000; 
  }
}
    
  
