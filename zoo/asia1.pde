// Tina Tiger
class Asia1 extends Habitat {
  int state;
  boolean isSleeping;
  PImage background;
  PImage animal_not_talking;
  
  int animalLeft = 500;
  int animalTop = 100;
  
  int frame;
  int numTalkingFrames;
  
  Asia1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.animal_not_talking = loadImage("data/tina_tiger.gif");
    this.background = loadImage("data/asia_1.png");
    this.numTalkingFrames = 8;
  }
  
    //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }
  
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_TIGER_TALKING[frame], animalLeft, animalTop);
  }
  
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }
  
  //determines if the animal in the habitat was clicked on
  void displayAnimal() {
    if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { displayAnimalNotTalking(); }
  }
  
  boolean cursorOverAnimal() {
    boolean ans = ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    return ans;
  }
  
  void mousePressedInHabitat() {
    if (cursorOverAnimal()) {
      doAsia1();
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
    }
  }  
    
int lengthCurrentTalk() { return 5000; }
}
    

  
 
 
 
  
  
