public abstract class Habitat { 
  
  boolean isSleeping;
  
  Habitat(boolean isSleeping) {
    this.isSleeping = isSleeping;
  } 
  
  PImage background =  loadImage("data/africa_1.png");  
  
  //displays the background of the scene
  abstract void display();
  
  //displays the animal
  public abstract void displayAnimal();
  
  //determines if cursor over animal in the habitat
  public abstract boolean cursorOverAnimal();
  
  //decides which actions to take if mouse was pressed in this habitat
  public abstract void mousePressedInHabitat();
  
  //determines length of current talk animal is on in milliseconds
  abstract int lengthCurrentTalk();
  
}
