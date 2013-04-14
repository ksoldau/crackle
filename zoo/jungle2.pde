// Stanley Sloth
class Jungle2 extends Habitat {
  int state;
  boolean isTalking;
  boolean isSleeping;
  PImage background;
  PImage animal_static_image; 
  
  Jungle2(int state, boolean isSleeping) {
    this.state = state;
    this.isSleeping = isSleeping;
    this.animal_static_image = loadImage("data/stanley_sloth.gif");
   this.background = loadImage("data/jungle_2.png");
  }
  
  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);}
  
  void displayAnimal() {
  //image(animal_static_image, 500, 100);
  }
  
  void playAnimalTalking() {}
  
  boolean cursorOverAnimal() {    
    return false;
  }
  
  void mousePressedInHabitat() {}
  
  int lengthCurrentTalk() { return 0; }
}
