// Peter Penguin
class Frosty1 extends Habitat {  
  int frame;
  int numTalkingFrames = 4;

  int animalLeft = 500;
  int animalTop = 100;
  int animalSleepingLeft = 200;
  int animalSleepingLeft = 200;


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
      image(SLEEP_TEST, animalSeepingLeft, animalSleepingTop);
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

  //determines if the cursor is over Peter Penguin
  boolean cursorOverAnimal() { 
    boolean ans = ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
      && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    return ans;
  }

  //delegates what should happen if mouse pressed in Peter Penguin's habitat
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
      println("got here homeslice3");
    }
  }  

  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    updateStateNumbers();
  }

  //updates state numbers after an animal has spoken
  void updateStateNumbers() {
    if (USER == "GORILLA_A") {}//Peter Penguin is asleep
    else if (USER == "GORILLA_B") {
      println("got here dude");

      if (FROSTY1_STATE == 1) {
        println("got here dudette");

        FROSTY1_STATE ++;
        AFRICA2_STATE ++;
      }
      else if (FROSTY1_STATE == 3) {
        println("got here homeslice");
        FROSTY1_STATE ++;
        ASIA1_STATE ++;
        nav.clue3 = true; //muscles
      }
    }
    else if (USER == "COBRA_A") {
      if (FROSTY1_STATE == 0) {
        FROSTY1_STATE ++;
        AFRICA1_STATE ++;
      }
    }
    else if (USER == "POLAR_A") {
      if (FROSTY1_STATE == 1) {
        FROSTY1_STATE ++;
        ASIA2_STATE ++;
      }
      else if (FROSTY1_STATE == 3) {
        FROSTY1_STATE ++;
        ASIA2_STATE ++;
        nav.clue2 = true;
      }
    }
    else if (USER == "POLAR_B") {
      if (FROSTY1_STATE == 1) {
        FROSTY1_STATE++;
        FROSTY2_STATE ++;
        nav.clue3 = true;
      }
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
          return PENGUIN_DUMMY;
        }
        else if (FROSTY1_STATE == 3) {
          return GB_PENGUIN2;
        }
        else if (FROSTY1_STATE == 4) {
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
          return PENGUIN_DUMMY;
        }
        else if (FROSTY1_STATE == 3) {
          return PA_PENGUIN2;
        }
        else if (FROSTY1_STATE == 4) {
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
      return PENGUIN_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
    }
  }

