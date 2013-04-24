// Tina Tiger
class Asia1 extends Habitat {
  int frame;
  int numTalkingFrames = 8;

  int animalLeft = 500;
  int animalTop = 100;

  PImage background = loadImage("data/asia_1.png");
  PImage animal_not_talking = loadImage("data/tina_tiger.gif");
  PImage animal_sleeping = loadImage("data/tina_sleep_288.png");

  Asia1(boolean isSleeping) {
    super(isSleeping, 300, 250);
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
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

  //displays the talking animal 
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_TIGER_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_TIGER_TALKING[0], animalLeft, animalTop);
  }

  //determines if the animal in the habitat was clicked on
  boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 220)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return  ((animalLeft + 50 < mouseX) && (mouseX < (animalLeft + 230)))
        && ((animalTop + 40 < mouseY) && (mouseY < (animalTop + 280)));
    }
  }

  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (ASIA1_STATE == 2) && USER == "COBRA_A") {
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
    } //Tina Tiger is asleep
    else if (USER == "GORILLA_B") {
      if (ASIA1_STATE == 1) {
        println("GOT TO ASIA ONE STATE HERE YO");
        ASIA1_STATE ++;
        JUNGLE2_STATE ++;
        NAV.clue4 = true; //black fur
        HELP = 8; //Stanley Sloth
      }
    }
    else if (USER == "COBRA_A") {
      if (ASIA1_STATE == 1) {
        ASIA1_STATE ++;
        //Finish
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA1_STATE == 1) {
        ASIA1_STATE ++;
        JUNGLE2_STATE ++;
        NAV.clue2 = true;
        HELP = 8; //Stanley Sloth
      }
    }
    else if (USER == "POLAR_A") {
    } // Tina Tiger is asleep
    else if (USER == "POLAR_B") {
      if (ASIA1_STATE == 0) {
        ASIA1_STATE ++;
        AFRICA2_STATE ++;
        HELP = 1; //Gerry Giraffe
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
    } // Tina Tiger is asleep
    else if (USER == "GORILLA_B") {
      if (ASIA1_STATE == 0) {
        return TIGER_DUMMY;
      }
      else if (ASIA1_STATE == 1) {
        return GB_TIGER1;
      }
      else if (ASIA1_STATE == 2) {
        return TIGER_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      //Tina Tiger is asleep
    }
    else if (USER == "POLAR_B") {
      if (ASIA1_STATE == 0) {
        return PB_TIGER1;
      }
      else if (ASIA1_STATE == 1) {
        return TIGER_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      if (ASIA1_STATE == 0) {
        return TIGER_DUMMY;
      }
      else if (ASIA1_STATE ==1) {
        return CA_TIGER1;
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA1_STATE == 0) {
        return TIGER_DUMMY;
      }
      else if (ASIA1_STATE == 1) {
        return CB_TIGER1;
      }
      else if (ASIA1_STATE == 2) {
        return TIGER_DUMMY;
      }
    }
    return CAMEL_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}




