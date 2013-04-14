// Tina Tiger
class Asia1 extends Habitat {
  int state;
  boolean isSleeping;
  PImage background;
  PImage animal_not_talking = loadImage("data/tina_tiger.gif");
  
  int animalLeft = 500;
  int animalTop = 100;
  
  Asia1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/asia_1.png");
  }
  
    //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }
  
    void displayAnimalTalking() {
   image(GIF_TIGER_TALKING, animalLeft, animalTop);
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
  
  void playAnimalTalking() {
    GIF_TIGER_TALKING.play();
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
      playAnimalTalking();
      ANIMAL_TALKING_START_TIME = millis();
    }
  }  
    
int lengthCurrentTalk() { return 5000; }
}
    

  
 
 
 
  
  
