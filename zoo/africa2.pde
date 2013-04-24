// Gerry Giraffe
class Africa2 extends Habitat {
  int frame;
  int numTalkingFrames = 8;

  int animalLeft = 500;
  int animalTop = 100;
  
  PImage background = loadImage("data/africa_2.png");
  PImage animal_sleeping;

  Africa2(boolean isSleeping) {
    super(isSleeping, 400, 100);
    if (isSleeping) {
     animal_sleeping = loadImage("data/gerry_sleep_288.png");
    }
  }
  //displays the background for the habitat
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
  } 

  //determines if the animal in the habitat was clicked on
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

  //display the talking animal
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_GIRAFFE_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_GIRAFFE_TALKING[0], animalLeft, animalTop);
  }

  //determines if the mouse was pressed on an animal
  boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 200)))
      && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else { 
    return ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
      && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

//decides what to do if the mouse was pressed in the habitat
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (AFRICA2_STATE == 2) && USER == "POLAR_A") {
      WIN.doGuess();
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

  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
    } //Gerry Giraffe is asleep
    else if (USER == "GORILLA_B") {
      if (AFRICA2_STATE == 1) {
        AFRICA2_STATE ++;
        FROSTY1_STATE ++;
        NAV.clue2 = true; //climb trees
        HAS_ITEM = true;
        HELP = 5; //Peter Penguin
      }
    }
    else if (USER == "COBRA_A") {
    } //Gerry Giraffe is asleep
    else if (USER == "COBRA_B") {
      if (AFRICA2_STATE == 0) {
        AFRICA2_STATE ++;
        AFRICA3_STATE ++;
        HELP = 2;//Leonard Lion
      }
      if (AFRICA2_STATE == 2) {
        AFRICA2_STATE ++;
        ASIA2_STATE ++; //Patty Panda
        HELP = 4; //Patty Panda
      }
    }
    else if (USER == "POLAR_A") {
      if (AFRICA2_STATE == 1) {
        AFRICA2_STATE ++;
      }
    }
    else if (USER == "POLAR_B") {
      if (AFRICA2_STATE == 1) {
        AFRICA2_STATE ++;
        JUNGLE1_STATE ++;
        NAV.clue1 = true; //four paws
        HELP = 7; //Eliza Elephant
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
    } //Gerry Giraffe is asleep
    else if (USER == "GORILLA_B") {
      if (AFRICA2_STATE == 0) {
        return GIRAFFE_DUMMY;
      }
      else if (AFRICA2_STATE == 1) {
        return GB_GIRAFFE1;
      }
      else if (AFRICA2_STATE == 2) {
        return GIRAFFE_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      if (AFRICA2_STATE == 0) {
        return GIRAFFE_DUMMY;
      }
      else if (AFRICA2_STATE == 1) {
        return PA_GIRAFFE1;
      }
      else if (AFRICA2_STATE == 2) {
        return PA_GIRAFFE2;
      }
    }
    else if (USER == "POLAR_B") {
      if (AFRICA2_STATE == 0) {
        return GIRAFFE_DUMMY;
      }
      else if (AFRICA2_STATE == 1) {
        return PB_GIRAFFE1;
      }
      else if (AFRICA2_STATE == 2) {
        return GIRAFFE_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      //Gerry Giraffe is asleep
    }
    else if (USER == "COBRA_B") {
      if (AFRICA2_STATE == 0) {
        return CB_GIRAFFE1;
      }
      else if (AFRICA2_STATE == 1) {
        return GIRAFFE_DUMMY;
      }
      else if (AFRICA2_STATE == 2) {
        return CB_GIRAFFE2;
      }
      else if (AFRICA2_STATE == 3) {
        return GIRAFFE_DUMMY;
      }
    }
    return GIRAFFE_DUMMY;
    //this is just so it doesn't yell at us for now, delete it later!
  }
}


