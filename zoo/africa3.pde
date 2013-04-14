// Leonard Lion
class Africa3 extends Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  PImage animal_static_image = loadImage("data/leonard_lion.gif");
  
  Africa3(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.background = loadImage("data/africa_3.png");
  }
  
  
  //determines if the animal in the habitat was clicked on
  void displayAnimal() {
  // img.resize(0,1); how we will resize, it's kind of cheating, but it works
  image(animal_static_image, 500, 100);
  }
  
    //displays this habitat's background
  public void display() {
    /*PImage habitat_background;
    habitat_background = this.background;*/
    image(this.background, 0, 0);
  }
  
  void playAnimalTalking() {}
  
  // determines if 
  boolean cursorOverAnimal() {   
    return false;
  }
  
  void mousePressedInHabitat() {}
  
    
int lengthCurrentTalk() { return 0; }}
    
  
