public abstract class Habitat { 
  
  PImage background =  loadImage("data/africa_1.png");  
  
  //displays the background of the scene
  public abstract void display();
  
  //displays the animal
  public abstract void displayAnimal();
  
  //determines if the animal in the habitat was clicked on
  public abstract boolean cursorOverAnimal();
  
  //decides which actions to take if mouse was pressed in this habitat
  public abstract void mousePressedInHabitat();
}
