import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import java.text.NumberFormat;

import gifAnimation.*; //from http://www.extrapixel.ch/processing/gifAnimation/

// declaring variables outside of setup so they can be used anywhere
// a la "public" in standard java
int ANIMAL_TALKING_START_TIME;

PImage BACKGROUND_IMG;
Intro intro;

// Habitat classes
Africa1 africa1;
Africa2 africa2;
Africa3 africa3;

Asia1 asia1;
Asia2 asia2;

Frosty1 frosty1;
Frosty2 frosty2;

Jungle1 jungle1;
Jungle2 jungle2;

// list of Habitats
Habitat[] LIST_OF_HABITATS = new Habitat[9]; //why nine

// Navigation and Arrows
Nav nav;
Arrows arrows;
Map map;

// Audio Setup
// WE will have to initialize all the clips here. Just fyi cause memory leak and etc.
Minim minim;
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
boolean INTRO_SCREEN = false; // is it on the intro screen
boolean ON_MAP = false; 

//current habitat number
int HABITAT_NUMBER = 8;

//is the current animal talking
boolean ANIMAL_TALKING = false;

//------------------------------------------
//setting up who the user is
String USER; // which animal the user is can be 
// "gorillaA", "gorillaB", "cobraA", "cobraB", 
// "polarbearA", or "polarbearB"

//------------------------------------------
//Gifs of talking animals

PImage[] GIFS_CAMEL_TALKING;
PImage[] GIFS_GIRAFFE_TALKING;
PImage[] GIFS_TIGER_TALKING;
PImage[] GIFS_LION_TALKING;

//Talking animals gifs
 /*Gif GIF_PANDA_TALKING; //Asia2
 Gif GIF_PENGUIN_TALKING; //Frosty1
 Gif GIF_SEAL_TALKING; //Frosty2
 Gif GIF_ELEPHANT_TALKING; //Jungle1
 Gif GIF_SLOTH_TALKING; //Jungle2
 */

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

  // load image that says "Zoo guess who click here to start"
  BACKGROUND_IMG = loadImage("data/welcome.png");
  image(BACKGROUND_IMG, 0, 0);


  // making all the background objects
  intro = new Intro();

  //loading all background first
  africa1 = new Africa1(4, false);
  africa2 = new Africa2(4, false);
  africa3 = new Africa3(4, false);

  asia1 = new Asia1(4, false);
  asia2 = new Asia2(4, false);

  frosty1 = new Frosty1(4, false);
  frosty2 = new Frosty2(4, false);

  jungle1 = new Jungle1(4, false);
  jungle2 = new Jungle2(4, false);

  LIST_OF_HABITATS[0] = africa1;
  LIST_OF_HABITATS[1] = africa2;
  LIST_OF_HABITATS[2] = africa3;
  LIST_OF_HABITATS[3] = asia1;
  LIST_OF_HABITATS[4] = asia2;
  LIST_OF_HABITATS[5] = frosty1;
  LIST_OF_HABITATS[6] = frosty2;
  LIST_OF_HABITATS[7] = jungle1;
  LIST_OF_HABITATS[8] = jungle2;


  nav = new Nav();
  arrows = new Arrows();
  map = new Map();

  // randomly chooses which animal and which 
  // iteration of that animal the user will play
  chooseUserAnimal();

  println(LIST_OF_HABITATS[0]);

  // Setting up sound engine
  minim = new Minim(this);
  
  CALVIN_CAMEL_TEST = minim.loadSample("calvin_camel_test.mp3", 512);
  ELIZA_ELEPHANT_TEST = minim.loadSample("eliza_elephant_test.mp3", 512);
  GERRY_GIRAFFE_TEST = minim.loadSample("gerry_giraffe_test.mp3", 512);
  LEONARD_LION_TEST = minim.loadSample("leonard_lion_test.mp3", 512);
  PATTY_PANDABEAR_TEST = minim.loadSample("patty_pandabear_test.mp3", 512);
  PETER_PENGUIN_TEST = minim.loadSample("peter_penguin_test.mp3", 512);
  SAM_SEALION_TEST = minim.loadSample("sam_sealion_test.mp3", 512);
  STANLEY_SLOTH_TEST = minim.loadSample("stanley_sloth_test.mp3", 512);
  TINA_TIGER_TEST = minim.loadSample("tina_tiger_test.mp3", 512);

  // Setting up gifs of animals talking
  GIFS_CAMEL_TALKING = Gif.getPImages(this, "data/calvin_talk_288.gif");
  GIFS_GIRAFFE_TALKING = Gif.getPImages(this, "data/gerry_talk_288.gif");
  GIFS_TIGER_TALKING  = Gif.getPImages(this, "data/tina_talk_288.gif");
  GIFS_LION_TALKING = Gif.getPImages(this, "data/leonard_talk_288.gif");
  // initializing GIFs for talking animals
  /* Gif GIF_TIGER_TALKING = new Gif(this, xxxx); //Asia1
   Gif GIF_PANDA_TALKING = new Gif(this, xxxx); //Asia2
   Gif GIF_PENGUIN_TALKING = new Gif(this, xxxx); //Frosty1
   Gif GIF_SEAL_TALKING = new Gif(this, xxxx); //Frosty2
   Gif GIF_ELEPHANT_TALKING = new Gif(this, xxxx); //Jungle1
   Gif GIF_SLOTH_TALKING = new Gif(this, xxxx); //Jungle2
   */
}

//randomly chooses which animal the user is 
// and which group of 6 animal interacts with
void chooseUserAnimal() {
  float random_number = random(0, 6);
  if (random_number < 1) {
    USER = "gorillaA";
  }
  else if (random_number < 2) {
    USER = "gorillaB";
  }
  else if (random_number < 3) {
    USER = "polarbearA";
  }
  else if (random_number < 4) {
    USER = "polarbearB";
  }
  else if (random_number < 5) {
    USER = "cobraA";
  }
  else if (random_number < 6) {
    USER = "cobraB";
  }
  println(USER);
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
    (current_time - ANIMAL_TALKING_START_TIME >= LIST_OF_HABITATS[HABITAT_NUMBER].lengthCurrentTalk())) {
    ANIMAL_TALKING = false;
    doScene(HABITAT_NUMBER);
  }
  //to display the correct animal for current habitat
  if (!ON_MAP && !WELCOME_SCREEN) { 
    doScene(HABITAT_NUMBER);
    LIST_OF_HABITATS[HABITAT_NUMBER].displayAnimal(); //HERE IS WHERE ANIMALS ARE DISPLAYED, IF UNCOMMENT MEM PROBZ
  }

  drawCursor();
  printMem(); //DEBUG: To monitor memory usage
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

  if (ANIMAL_TALKING) {
    cursor(ARROW);
  }

  else if 
    (cursorOverMapButton() || 
    cursor_over_help() || 
    cursor_over_left() ||
    cursor_over_right() ||
    LIST_OF_HABITATS[HABITAT_NUMBER].cursorOverAnimal() ||
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
  INTRO_SCREEN = true;
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
  africa1.display();
  arrows.display();
}
void doAfrica2() {
  africa2.display();
  arrows.display();
}

void doAfrica3() {
  africa3.display();
  arrows.display();
}

void doAsia1() {
  asia1.display();
  arrows.display();
}

void doAsia2() {
  asia2.display();
  arrows.display();
}

void doFrosty1() {
  frosty1.display();
  arrows.display();
}

void doFrosty2() {
  frosty2.display();
  arrows.display();
}

void doJungle1() {
  jungle1.display();
  arrows.display();
}

void doJungle2() {
  jungle2.display();
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
// determines what actiosn to perform if on map
void mousePressedOnMap() {
  if (cursor_over_africa1()) {
    doAfrica1();
    HABITAT_NUMBER = 0;
    ON_MAP = false;
  }
  else if (cursor_over_africa2()) {
    doAfrica2();
    HABITAT_NUMBER = 1;
    ON_MAP = false;
  }
  else if (cursor_over_africa3()) {
    doAfrica3();
    HABITAT_NUMBER = 2;
    ON_MAP = false;
  }
  else if (cursor_over_asia1()) {
    doAsia1();
    HABITAT_NUMBER = 3;
    ON_MAP = false;
  }
  else if (cursor_over_asia2()) {
    doAsia2();
    HABITAT_NUMBER = 4;
    ON_MAP = false;
  }
  else if (cursor_over_frosty1()) {
    doFrosty1();
    HABITAT_NUMBER = 5;
    ON_MAP = false;
  }
  else if (cursor_over_frosty2()) {
    doFrosty2();
    HABITAT_NUMBER = 6;
    ON_MAP = false;
  }
  else if (cursor_over_jungle1()) {
    doJungle1();
    HABITAT_NUMBER = 7;
    ON_MAP = false;
  }
  else if (cursor_over_jungle2()) {
    doJungle2();
    HABITAT_NUMBER = 8;
    ON_MAP = false;
  }
}


// to update the scene the user is on
// when they click on an arrow key as specified by query
int updateSceneNumber(String query) {
  if (query.equals("left") && HABITAT_NUMBER == 0) {
    HABITAT_NUMBER = 8;
  }
  else if (query.equals("right") && HABITAT_NUMBER == 8) {
    HABITAT_NUMBER = 0;
  }
  else if (query.equals("left")) {
    HABITAT_NUMBER--;
  }
  else { // assume query == "right" 
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
