//The owl that comes up to help if user requests it
class Owl { 

  Owl() {
  }

  void displayOwl() {
    image(LIST_HELP_IMAGES[HELP], 640, 200);
  }

  void talkOwl() {
    LIST_OWL_AUDIO[HELP].trigger();
    OWL_TALKING_START_TIME = millis();
  }
}


