// Calvin Camel
class Africa1 extends Habitat {  
  
  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 500;
  int animalTop = 100;

  PImage background = loadImage("data/africa_1.png");
  
  PImage animal_sleeping;

  Africa1(boolean isSleeping) { //isSleeping too
    super(isSleeping, 200, 200);
    if (isSleeping) {
      PImage animal_sleeping = loadImage("data/sleep/calvin_sleep_288.png");
    }
  }

  //display the background for this class
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
  } 

  //display the correct animal image
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
    image(GIFS_CAMEL_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal 
  void displayAnimalNotTalking() {
    image(GIFS_CAMEL_TALKING[0], animalLeft, animalTop);
    //image(animal_not_talking, animalLeft, animalTop);
  }

  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) { 
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk(); //sound
    }
  }

  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    println("GOT TO CURRENT talk");
    updateStateNumbers();
  }

  //update state numbers after animal has spoken
  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (AFRICA1_STATE == 0) {
        AFRICA1_STATE ++;
        JUNGLE1_STATE ++;
        HELP = 7;
      }    
      else if (AFRICA1_STATE == 2) {
        AFRICA1_STATE ++ ;
        AFRICA3_STATE ++ ; //Leonard Lion
        NAV.clue3 = true; //two legs
        HELP = 2;
      }
    }
    else if (USER == "GORILLA_B") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        FROSTY1_STATE ++;
        NAV.clue1 = true; //eat plants
        HELP = 5;
      }
    }
    else if (USER == "COBRA_A") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        ASIA2_STATE ++;
        NAV.clue1 = true; //sharp teeth
        HELP = 4; //Patty Panda
      }
    }
    else if (USER == "COBRA_B") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        ASIA1_STATE++;
        NAV.clue1 = true;
      }
    }
    else if (USER == "POLAR_A") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        FROSTY1_STATE ++;
        NAV.clue1 = true;
        HELP = 5; //Peter Penguin
      }
    }
    else if (USER == "POLAR_B") {
    }
  }


  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 200)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    }
  }

  //plays what the animal should currently be saying
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (AFRICA1_STATE == 0) { 
        return GA_CAMEL1;
      }
      else if (AFRICA1_STATE == 1) { 
        return CAMEL_DUMMY;
      }
      else if (AFRICA1_STATE == 2) { 
        return GA_CAMEL2;
      }
      else if (AFRICA1_STATE == 3) { 
        return CAMEL_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
      if (AFRICA1_STATE == 0) {
        return CAMEL_DUMMY;
      }
      else if (AFRICA1_STATE == 1) {
        return GB_CAMEL1;
      }
      else if (AFRICA1_STATE == 2) {
        return CAMEL_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      if (AFRICA1_STATE == 0) {
        return CAMEL_DUMMY;
      }
      else if (AFRICA1_STATE == 1) {
        return PA_CAMEL1;
      }
      else if (AFRICA1_STATE == 2) {
        return CAMEL_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      //Calvin Camel is asleep
    }
    else if (USER == "COBRA_A") {
      if (AFRICA1_STATE == 0) {
        return CAMEL_DUMMY;
      }
      else if (AFRICA1_STATE ==1) {
        return CA_CAMEL1;
      }
      else if (AFRICA1_STATE == 2) {
        return CAMEL_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      //Calvin Camel is asleep
    } 
    return CAMEL_DUMMY;
    //this is just so it doesn't yell at us for now, delete it later!
  }
}


