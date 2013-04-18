// Patty Panda
class Asia2 extends Habitat {
  int state;
  boolean isSleeping;

  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 500;
  int animalTop = 100;

  PImage background = loadImage("data/asia_2.png");
  PImage animal_not_talking = loadImage("data/patty_pandabear.gif");

  Asia2(int state, boolean isSleeping) {
    super(isSleeping);
    this.state = state;
    this.isSleeping = isSleeping;
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
    image(GIFS_PANDA_TALKING[frame], animalLeft, animalTop);
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
      PATTY_PANDABEAR_TEST.trigger(); //sound
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
    }
}  

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {}
    else if (USER == "GORILLA_B") {}
    else if (USER == "POLAR_A") {}
    else if (USER == "POLAR_B") {}
    else if (USER == "COBRA_A") {}
    else if (USER == "COBRA_B") {}
              return CALVIN_CAMEL_TEST; //this is just so it doesn't yell at us for now, delete it later!

  }
  
}


