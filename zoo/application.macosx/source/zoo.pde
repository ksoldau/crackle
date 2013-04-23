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

//clues
PImage TEST_CLUE1;
PImage TEST_CLUE2;
PImage TEST_CLUE3;
PImage TEST_CLUE4;

PImage GA_CLUE1;
PImage GA_CLUE2;
PImage GA_CLUE3;
PImage GA_CLUE4;

//guess scene
PImage GUESS_SCENE_BG;

// declaring variables outside of setup so they can be used anywhere
// a la "public" in standard java
int ANIMAL_TALKING_START_TIME;

PImage BACKGROUND_IMG;
Intro intro;
Win WIN;

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

//States for each Habitat class
int AFRICA1_STATE;
int AFRICA2_STATE;
int AFRICA3_STATE;

int ASIA1_STATE;
int ASIA2_STATE;

int FROSTY1_STATE;
int FROSTY2_STATE;

int JUNGLE1_STATE;
int JUNGLE2_STATE;


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


//Dummy lines
AudioSample CAMEL_DUMMY;
AudioSample GIRAFFE_DUMMY;
AudioSample LION_DUMMY;
AudioSample TIGER_DUMMY;
AudioSample PANDA_DUMMY;
AudioSample PENGUIN_DUMMY;
AudioSample SEAL_DUMMY;
AudioSample ELEPHANT_DUMMY;
AudioSample SLOTH_DUMMY;

//Audio for just GORILLA_A
AudioSample GA_CAMEL1;
AudioSample GA_CAMEL2;
AudioSample GA_LION1;
AudioSample GA_LION2;
AudioSample GA_LION3;
AudioSample GA_PANDA1;
AudioSample GA_PANDA2;
AudioSample GA_SEAL1;
AudioSample GA_ELEPHANT1;
AudioSample GA_SLOTH1;
AudioSample GA_SLOTH2;

//Audio for just GORILLA_B
AudioSample GB_SEAL1;
AudioSample GB_CAMEL1;
AudioSample GB_PENGUIN1;
AudioSample GB_PENGUIN2;
AudioSample GB_GIRAFFE1;
AudioSample GB_TIGER1;
AudioSample GB_SLOTH1;

//Audio for just COBRA_A
AudioSample CA_PENGUIN1;
AudioSample CA_CAMEL1;
AudioSample CA_PANDA1;
AudioSample CA_PANDA2;
AudioSample CA_ELEPHANT1;
AudioSample CA_LION1;
AudioSample CA_TIGER1;

//Audio for just COBRA_B
AudioSample CB_GIRAFFE1;
AudioSample CB_LION1;
AudioSample CB_TIGER1;
AudioSample CB_SLOTH1;
AudioSample CB_SLOTH2;
AudioSample CB_PANDA1;
AudioSample CB_GIRAFFE2;
AudioSample CB_PANDA2;
AudioSample CB_SEAL1;

//Audio for just POLAR_A
AudioSample PA_ELEPHANT1;
AudioSample PA_CAMEL1;
AudioSample PA_PENGUIN1;
AudioSample PA_PENGUIN2;
AudioSample PA_PANDA1;
AudioSample PA_PANDA2;
AudioSample PA_SLOTH1;
AudioSample PA_SLOTH2;
AudioSample PA_GIRAFFE1;
AudioSample PA_GIRAFFE2;


//Audio for just POLAR_B
AudioSample PB_TIGER1;
AudioSample PB_GIRAFFE1;
AudioSample PB_ELEPHANT1;
AudioSample PB_SEAL1; 
AudioSample PB_SEAL2;
AudioSample PB_PENGUIN1;
AudioSample PB_PANDA1;


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
boolean ON_GUESS = false;

//current habitat number
int HABITAT_NUMBER;

//last habitat number
int LAST_HABITAT_NUMBER = 0;

//is the current animal talking
boolean ANIMAL_TALKING = false;

//did user make animal snore
boolean Z = false;

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

//Gifs and other information for effects
PImage[] GIFS_ZS;
int NUMZFRAMES = 13;


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
  //chooseUser(); ******
  USER = "GORILLA_A";

  //chooses correct habitat number to start on based on user animal
  setFirstHabitatNumber();

  //loading all animal classes
  //depends on which animal/iteration the user is 
  loadAnimalClasses();
  loadClueImages();

  //initialize states of habitats
  AFRICA1_STATE = 0;
  AFRICA2_STATE = 0;
  AFRICA3_STATE = 0;

  ASIA1_STATE = 0;
  ASIA2_STATE = 0;

  FROSTY1_STATE = 0;
  FROSTY2_STATE = 0;

  JUNGLE1_STATE = 0;
  JUNGLE2_STATE = 0;

  LIST_OF_HABITATS[0] = AFRICA1;
  LIST_OF_HABITATS[1] = AFRICA2;
  LIST_OF_HABITATS[2] = AFRICA3;
  LIST_OF_HABITATS[3] = ASIA1;
  LIST_OF_HABITATS[4] = ASIA2;
  LIST_OF_HABITATS[5] = FROSTY1;
  LIST_OF_HABITATS[6] = FROSTY2;
  LIST_OF_HABITATS[7] = JUNGLE1;
  LIST_OF_HABITATS[8] = JUNGLE2;



  //initialize the navigation bar class
  nav = new Nav();
  
  //initialize the class for the arrows
  arrows = new Arrows();
  
  //initialize the class for the map
  map = new Map();
  
  //initialize the win class
  WIN = new Win();

  // Setting up sound engine
  minim = new Minim(this);

  AFRICA_BG = minim.loadFile("africa_bg.mp3", 512);
  FROSTY_BG = minim.loadFile("frosty_bg.mp3", 512);
  ASIA_BG = minim.loadFile("asia_bg.mp3", 512);
  JUNGLE_BG = minim.loadFile("jungle_bg.mp3", 512);

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

  //initializing lists for GIfs of effects
  GIFS_ZS = Gif.getPImages(this, "data/z.gif");

  GUESS_SCENE_BG = loadImage("data/guesswho.png");


  initializeAudio();
}

//sets the first habitat the user sees to correct one
//based on USER
void setFirstHabitatNumber() {
  if (USER == "GORILLA_A") {
    HABITAT_NUMBER = 0;
  }
  else if (USER == "GORILLA_B") {
    HABITAT_NUMBER = 6;
  }
  else if (USER == "COBRA_A") {
    HABITAT_NUMBER = 5;
  }
  else if (USER == "COBRA_B") {
    HABITAT_NUMBER = 1;
  }
  else if (USER == "POLAR_A") {
    HABITAT_NUMBER = 7;
  }
  else if (USER == "POLAR_B") {
    HABITAT_NUMBER = 3;
  }
}

//initialize the audio
void initializeAudio() {
  //Dummy lines
  CAMEL_DUMMY = minim.loadSample("CAMEL_DUMMY.mp3", 512);
  GIRAFFE_DUMMY = minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
  LION_DUMMY = minim.loadSample("LION_DUMMY.mp3", 512);
  TIGER_DUMMY = minim.loadSample("TIGER_DUMMY.mp3", 512);
  PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
  PENGUIN_DUMMY = minim.loadSample("PENGUIN_DUMMY.mp3", 512);
  SEAL_DUMMY = minim.loadSample("SEAL_DUMMY.mp3", 512);
  ELEPHANT_DUMMY = minim.loadSample("ELEPHANT_DUMMY.mp3", 512);
  SLOTH_DUMMY = minim.loadSample("SLOTH_DUMMY.mp3", 512);

  //Audio for just GORILLA_A
  if (USER == "GORILLA_A") {
    GA_CAMEL1 = minim.loadSample("GA_CAMEL1.mp3", 512);
    GA_ELEPHANT1 = minim.loadSample("GA_ELEPHANT1.mp3", 512); 
    GA_PANDA1 = minim.loadSample("GA_PANDA1.mp3", 512);
    GA_SLOTH1 = minim.loadSample("GA_SLOTH1.mp3", 512);
    GA_PANDA2 = minim.loadSample("GA_PANDA2.mp3", 512);
    GA_SEAL1 = minim.loadSample("GA_SEAL1.mp3", 512);
    GA_CAMEL2 = minim.loadSample("GA_CAMEL2.mp3", 512);
    GA_LION1 = minim.loadSample("GA_LION1.mp3", 512);
    GA_SLOTH2 = minim.loadSample("GA_SLOTH2.mp3", 512);
    GA_LION2 = minim.loadSample("GA_LION2.mp3", 512);
    GA_LION3 = minim.loadSample("GA_LION3.mp3", 512);
  }


  else if (USER == "GORILLA_B") {
    //Audio for just GORILLA_B
    GB_SEAL1 = minim.loadSample("GB_SEAL1.mp3", 512);
    GB_CAMEL1 = minim.loadSample("GB_CAMEL1.mp3", 512);
    GB_PENGUIN1 = minim.loadSample("GB_PENGUIN1.mp3", 512);
    GB_PENGUIN2 = minim.loadSample("GB_PENGUIN2.mp3", 512);
    GB_GIRAFFE1 = minim.loadSample("GB_GIRAFFE1.mp3", 512);
    GB_TIGER1 = minim.loadSample("GB_TIGER1.mp3", 512);
    GB_SLOTH1 = minim.loadSample("GB_SLOTH1.mp3", 512);
  }

  //Audio for just COBRA_A
  else if (USER == "COBRA_A") {
    CA_PENGUIN1 = minim.loadSample("CA_PENGUIN1.mp3", 512);
    CA_CAMEL1 = minim.loadSample("CA_CAMEL1.mp3", 512);
    CA_PANDA1 = minim.loadSample("CA_PANDA1.mp3", 512);
    CA_PANDA2 = minim.loadSample("CA_PANDA2.mp3", 512);
    CA_ELEPHANT1 = minim.loadSample("CA_ELEPHANT1.mp3", 512);
    CA_LION1 = minim.loadSample("CA_LION1.mp3", 512);
    CA_TIGER1 = minim.loadSample("CA_TIGER1.mp3", 512);
  }

  //Audio for just COBRA_B
  else if (USER == "COBRA_B") {
    CB_GIRAFFE1 = minim.loadSample("CB_GIRAFFE1.mp3", 512);
    CB_LION1 = minim.loadSample("CB_LION1.mp3", 512);
    CB_TIGER1 = minim.loadSample("CB_TIGER1.mp3", 512);
    CB_SLOTH1 = minim.loadSample("CB_SLOTH1.mp3", 512);
    CB_SLOTH2 = minim.loadSample("CB_SLOTH2.mp3", 512);
    CB_PANDA1 = minim.loadSample("CB_PANDA1.mp3", 512);
    CB_GIRAFFE2 = minim.loadSample("CB_GIRAFFE2.mp3", 512);
    CB_PANDA2 = minim.loadSample("CB_PANDA2.mp3", 512);
    CB_SEAL1 = minim.loadSample("CB_SEAL1.mp3", 512);
  }

  else if (USER == "POLAR_A") {
    //Audio for just POLAR_A
    PA_ELEPHANT1 = minim.loadSample("PA_ELEPHANT1.mp3", 512);
    PA_CAMEL1 = minim.loadSample("PA_CAMEL1.mp3", 512);
    PA_PENGUIN1 = minim.loadSample("PA_PENGUIN1.mp3", 512);
    PA_PENGUIN2 = minim.loadSample("PA_PENGUIN2.mp3", 512);
    PA_PANDA1 = minim.loadSample("PA_PANDA1.mp3", 512);
    PA_PANDA2 = minim.loadSample("PA_PANDA2.mp3", 512);
    PA_SLOTH1 = minim.loadSample("PA_SLOTH1.mp3", 512);
    PA_SLOTH2 = minim.loadSample("PA_SLOTH2.mp3", 512);
    PA_GIRAFFE1 = minim.loadSample("PA_GIRAFFE1.mp3", 512);
    PA_GIRAFFE2 = minim.loadSample("PA_GIRAFFE2.mp3", 512);
  }

  //Audio for just POLAR_B
  else if (USER == "POLAR_B") {
    PB_TIGER1 = minim.loadSample("PB_TIGER1.mp3", 512);
    PB_GIRAFFE1 = minim.loadSample("PB_GIRAFFE1.mp3", 512);
    PB_ELEPHANT1 = minim.loadSample("PB_ELEPHANT1.mp3", 512);
    PB_SEAL1 = minim.loadSample("PB_SEAL1.mp3", 512);
    PB_SEAL2 = minim.loadSample("PB_SEAL2.mp3", 512);
    PB_PENGUIN1 = minim.loadSample("PB_PENGUIN1.mp3", 512);
    PB_PANDA1 = minim.loadSample("PB_PANDA1.mp3", 512);
  }
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
    AFRICA1 = new Africa1(false);
    AFRICA2 = new Africa2(true);
    AFRICA3 = new Africa3(false);
    ASIA1 = new Asia1(true);
    ASIA2 = new Asia2(false);
    FROSTY1 = new Frosty1(true);
    FROSTY2 = new Frosty2(false);
    JUNGLE1 = new Jungle1(false);
    JUNGLE2 = new Jungle2(false);
  }
  else if (USER == "GORILLA_B") {
    AFRICA1 = new Africa1(false);
    AFRICA2 = new Africa2(false);
    AFRICA3 = new Africa3(true);
    ASIA1 = new Asia1(false);
    ASIA2 = new Asia2(true);
    FROSTY1 = new Frosty1(false);
    FROSTY2 = new Frosty2(false);
    JUNGLE1 = new Jungle1(true);
    JUNGLE2 = new Jungle2(false);
  }
  else if (USER == "COBRA_A") {
    AFRICA1 = new Africa1(false);
    AFRICA2 = new Africa2(true);
    AFRICA3 = new Africa3(false);
    ASIA1 = new Asia1(false);
    ASIA2 = new Asia2(false);
    FROSTY1 = new Frosty1(false);
    FROSTY2 = new Frosty2(true);
    JUNGLE1 = new Jungle1(false);
    JUNGLE2 = new Jungle2(true);
  }
  else if (USER == "COBRA_B") {
    AFRICA1 = new Africa1(true);
    AFRICA2 = new Africa2(false);
    AFRICA3 = new Africa3(false);
    ASIA1 = new Asia1(false);
    ASIA2 = new Asia2(false);
    FROSTY1 = new Frosty1(true);
    FROSTY2 = new Frosty2(false);
    JUNGLE1 = new Jungle1(true);
    JUNGLE2 = new Jungle2(false);
  }
  else if (USER == "POLAR_A") {
    AFRICA1 = new Africa1(false);
    AFRICA2 = new Africa2(false);
    AFRICA3 = new Africa3(true);
    ASIA1 = new Asia1(true);
    ASIA2 = new Asia2(false);
    FROSTY1 = new Frosty1(false);
    FROSTY2 = new Frosty2(true);
    JUNGLE1 = new Jungle1(false);
    JUNGLE2 = new Jungle2(false);
  }
  else if (USER == "POLAR_B") {
    AFRICA1 = new Africa1(true);
    AFRICA2 = new Africa2(false);
    AFRICA3 = new Africa3(true);
    ASIA1 = new Asia1(false);
    ASIA2 = new Asia2(false);
    FROSTY1 = new Frosty1(false);
    FROSTY2 = new Frosty2(false);
    JUNGLE1 = new Jungle1(false);
    JUNGLE2 = new Jungle2(true);
  }
}

void loadClueImages() {
  if (USER == "GORILLA_A") {
    GA_CLUE1 = loadImage("data/fur.png");
    GA_CLUE2 = loadImage("data/plants.png");
    GA_CLUE3 = loadImage("data/twolegs.png");
    GA_CLUE4 = loadImage("data/blackfur.png");
  }
  else {
    TEST_CLUE1 = loadImage("data/test_clue1.png");
    TEST_CLUE2 = loadImage("data/test_clue2.png");
    TEST_CLUE3 = loadImage("data/test_clue3.png");
    TEST_CLUE4 = loadImage("data/test_clue4.png");
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
  
  if (LAST_HABITAT_NUMBER != HABITAT_NUMBER) {
    Z = false;//cancel the Zs
  }
  
  int current_time = millis();
  
  //to stop the animal from visibly speaking if audio over
  if (ANIMAL_TALKING && 
    (current_time - ANIMAL_TALKING_START_TIME >= LIST_OF_HABITATS[HABITAT_NUMBER].currentTalk().length())) {
    ANIMAL_TALKING = false;
    doScene(HABITAT_NUMBER);
  }
  //to display the correct animal for current habitat
  else if (ON_GUESS) {
  }
  
  //plays any animated gifs
  else if (!ON_MAP && !WELCOME_SCREEN && !ON_INTRO) { 
    doScene(HABITAT_NUMBER);
    LIST_OF_HABITATS[HABITAT_NUMBER].displayAnimal(); //HERE IS WHERE ANIMALS ARE DISPLAYED
    println(Z);
    if (Z) {
      LIST_OF_HABITATS[HABITAT_NUMBER].displayZs();
      println(Z);
    }
  }

  drawCursor();
  //printMem(); //DEBUG: To monitor memory usage
  
  //plays correct background music
  if (!WELCOME_SCREEN && !ON_INTRO) {
    whenPlay();
  }
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

//play the correct background music
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
//NOTE: *** does not currently show hand when on guess screen
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
  nav.display();
}
void doAfrica2() {
  AFRICA2.display();
  arrows.display();
  nav.display();
}

void doAfrica3() {
  AFRICA3.display();
  arrows.display();
  nav.display();
}

void doAsia1() {
  ASIA1.display();
  arrows.display();
  nav.display();
}

void doAsia2() {
  ASIA2.display();
  arrows.display();
  nav.display();
}

void doFrosty1() {
  FROSTY1.display();
  arrows.display();
  nav.display();
}

void doFrosty2() {
  FROSTY2.display();
  arrows.display();
  nav.display();
}

void doJungle1() {
  JUNGLE1.display();
  arrows.display();
  nav.display();
}

void doJungle2() {
  JUNGLE2.display();
  arrows.display();
  nav.display();
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

  else if (ON_GUESS) {
    WIN.mousePressedOnGuess();
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


//--------------------------------------------
void mouseMoved() {
  if (!WELCOME_SCREEN && !ON_MAP && !ON_GUESS && !ON_INTRO) {
    //LIST_OF_HABITATS[HABITAT_NUMBER].mouseOverInHabitat();
    LIST_OF_HABITATS[HABITAT_NUMBER].mouseMovedInHabitat();
  }
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

static public void main(String args[]) {
    PApplet.main(new String[] { "zoo" });
}


