// Leonard Lion
class Africa3 extends Habitat {
  int frame;
  int numTalkingFrames = 10; 

  int animalLeft = 300;
  int animalTop = 50;

  PImage background = loadImage("data/africa_3.png");

  PImage animal_sleeping;

  Africa3(boolean isSleeping) {
    super(isSleeping, 200, 200);
    if (isSleeping) {
      animal_sleeping = loadImage("data/sleep/leonard_sleep_288.png");
    }
  }


  //displays the correct animal
  void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, sleepingx, sleepingy);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //display the talking anial
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_LION_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_LION_TALKING[0], animalLeft, animalTop);
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
    displayAnimal();
  }

  // determines if 
  boolean cursorOverAnimal() {   
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 270)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 270)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 250)));
    }
  }

  //decides what to do if the mouse was pressed in the habitat
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }


  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    updateStateNumbers();
  }

  //updates the state numbers to get  next line
  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (AFRICA3_STATE == 1) {
        AFRICA3_STATE ++;
        JUNGLE2_STATE ++; //SLOTH
        HELP = 8;
      }
      if (AFRICA3_STATE == 3) {
        AFRICA3_STATE ++; //to get to final screen kind of
      }
    }
    else if (USER == "GORILLA_B") {
    }//Leonard Lion is asleep
    else if (USER == "COBRA_A") {
      if (AFRICA3_STATE == 1) {
        AFRICA3_STATE ++;
        ASIA2_STATE ++;
        NAV.clue2 = true;
        HELP = 4; //Patty Panda
      }
    }
    else if (USER == "COBRA_B") {
      if (AFRICA3_STATE == 1) {
        AFRICA3_STATE++;
        ASIA1_STATE ++;
        NAV.clue1 = true;
        HELP = 3;//Tina Tiger
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (AFRICA3_STATE == 0) { 
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 1) {
        return GA_LION1;
      }
      else if (AFRICA3_STATE == 2) {
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 3) {
        return GA_LION2;
      }
      //  else if (AFRICA3_STATE == 4) {
      //  return GA_LION3;
      //}
    }
    else if (USER == "GORILLA_B") {
    } //Leonard Lion is sleeping
    else if (USER == "POLAR_A") {
      //Leonard Lion is asleep
    }
    else if (USER == "POLAR_B") {
      //Leonard Lion is asleep
    }
    else if (USER == "COBRA_A") {
      if (AFRICA3_STATE == 0) {
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 1) {
        return CA_LION1;
      }
      else if (AFRICA3_STATE == 2) {
        return LION_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      if (AFRICA3_STATE == 0) {
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 1) {
        return CB_LION1;
      }
      else if (AFRICA3_STATE == 2) {
        return LION_DUMMY;
      }
    }

    return LION_DUMMY;
  }
}


