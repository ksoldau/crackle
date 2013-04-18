import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import java.text.NumberFormat;

import gifAnimation.*; //from http://www.extrapixel.ch/processing/gifAnimation/

//for tests
PImage SLEEP_TEST;
PImage TRASH_TEST;

// declaring variables outside of setup so they can be used anywhere
// a la "public" in standard java
int ANIMAL_TALKING_START_TIME;

PImage BACKGROUND_IMG;
Intro intro;

// Habitat classes
Africa1 AFRICA1;
Africa2 AFRICA2;
Africa3 AFRICA3;

Asia1 ASIA1;
Asia2 ASIA2;

Frosty1 FROSTY1;
Frosty2 FROSTY2;

Jungle1 JUNGLE1;
Jungle2 JUNGLE2;

// list of Habitats
Habitat[] LIST_OF_HABITATS = new Habitat[9]; //why nine

// Navigation and Arrows
Nav nav;
Arrows arrows;
Map map;

// Audio Setup
// WE will have to initialize all the clips here. Just fyi cause memory leak and etc.
Minim minim;

AudioPlayer AFRICA_BG;
AudioPlayer FROSTY_BG;
AudioPlayer ASIA_BG;
AudioPlayer JUNGLE_BG;

AudioSample AFRICA;
AudioSample FROSTY;
AudioSample ASIA;
AudioSample JUNGLE;

AudioSample CALVIN_CAMEL_TEST;
AudioSample ELIZA_ELEPHANT_TEST;
AudioSample GERRY_GIRAFFE_TEST;
AudioSample LEONARD_LION_TEST;
AudioSample PATTY_PANDABEAR_TEST;
AudioSample PETER_PENGUIN_TEST;
AudioSample SAM_SEALION_TEST;
AudioSample STANLEY_SLOTH_TEST;
AudioSample TINA_TIGER_TEST;

//------------------------------------------------
//Static variables

//width and height of scenes and total height
int WIDTH = 960;
int HEIGHT = 650;
int HABITAT_HEIGHT = 540;

//coordinates for start button on welcome page
int STARTXi = 400; //wrong
int STARTXf = 560; //wrong
int STARTYi = 500; //wrong
int STARTYf = 550; //wrong

//coordinates for map button
int MAPXi = 780;
int MAPXf = 960;
int MAPYi = 550;
int MAPYf = 690;

//coordinates for help button
int HELPXi = 680;
int HELPXf = 760;
int HELPYi = 550;
int HELPYf = 690;

//coordinates for left arrow button
int LEFTXi = 24;
int LEFTXf = 127;
int LEFTYi = 226;
int LEFTYf = 301;

//coordinates for right arrow button
int RIGHTXi = 834;
int RIGHTXf = 942;
int RIGHTYi = 226;
int RIGHTYf = 301;

//--------------------------------------------
//Dynamic variables 

// if a certain screen is up
boolean WELCOME_SCREEN = true; // is it on the welcome screen
boolean ON_INTRO = false; // is it on the intro screen
boolean ON_MAP = false; 

//current habitat number
int HABITAT_NUMBER = 8;

//last habitat number
int LAST_HABITAT_NUMBER = 0;

//is the current animal talking
boolean ANIMAL_TALKING = false;

//------------------------------------------
//setting up who the user is
String USER; // which animal the user is can be 
// "GORILLA_A", "GORILLA_B", "COBRA_A", "COBRA_B", 
// "POLAR_A", or "POLAR_B"

//------------------------------------------
//Gifs of talking animals

PImage[] GIFS_CAMEL_TALKING;
PImage[] GIFS_GIRAFFE_TALKING;
PImage[] GIFS_TIGER_TALKING;
PImage[] GIFS_LION_TALKING;
PImage[] GIFS_PANDA_TALKING;
PImage[] GIFS_PENGUIN_TALKING;
PImage[] GIFS_SEAL_TALKING;
PImage[] GIFS_ELEPHANT_TALKING;
PImage[] GIFS_SLOTH_TALKING;


////////////////////////////////////////////////////////////////////////////////
//           _               
//          | |              
//  ___  ___| |_ _   _ _ __  
// / __|/ _ \ __| | | | '_ \ 
// \__ \  __/ |_| |_| | |_) |
// |___/\___|\__|\__,_| .__/ 
//                    | |    
//                    |_|    
////////////////////////////////////////////////////////////////////////////////
void setup() {
  frameRate(12);
  background(255);
  size(WIDTH, HEIGHT);
  
  //for tests
  SLEEP_TEST = loadImage("data/sleep_test.jpg");
  TRASH_TEST = loadImage("data/testTrash.png");

  // load image that says "Zoo guess who click here to start"
  BACKGROUND_IMG = loadImage("data/welcome.png");
  image(BACKGROUND_IMG, 0, 0);


  // making all the background objects
  intro = new Intro();

  // randomly chooses which animal and which 
  // iteration of that animal the user will play
  chooseUser();
  //loading all animal classes
  //depends on which animal/iteration the user is 
  loadAnimalClasses();

  LIST_OF_HABITATS[0] = AFRICA1;
  LIST_OF_HABITATS[1] = AFRICA2;
  LIST_OF_HABITATS[2] = AFRICA3;
  LIST_OF_HABITATS[3] = ASIA1;
  LIST_OF_HABITATS[4] = ASIA2;
  LIST_OF_HABITATS[5] = FROSTY1;
  LIST_OF_HABITATS[6] = FROSTY2;
  LIST_OF_HABITATS[7] = JUNGLE1;
  LIST_OF_HABITATS[8] = JUNGLE2;


  nav = new Nav();
  arrows = new Arrows();
  map = new Map();

  println(LIST_OF_HABITATS[0]);


  // Setting up sound engine
  minim = new Minim(this);
  
  AFRICA_BG = minim.loadFile("africa_bg.mp3", 512);
  FROSTY_BG = minim.loadFile("frosty_bg.mp3", 512);
  ASIA_BG = minim.loadFile("asia_bg.mp3", 512);
  JUNGLE_BG = minim.loadFile("jungle_bg.mp3", 512);
  
  AFRICA = minim.loadSample("africa_bg.mp3", 512);
  FROSTY = minim.loadSample("frosty_bg.mp3", 512);
  ASIA = minim.loadSample("asia_bg.mp3", 512);
  JUNGLE = minim.loadSample("jungle_bg.mp3", 512);
  
  CALVIN_CAMEL_TEST = minim.loadSample("calvin_camel_test.mp3", 512);
  ELIZA_ELEPHANT_TEST = minim.loadSample("eliza_elephant_test.mp3", 512);
  GERRY_GIRAFFE_TEST = minim.loadSample("gerry_giraffe_test.mp3", 512);
  LEONARD_LION_TEST = minim.loadSample("leonard_lion_test.mp3", 512);
  PATTY_PANDABEAR_TEST = minim.loadSample("patty_pandabear_test.mp3", 512);
  PETER_PENGUIN_TEST = minim.loadSample("peter_penguin_test.mp3", 512);
  SAM_SEALION_TEST = minim.loadSample("sam_sealion_test.mp3", 512);
  STANLEY_SLOTH_TEST = minim.loadSample("stanley_sloth_test.mp3", 512);
  TINA_TIGER_TEST = minim.loadSample("tina_tiger_test.mp3", 512);
  
  // initializing lists for GIFs for talking animals
  GIFS_CAMEL_TALKING = Gif.getPImages(this, "data/calvin_talk_288.gif");
  GIFS_GIRAFFE_TALKING = Gif.getPImages(this, "data/gerry_talk_288.gif");
  GIFS_TIGER_TALKING  = Gif.getPImages(this, "data/tina_talk_288.gif");
  GIFS_LION_TALKING = Gif.getPImages(this, "data/leonard_talk_288.gif");
  GIFS_PANDA_TALKING = Gif.getPImages(this, "data/patty_talk_288.gif");
  GIFS_PENGUIN_TALKING = Gif.getPImages(this, "data/peter_talk_288.gif");
  GIFS_SEAL_TALKING = Gif.getPImages(this, "data/sam_talk_288.gif");
  GIFS_ELEPHANT_TALKING = Gif.getPImages(this, "data/eliza_talk_288.gif");
  GIFS_SLOTH_TALKING = Gif.getPImages(this, "data/stanley_talk_288.gif");
}

//randomly chooses which animal the user is 
// and which group of 6 animal interacts with
void chooseUser() {
  float random_number = random(0, 6);
  if (random_number < 1) {
    USER = "GORILLA_A";
  }
  else if (random_number < 2) {
    USER = "GORILLA_B";
  }
  else if (random_number < 3) {
    USER = "POLAR_A";
  }
  else if (random_number < 4) {
    USER = "POLAR_B";
  }
  else if (random_number < 5) {
    USER = "COBRA_A";
  }
  else if (random_number < 6) {
    USER = "COBRA_B";
  }
  println(USER);
}

void loadAnimalClasses() {
  if (USER == "GORILLA_A") {
    AFRICA1 = new Africa1(1, false);
    AFRICA2 = new Africa2(1, true);
    AFRICA3 = new Africa3(1, false);
    ASIA1 = new Asia1(1, true);
    ASIA2 = new Asia2(1, false);
    FROSTY1 = new Frosty1(1, true);
    FROSTY2 = new Frosty2(1, false);
    JUNGLE1 = new Jungle1(1, false);
    JUNGLE2 = new Jungle2(1, false);
  }
  else if (USER == "GORILLA_B") {
    AFRICA1 = new Africa1(1, false);
    AFRICA2 = new Africa2(1, false);
    AFRICA3 = new Africa3(1, true);
    ASIA1 = new Asia1(1, false);
    ASIA2 = new Asia2(1, true);
    FROSTY1 = new Frosty1(1, false);
    FROSTY2 = new Frosty2(1, false);
    JUNGLE1 = new Jungle1(1, true);
    JUNGLE2 = new Jungle2(1, false);
  }
  else if (USER == "COBRA_A") {
    AFRICA1 = new Africa1(1, false);
    AFRICA2 = new Africa2(1, true);
    AFRICA3 = new Africa3(1, false);
    ASIA1 = new Asia1(1, false);
    ASIA2 = new Asia2(1, false);
    FROSTY1 = new Frosty1(1, false);
    FROSTY2 = new Frosty2(1, true);
    JUNGLE1 = new Jungle1(1, false);
    JUNGLE2 = new Jungle2(1, true);
  }
  else if (USER == "COBRA_B") {
    AFRICA1 = new Africa1(1, true);
    AFRICA2 = new Africa2(1, false);
    AFRICA3 = new Africa3(1, false);
    ASIA1 = new Asia1(1, false);
    ASIA2 = new Asia2(1, false);
    FROSTY1 = new Frosty1(1, true);
    FROSTY2 = new Frosty2(1, false);
    JUNGLE1 = new Jungle1(1, true);
    JUNGLE2 = new Jungle2(1, false);
  }
  else if (USER == "POLAR_A") {
    AFRICA1 = new Africa1(1, false);
    AFRICA2 = new Africa2(1, false);
    AFRICA3 = new Africa3(1, true);
    ASIA1 = new Asia1(1, true);
    ASIA2 = new Asia2(1, false);
    FROSTY1 = new Frosty1(1, false);
    FROSTY2 = new Frosty2(1, true);
    JUNGLE1 = new Jungle1(1, false);
    JUNGLE2 = new Jungle2(1, false);
  }
  else if (USER == "POLAR_B") {
    AFRICA1 = new Africa1(1, true);
    AFRICA2 = new Africa2(1, false);
    AFRICA3 = new Africa3(1, true);
    ASIA1 = new Asia1(1, false);
    ASIA2 = new Asia2(1, false);
    FROSTY1 = new Frosty1(1, false);
    FROSTY2 = new Frosty2(1, false);
    JUNGLE1 = new Jungle1(1, false);
    JUNGLE2 = new Jungle2(1, true);
  }
}

////////////////////////////////////////////////////////////////////////////////
//           _                    
//          | |                   
//        __| |_ __ __ ___      __
//       / _` | '__/ _` \ \ /\ / /
//      | (_| | | | (_| |\ V  V / 
//       \__,_|_|  \__,_| \_/\_/  
////////////////////////////////////////////////////////////////////////////////


// draw is called directly after setup
// called automatically
void draw() {
  int current_time = millis();

  //to stop the animal from visibly speaking if audio over
  if (ANIMAL_TALKING && 
    (current_time - ANIMAL_TALKING_START_TIME >= LIST_OF_HABITATS[HABITAT_NUMBER].currentTalk().length())) {
    ANIMAL_TALKING = false;
    doScene(HABITAT_NUMBER);
  }
  //to display the correct animal for current habitat
  if (!ON_MAP && !WELCOME_SCREEN && !ON_INTRO) { 
    doScene(HABITAT_NUMBER);
    LIST_OF_HABITATS[HABITAT_NUMBER].displayAnimal(); //HERE IS WHERE ANIMALS ARE DISPLAYED, IF UNCOMMENT MEM PROBZ
  }

  drawCursor();
  // printMem(); //DEBUG: To monitor memory usage
  whenPlay();
}


// DEBUG section
// This is for memory concerns; it prints out the totals to the 
// console if called in draw()

void printMem() {
  Runtime runtime = Runtime.getRuntime();
  NumberFormat format = NumberFormat.getInstance();
  StringBuilder sb = new StringBuilder();
  long maxMemory = runtime.maxMemory();
  long allocatedMemory = runtime.totalMemory();
  long freeMemory = runtime.freeMemory();
  sb.append("free memory: " + format.format(freeMemory / 1024) + "  ");
  sb.append("allocated memory: " + format.format(allocatedMemory / 1024) + "  ");
  sb.append("max memory: " + format.format(maxMemory / 1024) + "  ");
  sb.append("total free memory: " + format.format((freeMemory + (maxMemory - allocatedMemory)) / 1024) + "  ");
  println(sb);
}

// SOUNDS

void playBg() {  
  if (HABITAT_NUMBER == 0 || HABITAT_NUMBER == 1 || HABITAT_NUMBER == 2) {
    pauseAll();
    AFRICA_BG.loop();
  }
  if (HABITAT_NUMBER == 3 || HABITAT_NUMBER == 4) {
    pauseAll();
    ASIA_BG.loop();
  }
  if (HABITAT_NUMBER == 5 || HABITAT_NUMBER == 6) {
    pauseAll();
    FROSTY_BG.loop();
  } 
  if (HABITAT_NUMBER == 7 || HABITAT_NUMBER == 8) {
    pauseAll();    
    JUNGLE_BG.loop();
  }
}

void pauseAll() {
  AFRICA_BG.pause();
  ASIA_BG.pause();
  JUNGLE_BG.pause();
  FROSTY_BG.pause();
}

void whenPlay() {
  /*if (HABITAT_NUMBER != LAST_HABITAT_NUMBER) {
    playBg();
  }*/
  if (((HABITAT_NUMBER==0) || (HABITAT_NUMBER==1) || (HABITAT_NUMBER==2))
  && !(LAST_HABITAT_NUMBER <= 2)) {
    playBg();
  }
  else if (((HABITAT_NUMBER ==3) || (HABITAT_NUMBER==4)) &&
  ((LAST_HABITAT_NUMBER != 3) && (LAST_HABITAT_NUMBER != 4))) {
    playBg();
  }
  else if (((HABITAT_NUMBER==5) || (HABITAT_NUMBER==6)) && 
  ((LAST_HABITAT_NUMBER != 5) && (LAST_HABITAT_NUMBER != 6))) {
    playBg();
  }
  else if (((HABITAT_NUMBER == 7) || (HABITAT_NUMBER == 8)) && !(LAST_HABITAT_NUMBER >= 7)) {
    playBg();
  }
  /*if (((HABITAT_NUMBER == 0) || (HABITAT_NUMBER == 1) || (HABITAT_NUMBER == 2)) &&
  !(LAST_HABITAT_NUMBER < 3)) {
    playBg();
  }
  else if (((HABITAT_NUMBER == 3) || (HABITAT_NUMBER == 4)) &&
  (!(HABITAT_NUMBER == 3) && !(HABITAT_NUMBER == 4))) {
    playBg();
  }
  else if (((HABITAT_NUMBER == 5) || (HABITAT_NUMBER == 6)) &&
  (!(HABITAT_NUMBER == 5) && !(HABITAT_NUMBER == 6))) {
    playBg();
  }
  else if (((HABITAT_NUMBER == 7) || (HABITAT_NUMBER == 8)) &&
  (!(HABITAT_NUMBER == 7) && !(HABITAT_NUMBER == 8))) {
    playBg();
  }*/
  LAST_HABITAT_NUMBER = HABITAT_NUMBER;
}


//changes the cursor to way we want it when we want it
void drawCursor() {
  // changes the cursor to show it's over the start button
  if (WELCOME_SCREEN) {

    if (cursor_over(STARTXi, STARTXf, STARTYi, STARTYf)) {
      cursor(HAND);
    }
    else {
      cursor(ARROW);
    }
  } 

  else if (ANIMAL_TALKING) {
    cursor(ARROW);
  }

  else if 
    (cursorOverMapButton() || 
    cursor_over_help() || 
    cursor_over_left() ||
    cursor_over_right() ||
    (!LIST_OF_HABITATS[HABITAT_NUMBER].isSleeping &&
    LIST_OF_HABITATS[HABITAT_NUMBER].cursorOverAnimal()) ||
    (ON_MAP && (
  cursor_over_africa1() ||
    cursor_over_africa2() ||
    cursor_over_africa3() ||
    cursor_over_asia1() ||
    cursor_over_asia2() ||
    cursor_over_frosty1() ||
    cursor_over_frosty2() ||
    cursor_over_jungle1() ||
    cursor_over_jungle2() ))) 
  {
    cursor(HAND);
  }
  else if ((HABITAT_NUMBER == 8) && JUNGLE2.cursorOverTrash()) {
    cursor(HAND);
  }
  else {
    cursor(ARROW);
  }
}


//---------------------------------------
// "do" functions 
// these call the display methods in the corresponding classes
// so we can view them in zoo.pde

//chooses what scene to do next based on int argument
void doScene(int i) {
  if (i == 0) {
    doAfrica1();
  }
  else if (i == 1) {
    doAfrica2();
  } 
  else if (i == 2) {
    doAfrica3();
  }
  else if (i == 3) {
    doAsia1();
  }
  else if (i == 4) {
    doAsia2();
  }
  else if (i == 5) {
    doFrosty1();
  }
  else if (i == 6) {
    doFrosty2();
  }
  else if (i == 7) {
    doJungle1();
  }
  else if (i == 8) {
    doJungle2();
  }
}

// intro of the box screen
void doIntro() {
  intro.display();
  arrows.display();
  nav.display();
  //ON_INTRO = true;
}

// map screen
void doMap() {
  map.display();
  ON_MAP = true;
}

//---------------------
// all of the do methods display the habitat for each 
// specified habitat
// arrows are displayed because the backgrounds will hide them.

void doAfrica1() {
  AFRICA1.display();
  arrows.display();
}
void doAfrica2() {
  AFRICA2.display();
  arrows.display();
}

void doAfrica3() {
  AFRICA3.display();
  arrows.display();
}

void doAsia1() {
  ASIA1.display();
  arrows.display();
}

void doAsia2() {
  ASIA2.display();
  arrows.display();
}

void doFrosty1() {
  FROSTY1.display();
  arrows.display();
}

void doFrosty2() {
  FROSTY2.display();
  arrows.display();
}

void doJungle1() {
  JUNGLE1.display();
  arrows.display();
}

void doJungle2() {
  JUNGLE2.display();
  arrows.display();
}


//------------------------------------
//actions to take if mouse is pressed

// assume: on welcome screen
// determines what actions to perform if mouse pressed 
void mousePressedWelcomeScreen() {
  if (cursor_over_start() && mousePressed == true) {
    doIntro();
    WELCOME_SCREEN = false;
  }
}

// if mouse is pressed, do this stuff 
void mousePressed() {
  //if welcome screen is up 
  if (WELCOME_SCREEN) { 
    mousePressedWelcomeScreen();
  }
  
  //if map is up
  if (ON_MAP) {
    mousePressedOnMap();
  }
  
  //if an animal is talking
  else if (ANIMAL_TALKING) {
  } //stops user from clicking on things while animal talking



  //if over map 
  else if (cursorOverMapButton()) {
    doMap();
    ON_MAP = true;
  }
  else if (cursor_over_left()) {
    doScene(updateSceneNumber("left"));
  }
  else if (cursor_over_right()) {
    doScene(updateSceneNumber("right"));
  }
  else if (!ON_MAP && cursorOverHabitat()) {//&& (HABITAT_NUMBER == 0)) {
    LIST_OF_HABITATS[HABITAT_NUMBER].mousePressedInHabitat();
  }
}

// assume: on map
// determines what actions to perform if on map
void mousePressedOnMap() {
  if (cursor_over_africa1()) {
    doAfrica1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 0;
    ON_MAP = false;
  }
  else if (cursor_over_africa2()) {
    doAfrica2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 1;
    ON_MAP = false;
  }
  else if (cursor_over_africa3()) {
    doAfrica3();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 2;
    ON_MAP = false;
  }
  else if (cursor_over_asia1()) {
    doAsia1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 3;
    ON_MAP = false;
  }
  else if (cursor_over_asia2()) {
    doAsia2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 4;
    ON_MAP = false;
  }
  else if (cursor_over_frosty1()) {
    doFrosty1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 5;
    ON_MAP = false;
  }
  else if (cursor_over_frosty2()) {
    doFrosty2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 6;
    ON_MAP = false;
  }
  else if (cursor_over_jungle1()) {
    doJungle1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 7;
    ON_MAP = false;
  }
  else if (cursor_over_jungle2()) {
    doJungle2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 8;
    ON_MAP = false;
  }
}


// to update the scene the user is on
// when they click on an arrow key as specified by query
int updateSceneNumber(String query) {
  if (query.equals("left") && HABITAT_NUMBER == 0) {
    HABITAT_NUMBER = 8;
    LAST_HABITAT_NUMBER = 0;
  }
  else if (query.equals("right") && HABITAT_NUMBER == 8) {
    HABITAT_NUMBER = 0;
    LAST_HABITAT_NUMBER = 8;
  }
  else if (query.equals("left")) {
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER--;
  }
  else { // assume query == "right" 
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER++;
  }
  return HABITAT_NUMBER;
}


//---------------------------------------------
// determine if cursor is over a certain area 

// determines if cursor in a certain box
boolean cursor_over(int xmin, int xmax, int ymin, int ymax) {
  return xmin < mouseX && mouseX < xmax && ymin < mouseY && mouseY < ymax;
}

// determines if cursor over the start button 
// assume: on welcome page
boolean cursor_over_start() {
  return cursor_over(STARTXi, STARTXf, STARTYi, STARTYf);
}


//assume: not on welcome screen, not on map
// determines if mouse pressed in a habitat
boolean cursorOverHabitat() {
  return cursor_over(0, 960, 0, 540);
}


// determines if cursor over map 
boolean cursorOverMapButton() {
  return cursor_over(MAPXi, MAPXf, MAPYi, MAPYf);
}
boolean cursor_over_help() {
  return cursor_over(HELPXi, HELPXf, HELPYi, HELPYf);
}
boolean cursor_over_left() {
  return cursor_over(LEFTXi, LEFTXf, LEFTYi, LEFTYf);
}
boolean cursor_over_right() {
  return cursor_over(RIGHTXi, RIGHTXf, RIGHTYi, RIGHTYf);
}

// assuming in the map
boolean cursor_over_africa1() {
  return cursor_over(473, 562, 96, 160);
}
boolean cursor_over_africa2() {
  return cursor_over(564, 654, 171, 237);
}
boolean cursor_over_africa3() {
  return cursor_over(581, 670, 270, 336);
}
boolean cursor_over_asia1() {
  return cursor_over(527, 616, 370, 435);
}
boolean cursor_over_asia2() {
  return cursor_over(423, 513, 409, 474);
}
boolean cursor_over_frosty1() {
  return cursor_over(318, 407, 369, 433);
}
boolean cursor_over_frosty2() {
  return cursor_over(267, 356, 272, 336);
}
boolean cursor_over_jungle1() {
  return cursor_over(283, 372, 171, 235);
}
boolean cursor_over_jungle2() {
  return cursor_over(373, 461, 95, 159);
}
