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
  
  PImage animal_static_image = loadImage("data/calvin_camel_motion.gif");
  PImage animal_dynamic_image = loadImage("data/calvin_camel_motion.gif");

  
  Africa1(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/africa_1.png"); //background of habitat
  }
 
  void talkingCamelTest() {
   image(GIF_CAMEL_TALKING, animalLeft, animalTop);
  }
  
  void nottalkingCamelTest() {
    image(animal_static_image, animalLeft, animalTop);
  }
  
  //displays the background for the habitat
   public void display() {
    img = background;
    image(img, 0, 0);
  }
  
  //determines if the animal in the habitat was clicked on
  void displayAnimal() {
    // img.resize(0,1); how we will resize, it's kind of cheating, but it works
    //image(animal_dynamic_image, animalLeft, animalTop);
    image(animal_dynamic_image, animalLeft, animalTop);
    animal_dynamic_image.resize(100, 50);

  }
  
  //displays GIF of the animal talking
  void displayAnimalTalking() {
      GIF_CAMEL_TALKING.play();
  }
  
  //decides which actions to take if mouse was pressed 
  void mousePressedInHabitat() {
    if (!ANIMAL_TALKING && mousePressedAnimal()) { //later might not need not animal talking 
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
  
  //determines if the mouse get pressed on the Camel
  boolean mousePressedAnimal() {
    return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
    && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
  }
}
     
  
