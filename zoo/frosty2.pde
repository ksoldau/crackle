// Sam Seal
class Frosty2 extends Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  PImage animal_static_image = loadImage("data/sam_sealion.gif");
   //note: conor doesn't know difference between
  // seal and sea lion
  
  Frosty2(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.animal_static_image = loadImage("data/sam_sealion.gif");
    this.background = loadImage("data/frosty_2.png");
  }
  //displays this habitat's background
  public void display() {
    /*PImage habitat_background;
    habitat_background = this.background;*/
    image(this.background, 0, 0);}
  
  //determines if the animal in the habitat was clicked on
  void displayAnimal() {
  // img.resize(0,1); how we will resize, it's kind of cheating, but it works
  image(animal_static_image, 500, 100);
  }
  
  void playAnimalTalking() {}
  
  boolean cursorOverAnimal() {    return false;

  }

  void mousePressedInHabitat() {}
  
    
int lengthCurrentTalk() { return 0; }}
    
  
