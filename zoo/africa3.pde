// Leonard Lion
class Africa3 extends Habitat {
  int state;
 // boolean isTalking;
  boolean isSleeping;
  PImage background;
  PImage animal_not_talking;
  
  int frame;
  int numTalkingFrames;
  
  int animalLeft = 500;
  int animalTop = 100;
  
  Africa3(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.animal_not_talking = loadImage("data/leonard_lion.gif");
    this.background = loadImage("data/africa_3.png");
    this.numTalkingFrames = 6;
  }
  
  
  //displays the correct animal
  void displayAnimal() {
   if (ANIMAL_TALKING) {
     displayAnimalTalking();
   }
   else { displayAnimalNotTalking(); }
   }
   
   //display the talking anial
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_LION_TALKING[frame], animalLeft, animalTop);
  }
  
  //display the not talking animal
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }
  
   //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }
    
  // determines if 
  boolean cursorOverAnimal() {   
    boolean ans = ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    return ans;
  }
  
  void mousePressedInHabitat() {
      if (cursorOverAnimal()) {
      doAfrica3();
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
    }
  }
  
    
int lengthCurrentTalk() { return 3000; }}
    
  
