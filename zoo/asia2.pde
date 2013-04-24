// Patty Panda
class Asia2 extends Habitat {
  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 500;
  int animalTop = 250;
  int animalSleepingLeft = 200;
  int animalSleepingTop = 200;
  
  int elx = 600;
  int ely = 200;
  
  boolean replaced_bamboo = false;


  PImage background = loadImage("data/asia_2.png");
  PImage animal_not_talking = loadImage("data/patty_pandabear.gif");

  Asia2(boolean isSleeping) {
    super(isSleeping);
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
    
    if (USER == "POLAR_A") {
      displayBambooOrFish();
    }
  }
  
  void displayBambooOrFish() {
    if (!replaced_bamboo) {
    image(BAMBOO_IMAGE, elx, ely);
    }
    else {
      image (FISH_IMAGE, elx, ely);
    }
  }
  
  //displays the correct animal 
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

  //displays the talking animal 
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_PANDA_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_PANDA_TALKING[0], animalLeft, animalTop);
  }

  boolean cursorOverAnimal() {   
    if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
        && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }
  
  boolean cursorOverBamboo() {
     return ((elx < mouseX) && (mouseX < (elx + 200)))
        && ((ely < mouseY) && (mouseY < (ely + 200)));
  }
    

  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverBamboo() && !replaced_bamboo) {
      replaced_bamboo = true;
      ASIA2_STATE ++;
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
    else if (cursorOverAnimal() && (ASIA2_STATE == 2) && USER == "POLAR_B") {
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
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        JUNGLE2_STATE ++; //Stanley Sloth
        HELP = 8;
      }
      if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        FROSTY2_STATE ++;//Sam Seal
        nav.clue2 = true; //love to eat plants
        HELP = 6;
      }
    }
    else if (USER == "GORILLA_B") { //Patty Panda is asleep
    }
    else if (USER == "COBRA_A") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        AFRICA3_STATE ++;
        HELP = 2; //Leonard Lion
      }
      else if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        JUNGLE1_STATE ++;
        nav.clue3 = true;
        HELP = 7; //Eliza Elephant
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        AFRICA2_STATE ++;
        HELP = 1; //Gerry Giraffe
      }
      if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        FROSTY2_STATE ++;
        nav.clue4 = true; //eats mice
        HELP = 6;//Sam Seal
      }
    }
    else if (USER == "POLAR_A") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        FROSTY1_STATE ++;
        HELP = 5; //Peter Penguin
      }
      else if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        JUNGLE2_STATE ++;
        nav.clue3 = true; //black nose
        HELP = 8; //Stanley sloth
      }
    }
    else if (USER == "POLAR_B") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++; //last person
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (ASIA2_STATE == 0) { 
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return GA_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return GA_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
    } //Patty Panda is asleep
    else if (USER == "POLAR_A") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return PA_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return PA_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return PB_PANDA1;
      }
    }
    else if (USER == "COBRA_A") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return CA_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return CA_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return CB_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return CB_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    return PANDA_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}

