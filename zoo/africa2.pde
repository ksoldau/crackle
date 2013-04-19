// Gerry Giraffe
class Africa2 extends Habitat {
  int frame;
  int numTalkingFrames = 8;

  int animalLeft = 500;
  int animalTop = 100;

  PImage animal_not_talking = loadImage("data/gerry_giraffe.gif");
  PImage background = loadImage("data/africa_2.png");

  Africa2(boolean isSleeping) {
    super(isSleeping);
  }
  //displays the background for the habitat
  public void display() {
    image(this.background, 0, 0);
  } 

  //determines if the animal in the habitat was clicked on
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

  //display the talking animal
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_GIRAFFE_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal
  void displayAnimalNotTalking() {
    image(animal_not_talking, animalLeft, animalTop);
  }

  //determines if the mouse was pressed on an animal
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
    updateSceneNumbers();
  }
  
  void updateSceneNumbers() {
    if (USER == "GORILLA_A") {
      if (AFRICA2_STATE == 1) {
        AFRICA2_STATE ++;
        JUNGLE2_STATE ++; //SLOTH
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

