// Peter Penguin
class Frosty1 extends Habitat {  
  int frame;
  int numTalkingFrames = 4;

  int animalLeft = 500;
  int animalTop = 100;

  PImage background = loadImage("data/frosty_1.png");
  PImage animal_not_talking = loadImage("data/peter_penguin.gif");

  Frosty1(boolean isSleeping) {
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
    image(GIFS_PENGUIN_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }

  boolean cursorOverAnimal() { 
    boolean ans = ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
      && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    return ans;
  }

  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) {
      PETER_PENGUIN_TEST.trigger(); //sound
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
    }
  }  

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
    } //Peter Penguinn is asleep
    else if (USER == "GORILLA_B") {
      if (FROSTY1_STATE == 0) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 1) {
        return GB_PENGUIN1;
      }
      else if (FROSTY1_STATE == 2) {
        return GB_PENGUIN2;
      }
      else if (FROSTY1_STATE == 3) {
        return PENGUIN_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      if (FROSTY1_STATE == 0) {
      return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 1) {
      return PA_PENGUIN1;
      }
      else if (FROSTY1_STATE == 2) {
      return PA_PENGUIN2;
      }
      else if (FROSTY1_STATE == 3) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 4) {
        return PA_PENGUIN3;
      }
      else if (FROSTY1_STATE == 5) {
      return PENGUIN_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      if (FROSTY1_STATE == 0) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 1) {
      return PB_PENGUIN1;
      }
      else if (FROSTY1_STATE == 2) {
      return PENGUIN_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      if (FROSTY1_STATE == 0) {
        return CA_PENGUIN1;
      }
      else if (FROSTY2_STATE == 1) {
        return PENGUIN_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      //Peter Penguin is asleep
    }
    return CALVIN_CAMEL_TEST; //this is just so it doesn't yell at us for now, delete it later!
  }
}


