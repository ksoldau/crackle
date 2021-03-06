// Sam Seal (Conor doesn't know difference between seal and sea lion)
class Frosty2 extends Habitat {
  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 200;
  int animalTop = 220;
 

  PImage background = loadImage("data/frosty_2.png");
  boolean has_fish;

PImage animal_sleeping;
  Frosty2(boolean isSleeping) {
    super(isSleeping, 200, 200);
    if (isSleeping) {
      animal_sleeping = loadImage("data/sleep/sam_sleep_288.png");
      
    }
  }
  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
        
        if (has_fish) {
          image(FISH_IMAGE, 400, 400);
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

  //displays the talking animal 
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_SEAL_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_SEAL_TALKING[0], animalLeft, animalTop);
  }

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

  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (FROSTY2_STATE == 2) && USER == "COBRA_B") {
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
      if (FROSTY2_STATE == 1) {
        FROSTY2_STATE ++;
        AFRICA1_STATE ++;
        HELP = 0;
      }
    }
    else if (USER == "GORILLA_B") {
      if (FROSTY2_STATE == 0) {
        FROSTY2_STATE ++;
        AFRICA1_STATE ++;
        HELP = 0;
      }
    }
    else if (USER == "COBRA_A") {
    } //Sam Seal is asleep
    else if (USER == "COBRA_B") {
      FROSTY2_STATE ++;
      FROSTY2_STATE ++; //the last person to talk to here
    }
    else if (USER == "POLAR_A") {
    }//Sam Seal is asleep
    else if (USER == "POLAR_B") {
      if (FROSTY2_STATE == 1) {
        FROSTY2_STATE ++;
        FROSTY1_STATE ++;
        HELP = 5; //Peter Penguin *** but really need to get a fish
      }
      if (FROSTY2_STATE == 3) {
        FROSTY2_STATE ++;
        ASIA2_STATE ++;
        NAV.clue4 = true;
        HELP = 4; //Patty Panda
        HAS_ITEM = false;
        has_fish = true;
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (FROSTY2_STATE == 0) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 1) {
        return GA_SEAL1;
      }
      else if (FROSTY2_STATE == 2) {
        return SEAL_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
      if (FROSTY2_STATE == 0) {
        return GB_SEAL1;
      }
      else if (FROSTY2_STATE == 1) {
        return SEAL_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      //Sam Seal is asleep
    }
    else if (USER == "POLAR_B") {
      if (FROSTY2_STATE == 0) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 1) {
        return PB_SEAL1;
      }
      else if (FROSTY2_STATE == 2) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 3) {
        return PB_SEAL2;
      }
      else if (FROSTY2_STATE == 4) {
        return SEAL_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      //Sam Seal is asleep
    }
    else if (USER == "COBRA_B") {
      if (FROSTY2_STATE == 0) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 1) {
        return CB_SEAL1;
      }
    }
    return SEAL_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}


