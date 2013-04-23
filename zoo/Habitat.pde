public abstract class Habitat { 

  boolean isSleeping;
  
  int frameZs = 0; 

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
  
  //display the Zs (when mouse over sleeping animal)
  void displayZs() {
    frameZs = (frameZs + 1);
    if (frameZs < 13) {
      image(GIFS_ZS[frameZs], 200, 200);
    }
    else {
      Z = false;
      frameZs = 0;
    }
  }
  
    //decides what to do if something moused over
  void mouseMovedInHabitat() {
    if (this.isSleeping && cursorOverAnimal()) {
      Z = true;
      println(Z);
      //displayZs();
    }
  }
}

