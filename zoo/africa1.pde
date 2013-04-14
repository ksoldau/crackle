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
  
  PImage animal_not_talking = loadImage("data/calvin_camel_motion.gif");

  
  Africa1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/africa_1.png"); //background of habitat
  }
 
  void talkingCamelTest() {
   image(GIF_CAMEL_TALKING, animalLeft, animalTop);
  }
  
  void nottalkingCamelTest() {
    image(animal_not_talking, animalLeft, animalTop);
  }
  
  //displays the background for the habitat
   public void display() {
    img = background;
    image(img, 0, 0);
  }
  
  //determines if the animal in the habitat was clicked on
  void displayAnimal() {
    image(animal_not_talking, animalLeft, animalTop);
    animal_not_talking.resize(100, 50);

  }
  
  //displays GIF of the animal talking
  void displayAnimalTalking() {
      GIF_CAMEL_TALKING.play();
  }
  
  //decides which actions to take if mouse was pressed 
  void mousePressedInHabitat() {
    if (!ANIMAL_TALKING && cursorOverAnimal()) { //later might not need not animal talking 
    // because won't let mouse presses happen if it is
      ANIMAL_TALKING = true;
      doAfrica1();
      displayAnimalTalking();
      baron.trigger(); //sound
      START_TIME = millis();
      //int s = second();
      //while (s <= (second() + 5)) {
       // baron.trigger();
      //}
    }
  }
  
  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
    return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
  }
}
     
  
