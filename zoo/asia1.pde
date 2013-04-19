// Tina Tiger
class Asia1 extends Habitat {
  int frame;
  int numTalkingFrames = 8;

  int animalLeft = 500;
  int animalTop = 100;

  PImage background = loadImage("data/asia_1.png");
  PImage animal_not_talking = loadImage("data/tina_tiger.gif");

  Asia1(boolean isSleeping) {
    super(isSleeping);
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }

  //displays the correct animal
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

  //displays the talking animal 
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_TIGER_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }

  //determines if the animal in the habitat was clicked on
  boolean cursorOverAnimal() {
    boolean ans = ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
      && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    return ans;
  }

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
    }
    updateStateNumbers();
  }
  
  void updateStateNumbers() {
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
    return CALVIN_CAMEL_TEST; //this is just so it doesn't yell at us for now, delete it later!
  }
}







