// Nav
class Nav {

  PImage navbar;

  boolean clue1; //GA fur //GB //CA/ //CB //PA //PB
  boolean clue2; 
  boolean clue3;
  boolean clue4;

  int clue1xi = 55;
  int clue2xi = 209;
  int clue3xi = 366;
  int clue4xi = 522;
  int clueyi = 567;

  Nav() {
    this.navbar = loadImage("data/nav.png");
  }

  // display the scene
  void display() {
    image(navbar, 0, 0);
    if (clue1) {
      displayClue1();
    }
    if (clue2) {
      displayClue2();
    }
    if (clue3) {
      displayClue3();
    }
    if (clue4) {
      displayClue4();
    }
  }

  void displayClue1() {
    image(CLUE1, clue1xi, clueyi);
  }

  void displayClue2() {
    image(CLUE2, clue2xi, clueyi);
  }

  void displayClue3() {
    image(CLUE3, clue3xi, clueyi);
  }

  void displayClue4() {
    image(CLUE4, clue4xi, clueyi);
  }

  //determines if cursor should be over a clue
  boolean cursorOverClue() {
    return cursorOverClue1() || cursorOverClue2() || 
      cursorOverClue3() || cursorOverClue4();
  }

    boolean cursorOverClue1() {
      return (clue1 && cursorOver(clue1xi, clue1xi + 100, clueyi, clueyi+ 65));
      }
      boolean cursorOverClue2() {
        return (clue2 && cursorOver(clue2xi, clue2xi + 100, clueyi, clueyi+ 65));
      }
    boolean cursorOverClue3() {
      return (clue3 && cursorOver(clue3xi, clue3xi + 100, clueyi, clueyi+ 65));
    }
    boolean cursorOverClue4() {
      return clue4 && cursorOver(clue4xi, clue4xi + 100, clueyi, clueyi+ 65);
    }

    //decides what to do if mouse pressed on nav
    void mousePressedOnClue() {
      if (cursorOverClue1()) {
        CLUE1_AUDIO.trigger();
        CLUE_TALKING = true;
        CLUE_TALKING_START_TIME = millis();
      }
      else if (cursorOverClue2()) {
        CLUE2_AUDIO.trigger();
        CLUE_TALKING = true;
        CLUE_TALKING_START_TIME = millis();
      }
      else if (cursorOverClue3()) {
        CLUE3_AUDIO.trigger();
        CLUE_TALKING = true;
        CLUE_TALKING_START_TIME = millis();
      }
      else if (cursorOverClue4()) {
        CLUE4_AUDIO.trigger();
        CLUE_TALKING = true;
        CLUE_TALKING_START_TIME = millis();
      }
    }
  }

