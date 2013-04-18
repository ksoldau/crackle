// Stanley Sloth
class Jungle2 extends Habitat {
  int state;
  boolean isSleeping;

  int frame;
  int numTalkingFrames = 10;

  int animalLeft = 500;
  int animalTop = 100;

  PImage background = loadImage("data/jungle_2.png");
  PImage animal_not_talking = loadImage("data/stanley_sloth.gif");

  //did User pick up the trash
  boolean pickedUpTrash1;
  int trash1_x = 50;
  int trash1_y = 100;
  boolean pickedUpTrash2;
  int trash2_x = 150; 
  int trash2_y = 100;
  boolean pickedUpTrash3;
  int trash3_x = 250;
  int trash3_y = 100;

  Jungle2(int state, boolean isSleeping) {
    super(isSleeping);
    this.state = state;
    this.isSleeping = isSleeping;
    if (isSleeping) {
      this.pickedUpTrash1 = true;
      this.pickedUpTrash2 = true;
      this.pickedUpTrash3 = true;
    }
    if (!isSleeping) {
      this.pickedUpTrash1 = false;
      this.pickedUpTrash2 = false;
      this.pickedUpTrash3 = false;
    }
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
    if (!isSleeping) {
      displayTrash();
    }
  }

  //displays the trash
  //assume: not sleeping
  void displayTrash() {
    if (!pickedUpTrash1) {
      image(TRASH_TEST, trash1_x, trash1_y); //change
    }
    if (!pickedUpTrash2) {
      image(TRASH_TEST, trash2_x, trash2_y);
    }
    if (!pickedUpTrash3) {
      image(TRASH_TEST, trash3_x, trash3_y);
    }
  }

  //display the correct animal image
  void displayAnimal() {
    if (isSleeping) {
      image(SLEEP_TEST, animalLeft, animalTop);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //display the talking animal
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_SLOTH_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal 
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }

  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) { 
      STANLEY_SLOTH_TEST.trigger(); //sound
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
    }
    else if (cursorOverTrash1()) {
      pickedUpTrash1 = true;
    }
    else if (cursorOverTrash2()) {
      pickedUpTrash2 = true;
    }
    else if (cursorOverTrash3()) {
      pickedUpTrash3 = true;
    }
  }

    //determines if mouse over trash1
  boolean cursorOverTrash1() {
    return ((trash1_x < mouseX) && (mouseX < (trash1_x + 100))) 
      && ((trash1_y < mouseY) && (mouseY < (trash1_y + 100)));
  }
  //determines if mouse over trash2
  boolean cursorOverTrash2() {
    return ((trash2_x < mouseX) && (mouseX < (trash2_x + 100))) 
      && ((trash2_y < mouseY) && (mouseY < (trash2_y + 100)));
  }
  //determines if mouse over trash3
  boolean cursorOverTrash3() {
    return ((trash3_x < mouseX) && (mouseX < (trash3_x + 100))) 
      && ((trash3_y < mouseY) && (mouseY < (trash3_y + 100)));
  }

  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
    return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
      && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
    }
    else if (USER == "GORILLA_B") {
    }
    else if (USER == "POLAR_A") {
    }
    else if (USER == "POLAR_B") {
    }
    else if (USER == "COBRA_A") {
    }
    else if (USER == "COBRA_B") {
    }
    return CALVIN_CAMEL_TEST; //this is just so it doesn't yell at us for now, delete it later!
  }
}

