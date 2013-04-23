class Owl { 
  
  int num;
  
  Owl() {
  }
  
  void displayOwl() {
    image(LIST_OF_HELP[HELP], 520, 200);
  }
  
  void talkOwl() {
     TEST_OWL.trigger();
     OWL_TALKING_START_TIME = millis();
  }
}
