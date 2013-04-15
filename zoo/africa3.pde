// Leonard Lion
class Africa3 extends Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  PImage animal_not_talking;
  
  int frame;
  int numTalkingFrames;
  
  Africa3(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.animal_not_talking = loadImage("data/leonard_lion.gif");
    this.background = loadImage("data/africa_3.png");
  }
  
  
  //determines if the animal in the habitat was clicked on
  void displayAnimal() {
  // img.resize(0,1); how we will resize, it's kind of cheating, but it works
  image(animal_not_talking, 500, 100);
  }
  
    //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }
    
  // determines if 
  boolean cursorOverAnimal() {   
    return false;
  }
  
  void mousePressedInHabitat() {}
  
    
int lengthCurrentTalk() { return 0; }}
    
  
