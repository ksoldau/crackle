import gifAnimation.*;

int LENGTH_CAMEL_HOW_DOIN = 5700;
// Calvin Camel
class Africa1 extends Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  
  // position of animal 
  int animalLeft = 500;
  int animalTop = 100;
  
  PImage animal_not_talking;
  
  Africa1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.animal_not_talking = loadImage("data/sam_sealion.gif");
    //this.background = loadImage("data/africa_1.png"); //background of habitat
  }
 
 void displayAnimal() {
   if (ANIMAL_TALKING) {
     displayAnimalTalking();
   }
   else { displayAnimalNotTalking(); }
 }
 
  void displayAnimalTalking() {
   image(GIF_CAMEL_TALKING, animalLeft, animalTop);
  }
  
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }
  
  //displays the background for the habitat
  public void display() {
    image(this.background, 0, 0);
  } 

  //displays GIF of the animal talking
  void playAnimalTalking() {
      GIF_CAMEL_TALKING.play();
  }
  
  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  void mousePressedInHabitat() {
    if (cursorOverAnimal()) { 
      doAfrica1(); // cleans the scene (somehow)
      ANIMAL_TALKING = true;
      playAnimalTalking();
      baron.trigger(); //sound
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
    }
  }
  
  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
  /*  boolean ans =  60 > mouseX;
    println(ans);
    return ans; */
  return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    
  }
  
  int lengthCurrentTalk() {
    return LENGTH_CAMEL_HOW_DOIN;
  }
}
     
  
