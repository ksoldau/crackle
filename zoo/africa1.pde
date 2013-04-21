// Calvin Camel
class Africa1 extends Habitat {  
  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 500;
  int animalTop = 100;
  int animalSleepingLeft = 200;
  int animalSleepingLeft = 200;

  PImage animal_not_talking = loadImage("data/calvin_camel.gif");
  PImage background = loadImage("data/africa_1.png");

  Africa1(boolean isSleeping) { //isSleeping too
    super(isSleeping);
  }

  //display the background for this class
  public void display() {
    image(this.background, 0, 0);
  } 

  //display the correct animal image
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

  //display the talking animal
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_CAMEL_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal 
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }
  
  void displayZs() {
      frame = (frame + 1);
      if (frame < 13) {
      image(GIFS_ZS[frame], 300, 100);
      }
      else {
        Z = false;
        frame = 0;
      }
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
  
  //decides what to do if something moused over
  void mouseOverInHabitat() {
    if (this.isSleeping && cursorOverAnimal()) {
      Z = true;
      println(Z);
      //displayZs();
    }
  }

  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    println("GOT TO CURrent talk");
    updateStateNumbers();
  }

  //update state numbers after animal has spoken
  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (AFRICA1_STATE == 0) {
        AFRICA1_STATE ++;
        JUNGLE1_STATE ++;
      }    
      else if (AFRICA1_STATE == 2) {
        AFRICA1_STATE ++ ;
        AFRICA3_STATE ++ ; //Leonard Lion
        nav.clue3 = true; //two legs
      }
    }
    else if (USER == "GORILLA_B") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        FROSTY1_STATE ++;
        nav.clue1 = true; //eat plants
      }
    }
    else if (USER == "COBRA_A") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        ASIA2_STATE ++;
        nav.clue1 = true; //sharp teeth
      }
    }
    else if (USER == "COBRA_B") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        ASIA1_STATE++;
        nav.clue1 = true;
      }
    }
    else if (USER == "POLAR_A") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        FROSTY1_STATE ++;
        nav.clue1 = true;
      }
    }
    else if (USER == "POLAR_B") {
    }
  }


  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
    return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
      && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
  }

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

