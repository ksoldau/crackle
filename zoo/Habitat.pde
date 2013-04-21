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
  
  //decides what to do if moused over in habitat
  //abstract void mouseOverInHabitat();
  
  //determines what the current talk is 
  abstract AudioSample currentTalk(); 
  
  //plays correct lines for animal
  abstract void playCurrentTalk();
  
  //updates necessary state numbers for habitats/animals
  abstract void updateStateNumbers();
}
