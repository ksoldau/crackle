// Stanley Sloth
class Jungle2 extends Habitat {
  int frame;
  int numTalkingFrames = 10;

  int animalLeft = 400;
  int animalTop = 40;
  int animalSleepingLeft = 200;
  int animalSleepingTop = 200;


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

  int rockx = 800;
  int rocky = 100;

  //if POLAR_A
  boolean vines_cut = false;
  int vinex = 200; 
  int viney = 0;

  Jungle2(boolean isSleeping) {
    super(isSleeping);
    if (isSleeping || USER != "GORILLA_A") {
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
  void display() {
    image(this.background, 0, 0);

    if (USER == "GORILLA_A") {
      displayTrash();
    }
    else if (USER == "COBRA_B") {
      displayRock();
    }
    else if (USER == "POLAR_A") {
      displayVines();
    }
  }


  void displayVines() {
    if (vines_cut) {
      image(VINES_CUT_IMAGE, vinex, viney);
    }
    else {
      image(VINES_IMAGE, vinex, viney);
    }
  }
  //displays the trash
  //assume: not sleeping
  void displayTrash() {
    if (!pickedUpTrash1) {
      image(TRASH_IMAGE, trash1_x, trash1_y); //change
    }
    if (!pickedUpTrash2) {
      image(TRASH_IMAGE, trash2_x, trash2_y);
    }
    if (!pickedUpTrash3) {
      image(TRASH_IMAGE, trash3_x, trash3_y);
    }
  }

  //displayrock when necessary
  //assume on COBRA_B
  void displayRock() {
    image(ROCK_IMAGE, rockx, rocky);
  }

  //display the correct animal image
  void displayAnimal() {
    if (isSleeping) {
      image(SLEEP_TEST, animalSleepingLeft, animalSleepingTop);
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
    image(GIFS_SLOTH_TALKING[0], animalLeft, animalTop);
  }

  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if ((USER == "POLAR_A") && (JUNGLE2_STATE == 1) && cursorOverVines()) {
      vines_cut = true;
      JUNGLE2_STATE ++; 
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
    else if ((USER == "COBRA_B") && (JUNGLE2_STATE == 2) && cursorOverRock()) {
      rockx = rockx - 100; //move the rock
      JUNGLE2_STATE ++; //update state
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
      playCurrentTalk();
    }
    else if (cursorOverAnimal() && (JUNGLE2_STATE == 2) && USER == "GORILLA_B") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) { 
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
      playCurrentTalk();
    }
    else if (cursorOverTrash1() && (USER == "COBRA_B" ) {
      pickedUpTrash1 = true;
      JUNGLE2_STATE ++; // so Stanley Sloth will say next line
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

  //play correct audio
  void playCurrentTalk() {
    println(JUNGLE2_STATE);
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    updateStateNumbers();
  }

  void updateStateNumbers() {
    println("got to update statenumbers");
    println(USER == "GORILLA_B");
    if (USER == "GORILLA_A") {
      if (JUNGLE2_STATE == 1) {
        JUNGLE2_STATE ++;
        ASIA2_STATE ++; //Patty Panda
        HELP = 4; //*** later can make this be a token
      } 
      if (JUNGLE2_STATE == 3) {
        JUNGLE2_STATE ++;
        AFRICA3_STATE ++;
        nav.clue4 = true; //fur is black
        HELP = 2;
      }
    }
    else if (USER == "GORILLA_B") {
      if (JUNGLE2_STATE == 1) {
        JUNGLE2_STATE ++;
        //Finish
      }
    }
    else if (USER == "COBRA_A") {
    }
    else if (USER == "COBRA_B") {
      if (JUNGLE2_STATE == 1) { //stay same until pick up rock
        JUNGLE2_STATE ++;
      }
      else if (JUNGLE2_STATE == 3) {
        JUNGLE2_STATE ++;
        ASIA2_STATE ++;
        nav.clue3 = true;
        HELP = 4; //Patty Panda
      }
    }
    else if (USER == "POLAR_A") {
      if (JUNGLE2_STATE == 1) {
        nav.clue4 = true;
      }
      if (JUNGLE2_STATE == 2) {
        JUNGLE2_STATE ++;
        HELP = 1; //Gerry Giraffe
        AFRICA2_STATE ++;
      }
    }
    else if (USER == "POLAR_B") {
    }
  }

  //determines if cursor over any elements
  boolean cursorOverElement() {
    return cursorOverRock() || cursorOverTrash() || cursorOverVines();
  }

//determines if the cursor is over the vines
  boolean cursorOverVines() {
    return (USER == "POLAR_A") && (JUNGLE2_STATE == 1) && 
      ((vinex < mouseX) && (mouseX < (vinex + 200))) 
      && ((viney < mouseY) && (mouseY < (viney + 540)));
  }
  //determines if cursor over the rock 
  //assume: it should be clicked on
  boolean cursorOverRock() {
    return (USER == "COBRA_B") && (JUNGLE2_STATE ==  2) &&
      ((rockx < mouseX) && (mouseX < (rockx + 60))) 
      && ((rocky < mouseY) && (mouseY < (rocky + 45)));
  }


  //determines if cursor over any of the trash
  boolean cursorOverTrash() {
    return (USER == "GORILLA_A") && !isSleeping && 
      ((!pickedUpTrash1 && cursorOverTrash1()) ||
      (!pickedUpTrash2 && cursorOverTrash2()) ||
      (!pickedUpTrash3 && cursorOverTrash3()));
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
    if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
        && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return GA_SLOTH1;
      }
      else if (JUNGLE2_STATE == 2) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 3) {
        return GA_SLOTH2;
      }
      else if (JUNGLE2_STATE == 4) {
        return SLOTH_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return GB_SLOTH1;
      }
    }
    else if (USER == "POLAR_A") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return PA_SLOTH1;
      }
      else if (JUNGLE2_STATE == 2) {
        return PA_SLOTH2;
      }
      else if (JUNGLE2_STATE == 3) {
        return SLOTH_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      //Stanley Sloth is asleep
    }
    else if (USER == "COBRA_A") {
      //Stanley Sloth is asleep
    }
    else if (USER == "COBRA_B") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return CB_SLOTH1;
      }
      else if (JUNGLE2_STATE == 2) {
        return CB_SLOTH1;
      }
      else if (JUNGLE2_STATE == 3) {
        return CB_SLOTH2;
      }
      else if (JUNGLE2_STATE == 4) {
        return SLOTH_DUMMY;
      }
    }
    return SLOTH_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}

