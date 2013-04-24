// Eliza Elephant
class Jungle1 extends Habitat {
  int frame;
  int numTalkingFrames = 16;

  int animalLeft = 500;
  int animalTop = 170;
  int animalSleepingLeft = 200;
  int animalSleepingTop = 200;


  PImage background = loadImage("data/jungle_1.png"); 
  
  PImage animal_sleeping;
  
  Jungle1(boolean isSleeping) {
    super(isSleeping);
    if (isSleeping) {
      animal_sleeping = loadImage("data/sleep/eliza_sleep_288.png");
    }
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }

  //display the correct animal image
  void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, animalSleepingLeft, animalSleepingTop);
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
    image(GIFS_ELEPHANT_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal 
  void displayAnimalNotTalking() {
    image(GIFS_ELEPHANT_TALKING[0], animalLeft, animalTop);
  }

  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
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

  //updates state numbers 
  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (JUNGLE1_STATE == 1) {
        nav.clue1 = true;// got fur clue
        JUNGLE1_STATE ++;
        ASIA2_STATE ++;
        HELP = 4;
      }
    }

    else if (USER == "GORILLA_B") {
    } //ELiza Elephant is asleep
    else if (USER == "COBRA_A") {
      if (JUNGLE1_STATE == 1) {
        JUNGLE1_STATE ++;
        ASIA1_STATE ++;
        nav.clue4 = true;
        HELP = 3;//Tina Tiger
      }
    }
    else if (USER == "COBRA_B") {
    } //Elize Elephant is asleep
    else if (USER == "POLAR_A") {
      if (JUNGLE1_STATE == 0) {
        JUNGLE1_STATE ++;
        AFRICA1_STATE ++;
        HELP = 0;//Calvin Camel
      }
    }
    else if (USER == "POLAR_B") {
      if (JUNGLE1_STATE == 1) {
        JUNGLE1_STATE ++;
        FROSTY2_STATE ++;
        nav.clue2 = true; //fur
        HELP = 6; //Sam Seal
      }
    }
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
      if (JUNGLE1_STATE == 0) { 
        return ELEPHANT_DUMMY;
      }
      else if (JUNGLE1_STATE == 1) {

        println("got here");
        println("jungle state here" + JUNGLE1_STATE);
        return GA_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 2) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
    }//Eliza Elephant is sleeping
    else if (USER == "POLAR_A") {
      if (JUNGLE1_STATE == 0) {
        return PA_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 1) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      if (JUNGLE1_STATE == 0) {
        return ELEPHANT_DUMMY;
      }
      else if (JUNGLE1_STATE == 1) {
        return PB_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 2) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      if (JUNGLE1_STATE == 0) {
        return ELEPHANT_DUMMY;
      }
      else if (JUNGLE1_STATE == 1) {
        return CA_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 2) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      //Eliza Elephant is asleep
    }
    return ELEPHANT_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}

