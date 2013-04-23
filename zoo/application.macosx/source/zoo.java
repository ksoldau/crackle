import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.spi.*; 
import ddf.minim.signals.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import ddf.minim.ugens.*; 
import ddf.minim.effects.*; 
import java.text.NumberFormat; 
import gifAnimation.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class zoo extends PApplet {









 //from http://www.extrapixel.ch/processing/gifAnimation/

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
public void setup() {
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
public void setFirstHabitatNumber() {
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
public void initializeAudio() {
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
public void chooseUser() {
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

public void loadAnimalClasses() {
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

public void loadClueImages() {
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
public void draw() {
  
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

public void printMem() {
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

public void playBg() {  
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

public void pauseAll() {
  AFRICA_BG.pause();
  ASIA_BG.pause();
  JUNGLE_BG.pause();
  FROSTY_BG.pause();
}

//play the correct background music
public void whenPlay() {
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
public void drawCursor() {
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
public void doScene(int i) {
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
public void doIntro() {
  intro.display();
  arrows.display();
  nav.display();
  //ON_INTRO = true;
}

// map screen
public void doMap() {
  map.display();
  ON_MAP = true;
}

//---------------------
// all of the do methods display the habitat for each 
// specified habitat
// arrows are displayed because the backgrounds will hide them.

public void doAfrica1() {
  AFRICA1.display();
  arrows.display();
  nav.display();
}
public void doAfrica2() {
  AFRICA2.display();
  arrows.display();
  nav.display();
}

public void doAfrica3() {
  AFRICA3.display();
  arrows.display();
  nav.display();
}

public void doAsia1() {
  ASIA1.display();
  arrows.display();
  nav.display();
}

public void doAsia2() {
  ASIA2.display();
  arrows.display();
  nav.display();
}

public void doFrosty1() {
  FROSTY1.display();
  arrows.display();
  nav.display();
}

public void doFrosty2() {
  FROSTY2.display();
  arrows.display();
  nav.display();
}

public void doJungle1() {
  JUNGLE1.display();
  arrows.display();
  nav.display();
}

public void doJungle2() {
  JUNGLE2.display();
  arrows.display();
  nav.display();
}

//------------------------------------
//actions to take if mouse is pressed

// assume: on welcome screen
// determines what actions to perform if mouse pressed 
public void mousePressedWelcomeScreen() {
  if (cursor_over_start() && mousePressed == true) {
    doIntro();
    WELCOME_SCREEN = false;
  }
}

// if mouse is pressed, do this stuff 
public void mousePressed() {
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
public void mousePressedOnMap() {
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
public int updateSceneNumber(String query) {
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
public void mouseMoved() {
  if (!WELCOME_SCREEN && !ON_MAP && !ON_GUESS && !ON_INTRO) {
    //LIST_OF_HABITATS[HABITAT_NUMBER].mouseOverInHabitat();
    LIST_OF_HABITATS[HABITAT_NUMBER].mouseMovedInHabitat();
  }
}


//---------------------------------------------
// determine if cursor is over a certain area 

// determines if cursor in a certain box
public boolean cursor_over(int xmin, int xmax, int ymin, int ymax) {
  return xmin < mouseX && mouseX < xmax && ymin < mouseY && mouseY < ymax;
}

// determines if cursor over the start button 
// assume: on welcome page
public boolean cursor_over_start() {
  return cursor_over(STARTXi, STARTXf, STARTYi, STARTYf);
}


//assume: not on welcome screen, not on map
// determines if mouse pressed in a habitat
public boolean cursorOverHabitat() {
  return cursor_over(0, 960, 0, 540);
}


// determines if cursor over map 
public boolean cursorOverMapButton() {
  return cursor_over(MAPXi, MAPXf, MAPYi, MAPYf);
}
public boolean cursor_over_help() {
  return cursor_over(HELPXi, HELPXf, HELPYi, HELPYf);
}
public boolean cursor_over_left() {
  return cursor_over(LEFTXi, LEFTXf, LEFTYi, LEFTYf);
}
public boolean cursor_over_right() {
  return cursor_over(RIGHTXi, RIGHTXf, RIGHTYi, RIGHTYf);
}

// assuming in the map
public boolean cursor_over_africa1() {
  return cursor_over(473, 562, 96, 160);
}
public boolean cursor_over_africa2() {
  return cursor_over(564, 654, 171, 237);
}
public boolean cursor_over_africa3() {
  return cursor_over(581, 670, 270, 336);
}
public boolean cursor_over_asia1() {
  return cursor_over(527, 616, 370, 435);
}
public boolean cursor_over_asia2() {
  return cursor_over(423, 513, 409, 474);
}
public boolean cursor_over_frosty1() {
  return cursor_over(318, 407, 369, 433);
}
public boolean cursor_over_frosty2() {
  return cursor_over(267, 356, 272, 336);
}
public boolean cursor_over_jungle1() {
  return cursor_over(283, 372, 171, 235);
}
public boolean cursor_over_jungle2() {
  return cursor_over(373, 461, 95, 159);
}

static public void main(String args[]) {
    PApplet.main(new String[] { "zoo" });
}


public abstract class Habitat { 

  boolean isSleeping;
  
  int frameZs = 0; 

  Habitat(boolean isSleeping) {
    this.isSleeping = isSleeping;
  } 

  PImage background =  loadImage("data/africa_1.png");  

  //displays the background of the scene
  public abstract void display();

  //displays the animal
  public abstract void displayAnimal();

  //determines if cursor over animal in the habitat
  public abstract boolean cursorOverAnimal();

  //decides which actions to take if mouse was pressed in this habitat
  public abstract void mousePressedInHabitat();

  //decides what to do if moused over in habitat
  //abstract void mouseOverInHabitat();

  //determines what the current talk is 
  public abstract AudioSample currentTalk(); 

  //plays correct lines for animal
  public abstract void playCurrentTalk();

  //updates necessary state numbers for habitats/animals
  public abstract void updateStateNumbers();
  
  //display the Zs (when mouse over sleeping animal)
  public void displayZs() {
    frameZs = (frameZs + 1);
    if (frameZs < 13) {
      image(GIFS_ZS[frameZs], 200, 200);
    }
    else {
      Z = false;
      frameZs = 0;
    }
  }
  
    //decides what to do if something moused over
  public void mouseMovedInHabitat() {
    if (this.isSleeping && cursorOverAnimal()) {
      Z = true;
      println(Z);
      //displayZs();
    }
  }
}

// Calvin Camel
class Africa1 extends Habitat {  
  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 500;
  int animalTop = 100;
  int animalSleepingLeft = 200;
  int animalSleepingTop = 200;

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
  public void displayAnimal() {
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
  public void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_CAMEL_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal 
  public void displayAnimalNotTalking() {
    image(GIFS_CAMEL_TALKING[0], animalLeft, animalTop);
    //image(animal_not_talking, animalLeft, animalTop);
  }

  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  public void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) { 
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk(); //sound
    }
  }

  //play correct audio
  public void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    println("GOT TO CURrent talk");
    updateStateNumbers();
  }

  //update state numbers after animal has spoken
  public void updateStateNumbers() {
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
  public boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
        && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    }
  }

  //plays what the animal should currently be saying
  public AudioSample currentTalk() {
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

// Gerry Giraffe
class Africa2 extends Habitat {
  int frame;
  int numTalkingFrames = 8;

  int animalLeft = 500;
  int animalTop = 100;
  
  int animalSleepingLeft = 400;
  int animalSleepingTop = 100;
  

  PImage animal_not_talking = loadImage("data/gerry_giraffe.gif");
  PImage background = loadImage("data/africa_2.png");
  PImage animal_sleeping = loadImage("data/gerry_sleep_288.png");

  Africa2(boolean isSleeping) {
    super(isSleeping);
  }
  //displays the background for the habitat
  public void display() {
    image(this.background, 0, 0);
  } 

  //determines if the animal in the habitat was clicked on
  public void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, animalSleepingLeft, animalSleepingTop);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //display the talking animal
  public void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_GIRAFFE_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal
  public void displayAnimalNotTalking() {
    image(GIFS_GIRAFFE_TALKING[0], animalLeft, animalTop);
  }

  //determines if the mouse was pressed on an animal
  public boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
      && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else { 
    return ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
      && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

  public void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (AFRICA2_STATE == 2) && USER == "POLAR_A") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }


  //play correct audio
  public void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    updateStateNumbers();
  }

  public void updateStateNumbers() {
    if (USER == "GORILLA_A") {
    } //Gerry Giraffe is asleep
    else if (USER == "GORILLA_B") {
      if (AFRICA2_STATE == 1) {
        AFRICA2_STATE ++;
        FROSTY1_STATE ++;
        nav.clue2 = true; //climb trees
      }
    }
    else if (USER == "COBRA_A") {
    } //Gerry Giraffe is asleep
    else if (USER == "COBRA_B") {
      if (AFRICA2_STATE == 0) {
        AFRICA2_STATE ++;
        AFRICA3_STATE ++;
        nav.clue1 = true;
      }
      if (AFRICA2_STATE == 2) {
        AFRICA2_STATE ++;
        ASIA2_STATE ++; //Patty Panda
      }
    }
    else if (USER == "POLAR_A") {
      if (AFRICA2_STATE == 1) {
        AFRICA2_STATE ++;
      }
    }
    else if (USER == "POLAR_B") {
      if (AFRICA2_STATE == 1) {
        AFRICA2_STATE ++;
        JUNGLE1_STATE ++;
        nav.clue1 = true; //four paws
      }
    }
  }

  //gets the current line the animal will be/is speaking
  public AudioSample currentTalk() {
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

// Leonard Lion
class Africa3 extends Habitat {
  int frame;
  int numTalkingFrames = 6; //al might export one with more frames

  int animalLeft = 300;
  int animalTop = 50;
  
  int animalSleepingLeft = 200;
  int animalSleepingTop = 200;

  PImage background = loadImage("data/africa_3.png");
  PImage animal_not_talking =  loadImage("data/leonard_lion.gif");

  Africa3(boolean isSleeping) {
    super(isSleeping);
  }


  //displays the correct animal
  public void displayAnimal() {
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

  //display the talking anial
  public void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_LION_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal
  public void displayAnimalNotTalking() {
    image(GIFS_LION_TALKING[0], animalLeft, animalTop);
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }

  // determines if 
  public boolean cursorOverAnimal() {   
    if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
        && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

  public void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (AFRICA3_STATE == 4) && USER == "GORILLA_A") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }


  //play correct audio
  public void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    updateStateNumbers();
  }

  public void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (AFRICA3_STATE == 1) {
        AFRICA3_STATE ++;
        JUNGLE2_STATE ++; //SLOTH
      }
      if (AFRICA3_STATE == 3) {
        AFRICA3_STATE ++; //to get to final screen kind of
      }
    }
    else if (USER == "GORILLA_B") {
    }//Leonard Lion is asleep
    else if (USER == "COBRA_A") {
      if (AFRICA3_STATE == 1) {
        AFRICA3_STATE ++;
        ASIA2_STATE ++;
        nav.clue2 = true;
      }
    }
    else if (USER == "COBRA_B") {
      if (AFRICA3_STATE == 1) {
        AFRICA3_STATE++;
        ASIA1_STATE ++;
        nav.clue1 = true;
      }
    }
  }

  //gets the current line the animal will be/is speaking
  public AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (AFRICA3_STATE == 0) { 
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 1) {
        return GA_LION1;
      }
      else if (AFRICA3_STATE == 2) {
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 3) {
        return GA_LION2;
      }
      else if (AFRICA3_STATE == 4) {
        return GA_LION3;
      }
    }
    else if (USER == "GORILLA_B") {
    } //Leonard Lion is sleeping
    else if (USER == "POLAR_A") {
      //Leonard Lion is asleep
    }
    else if (USER == "POLAR_B") {
      //Leonard Lion is asleep
    }
    else if (USER == "COBRA_A") {
      if (AFRICA3_STATE == 0) {
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 1) {
        return CA_LION1;
      }
      else if (AFRICA3_STATE == 2) {
        return LION_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      if (AFRICA3_STATE == 0) {
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 1) {
        return CB_LION1;
      }
      else if (AFRICA3_STATE == 2) {
        return LION_DUMMY;
      }
    }

    return LION_DUMMY;
  }
}

// Arrows
class Arrows {
  PImage background;

  Arrows() {
    this.background = loadImage("data/arrows.png");
  }

  public void display() {
    image(background, 0, 0);
  }
}


// Tina Tiger
class Asia1 extends Habitat {
  int frame;
  int numTalkingFrames = 8;

  int animalLeft = 500;
  int animalTop = 100;
  
  int animalSleepingLeft = 300;
  int animalSleepingTop = 250;


  PImage background = loadImage("data/asia_1.png");
  PImage animal_not_talking = loadImage("data/tina_tiger.gif");
  PImage animal_sleeping = loadImage("data/tina_sleep_288.png");

  Asia1(boolean isSleeping) {
    super(isSleeping);
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }

  //displays the correct animal
  public void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, animalSleepingLeft, animalSleepingTop);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //displays the talking animal 
  public void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_TIGER_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  public void displayAnimalNotTalking() {
    image(GIFS_TIGER_TALKING[0], animalLeft, animalTop);
  }

  //determines if the animal in the habitat was clicked on
  public boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
        && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else {
      return  ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

  public void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (ASIA1_STATE == 2) && USER == "COBRA_A") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }  


  //play correct audio
  public void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    updateStateNumbers();
  }

  public void updateStateNumbers() {
    if (USER == "GORILLA_A") {
    } //Tina Tiger is asleep
    else if (USER == "GORILLA_B") {
      if (ASIA1_STATE == 1) {
        println("GOT TO ASIA ONE STATE HERE YO");
        ASIA1_STATE ++;
        JUNGLE2_STATE ++;
        nav.clue4 = true; //black fur
      }
    }
    else if (USER == "COBRA_A") {
      if (ASIA1_STATE == 1) {
        ASIA1_STATE ++;
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA1_STATE == 1) {
        ASIA1_STATE ++;
        JUNGLE2_STATE ++;
        nav.clue2 = true;
      }
    }
    else if (USER == "POLAR_A") {
    } // Tina Tiger is asleep
    else if (USER == "POLAR_B") {
      if (ASIA1_STATE == 0) {
        ASIA1_STATE ++;
        AFRICA2_STATE ++;
      }
    }
  }

  //gets the current line the animal will be/is speaking
  public AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
    } // Tina Tiger is asleep
    else if (USER == "GORILLA_B") {
      if (ASIA1_STATE == 0) {
        return TIGER_DUMMY;
      }
      else if (ASIA1_STATE == 1) {
        return GB_TIGER1;
      }
      else if (ASIA1_STATE == 2) {
        return TIGER_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      //Tina Tiger is asleep
    }
    else if (USER == "POLAR_B") {
      if (ASIA1_STATE == 0) {
        return PB_TIGER1;
      }
      else if (ASIA1_STATE == 1) {
        return TIGER_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      if (ASIA1_STATE == 0) {
        return TIGER_DUMMY;
      }
      else if (ASIA1_STATE ==1) {
        return CA_TIGER1;
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA1_STATE == 0) {
        return TIGER_DUMMY;
      }
      else if (ASIA1_STATE == 1) {
        return CB_TIGER1;
      }
      else if (ASIA1_STATE == 2) {
        return TIGER_DUMMY;
      }
    }
    return CAMEL_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}




// Patty Panda
class Asia2 extends Habitat {
  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 500;
  int animalTop = 250;
  int animalSleepingLeft = 200;
  int animalSleepingTop = 200;


  PImage background = loadImage("data/asia_2.png");
  PImage animal_not_talking = loadImage("data/patty_pandabear.gif");

  Asia2(boolean isSleeping) {
    super(isSleeping);
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }
  //displays the correct animal 
  public void displayAnimal() {
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

  //displays the talking animal 
  public void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_PANDA_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  public void displayAnimalNotTalking() {
    image(GIFS_PANDA_TALKING[0], animalLeft, animalTop);
  }

  public boolean cursorOverAnimal() {   
    if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
        && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

  public void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (ASIA2_STATE == 2) && USER == "POLAR_B") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }  

  //play correct audio
  public void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    updateStateNumbers();
  }

  public void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        JUNGLE2_STATE ++; //Stanley Sloth
      }
      if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        FROSTY2_STATE ++;//Sam Seal
        nav.clue2 = true; //love to eat plants
      }
    }
    else if (USER == "GORILLA_B") { //Patty Panda is asleep
    }
    else if (USER == "COBRA_A") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        AFRICA3_STATE ++;
      }
      else if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        JUNGLE1_STATE ++;
        nav.clue3 = true;
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        AFRICA2_STATE ++;
      }
      if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        FROSTY2_STATE ++;
        nav.clue4 = true; //eats mice
      }
    }
    else if (USER == "POLAR_A") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        FROSTY1_STATE ++;
      }
      else if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        JUNGLE2_STATE ++;
        nav.clue3 = true; //black nose
      }
    }
    else if (USER == "POLAR_B") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++; //last person
      }
    }
  }

  //gets the current line the animal will be/is speaking
  public AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (ASIA2_STATE == 0) { 
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return GA_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return GA_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
    } //Patty Panda is asleep
    else if (USER == "POLAR_A") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return PA_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return PA_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return PB_PANDA1;
      }
    }
    else if (USER == "COBRA_A") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return CA_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return CA_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return CB_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return CB_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    return PANDA_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}

// Peter Penguin
class Frosty1 extends Habitat {  
  int frame;
  int numTalkingFrames = 4;

  int animalLeft = 200;
  int animalTop = 160;
  int animalSleepingLeft = 200;
  int animalSleepingTop = 200;


  PImage background = loadImage("data/frosty_1.png");
  PImage animal_not_talking = loadImage("data/peter_penguin.gif");
  PImage animal_sleeping = loadImage("data/peter_sleep_288.png");


  Frosty1(boolean isSleeping) {
    super(isSleeping);
  }
  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }

  //displays the correct animal 
  public void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, animalSleepingLeft, animalSleepingTop);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //displays the talking animal 
  public void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_PENGUIN_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  public void displayAnimalNotTalking() {
    image(GIFS_PENGUIN_TALKING[0], animalLeft, animalTop);
  }

  //determines if the cursor is over Peter Penguin
  public boolean cursorOverAnimal() { 
    if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
        && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else {
      return  ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

  //delegates what should happen if mouse pressed in Peter Penguin's habitat
  public void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
      println("got here homeslice3");
    }
  }  

  //play correct audio
  public void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    updateStateNumbers();
  }

  //updates state numbers after an animal has spoken
  public void updateStateNumbers() {
    if (USER == "GORILLA_A") {
    }//Peter Penguin is asleep
    else if (USER == "GORILLA_B") {
      println("got here dude");

      if (FROSTY1_STATE == 1) {
        println("got here dudette");

        FROSTY1_STATE ++;
        AFRICA2_STATE ++;
      }
      else if (FROSTY1_STATE == 3) {
        println("got here homeslice");
        FROSTY1_STATE ++;
        ASIA1_STATE ++;
        nav.clue3 = true; //muscles
      }
    }
    else if (USER == "COBRA_A") {
      if (FROSTY1_STATE == 0) {
        FROSTY1_STATE ++;
        AFRICA1_STATE ++;
      }
    }
    else if (USER == "POLAR_A") {
      if (FROSTY1_STATE == 1) {
        FROSTY1_STATE ++;
        ASIA2_STATE ++;
      }
      else if (FROSTY1_STATE == 3) {
        FROSTY1_STATE ++;
        ASIA2_STATE ++;
        nav.clue2 = true;
      }
    }
    else if (USER == "POLAR_B") {
      if (FROSTY1_STATE == 1) {
        FROSTY1_STATE++;
        FROSTY2_STATE ++;
        nav.clue3 = true;
      }
    }
  }

  //gets the current line the animal will be/is speaking
  public AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
    } //Peter Penguinn is asleep
    else if (USER == "GORILLA_B") {
      if (FROSTY1_STATE == 0) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 1) {
        return GB_PENGUIN1;
      }
      else if (FROSTY1_STATE == 2) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 3) {
        return GB_PENGUIN2;
      }
      else if (FROSTY1_STATE == 4) {
        return PENGUIN_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      if (FROSTY1_STATE == 0) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 1) {
        return PA_PENGUIN1;
      }
      else if (FROSTY1_STATE == 2) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 3) {
        return PA_PENGUIN2;
      }
      else if (FROSTY1_STATE == 4) {
        return PENGUIN_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      if (FROSTY1_STATE == 0) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 1) {
        return PB_PENGUIN1;
      }
      else if (FROSTY1_STATE == 2) {
        return PENGUIN_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      if (FROSTY1_STATE == 0) {
        return CA_PENGUIN1;
      }
      else if (FROSTY2_STATE == 1) {
        return PENGUIN_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      //Peter Penguin is asleep
    }
    return PENGUIN_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}

// Sam Seal (Conor doesn't know difference between seal and sea lion)
class Frosty2 extends Habitat {
  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 200;
  int animalTop = 220;
  int animalSleepingLeft = 200;
  int animalSleepingTop = 200;


  PImage background = loadImage("data/frosty_2.png");
  PImage animal_not_talking = loadImage("data/sam_sealion.gif");

  Frosty2(boolean isSleeping) {
    super(isSleeping);
  }
  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }

  //displays the correct animal 
  public void displayAnimal() {

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

  //displays the talking animal 
  public void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_SEAL_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  public void displayAnimalNotTalking() {
    image(GIFS_SEAL_TALKING[0], animalLeft, animalTop);
  }

  public boolean cursorOverAnimal() { 
    if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
        && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

  public void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (FROSTY2_STATE == 2) && USER == "COBRA_B") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }  

  //play correct audio
  public void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    updateStateNumbers();
  }

  public void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (FROSTY2_STATE == 1) {
        FROSTY2_STATE ++;
        AFRICA1_STATE ++;
      }
    }
    else if (USER == "GORILLA_B") {
      if (FROSTY2_STATE == 0) {
        FROSTY2_STATE ++;
        AFRICA1_STATE ++;
      }
    }
    else if (USER == "COBRA_A") {
    } //Sam Seal is asleep
    else if (USER == "COBRA_B") {
      FROSTY2_STATE ++; //the last person to talk to here
    }
    else if (USER == "POLAR_A") {
    }//Sam Seal is asleep
    else if (USER == "POLAR_B") {
      if (FROSTY2_STATE == 1) {
        FROSTY2_STATE ++;
        FROSTY1_STATE ++;
      }
      if (FROSTY2_STATE == 3) {
        FROSTY2_STATE ++;
        ASIA2_STATE ++;
        nav.clue4 = true;
      }
    }
  }

  //gets the current line the animal will be/is speaking
  public AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (FROSTY2_STATE == 0) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 1) {
        return GA_SEAL1;
      }
      else if (FROSTY2_STATE == 2) {
        return SEAL_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
      if (FROSTY2_STATE == 0) {
        return GB_SEAL1;
      }
      else if (FROSTY2_STATE == 1) {
        return SEAL_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      //Sam Seal is asleep
    }
    else if (USER == "POLAR_B") {
      if (FROSTY2_STATE == 0) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 1) {
        return PB_SEAL1;
      }
      else if (FROSTY2_STATE == 2) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 3) {
        return PB_SEAL2;
      }
      else if (FROSTY2_STATE == 4) {
        return SEAL_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      //Sam Seal is asleep
    }
    else if (USER == "COBRA_B") {
      if (FROSTY2_STATE == 0) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 1) {
        return CB_SEAL1;
      }
    }
    return SEAL_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}

// Intro class for when animal first coming out of box
// after user has hit the start button
class Intro {
  
  Intro() {}
  
  PImage img;
  public void display() {
    img = loadImage("data/box.png"); 
    image(img, 0, 0);
  }
  
  public boolean mousePressedAnimal() { // yea we know this isn't super legit
  return false;
  }
}

// Eliza Elephant
class Jungle1 extends Habitat {
  int frame;
  int numTalkingFrames = 16;

  int animalLeft = 500;
  int animalTop = 170;
  int animalSleepingLeft = 200;
  int animalSleepingTop = 200;


  PImage background = loadImage("data/jungle_1.png"); 
  PImage animal_not_talking = loadImage("data/eliza_elephant.gif");

  Jungle1(boolean isSleeping) {
    super(isSleeping);
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
  }

  //display the correct animal image
  public void displayAnimal() {
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
  public void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_ELEPHANT_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal 
  public void displayAnimalNotTalking() {
    image(GIFS_ELEPHANT_TALKING[0], animalLeft, animalTop);
  }

  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  public void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
      playCurrentTalk();
    }
  }

  //play correct audio
  public void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    updateStateNumbers();
  }

  //updates state numbers 
  public void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (JUNGLE1_STATE == 1) {
        nav.clue1 = true;// got fur clue
        JUNGLE1_STATE ++;
        ASIA2_STATE ++;
      }
    }

    else if (USER == "GORILLA_B") {
    } //ELiza Elephant is asleep
    else if (USER == "COBRA_A") {
      if (JUNGLE1_STATE == 1) {
        JUNGLE1_STATE ++;
        ASIA1_STATE ++;
        nav.clue4 = true;
      }
    }
    else if (USER == "COBRA_B") {
    } //Elize Elephant is asleep
    else if (USER == "POLAR_A") {
      if (JUNGLE1_STATE == 0) {
        JUNGLE1_STATE ++;
        AFRICA1_STATE ++;
      }
    }
    else if (USER == "POLAR_B") {
      if (JUNGLE1_STATE == 1) {
        JUNGLE1_STATE ++;
        FROSTY2_STATE ++;
        nav.clue2 = true; //fur
      }
    }
  }

  //determines if the mouse over the Camel
  public boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
        && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    }
  }

  //gets the current line the animal will be/is speaking
  public AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (JUNGLE1_STATE == 0) { 
        return ELEPHANT_DUMMY;
      }
      else if (JUNGLE1_STATE == 1) {

        println("got here");
        println("jungle state here" + JUNGLE1_STATE);
        return GA_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 2) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
    }//Eliza Elephant is sleeping
    else if (USER == "POLAR_A") {
      if (JUNGLE1_STATE == 0) {
        return PA_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 1) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      if (JUNGLE1_STATE == 0) {
        return ELEPHANT_DUMMY;
      }
      else if (JUNGLE1_STATE == 1) {
        return PB_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 2) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      if (JUNGLE1_STATE == 0) {
        return ELEPHANT_DUMMY;
      }
      else if (JUNGLE1_STATE == 1) {
        return CA_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 2) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      //Eliza Elephant is asleep
    }
    return ELEPHANT_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}

// Stanley Sloth
class Jungle2 extends Habitat {
  int frame;
  int numTalkingFrames = 10;

  int animalLeft = 400;
  int animalTop = 40;
  int animalSleepingLeft = 200;
  int animalSleepingTop = 200;


  PImage background = loadImage("data/jungle_2.png");
  PImage animal_not_talking = loadImage("data/stanley_sloth.gif");

  //did User pick up the trash
  boolean pickedUpTrash1;
  int trash1_x = 50;
  int trash1_y = 100;
  boolean pickedUpTrash2;
  int trash2_x = 150; 
  int trash2_y = 100;
  boolean pickedUpTrash3;
  int trash3_x = 250;
  int trash3_y = 100;

  Jungle2(boolean isSleeping) {
    super(isSleeping);
    if (isSleeping) {
      this.pickedUpTrash1 = true;
      this.pickedUpTrash2 = true;
      this.pickedUpTrash3 = true;
    }
    if (!isSleeping) {
      this.pickedUpTrash1 = false;
      this.pickedUpTrash2 = false;
      this.pickedUpTrash3 = false;
    }
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
    if (!isSleeping && USER == "COBRA_B") {
      image(TRASH_TEST, trash1_x, trash1_y);
    }
    else if (!isSleeping) {
      displayTrash();
    }
  }

  //displays the trash
  //assume: not sleeping
  public void displayTrash() {
    if (!pickedUpTrash1) {
      image(TRASH_TEST, trash1_x, trash1_y); //change
    }
    if (!pickedUpTrash2) {
      image(TRASH_TEST, trash2_x, trash2_y);
    }
    if (!pickedUpTrash3) {
      image(TRASH_TEST, trash3_x, trash3_y);
    }
  }

  //display the correct animal image
  public void displayAnimal() {
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
  public void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_SLOTH_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal 
  public void displayAnimalNotTalking() {
    image(GIFS_SLOTH_TALKING[0], animalLeft, animalTop);
  }

  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  public void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (JUNGLE2_STATE == 2) && USER == "GORILLA_B") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) { 
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
      playCurrentTalk();
    }
    else if (cursorOverTrash1() && (USER == "COBRA_B" || USER == "POLAR_A")) {
      pickedUpTrash1 = true;
      JUNGLE2_STATE ++; // so Stanley Sloth will say next line
    }
    else if (cursorOverTrash1()) {
      pickedUpTrash1 = true;
    }
    else if (cursorOverTrash2()) {
      pickedUpTrash2 = true;
    }
    else if (cursorOverTrash3()) {
      pickedUpTrash3 = true;
    }
  }

  //play correct audio
  public void playCurrentTalk() {
    println(JUNGLE2_STATE);
    if (!this.isSleeping) {
      currentTalk().trigger();
    }
    updateStateNumbers();
  }

  public void updateStateNumbers() {
    println("got to update statenumbers");
    println(USER == "GORILLA_B");
    if (USER == "GORILLA_A") {
      if (JUNGLE2_STATE == 1) {
        JUNGLE2_STATE ++;
        ASIA2_STATE ++; //Patty Panda
      } 
      if (JUNGLE2_STATE == 3) {
        JUNGLE2_STATE ++;
        AFRICA3_STATE ++;
        nav.clue4 = true; //fur is black
      }
    }
    else if (USER == "GORILLA_B") {
      println("got to gorilla_b");
      if (JUNGLE2_STATE == 1) {
        JUNGLE2_STATE ++;
      }
    }
    else if (USER == "COBRA_A") {
    }
    else if (USER == "COBRA_B") {
      if (JUNGLE2_STATE == 1) { //stay same until pick up rock
      }
      else if (JUNGLE2_STATE == 2) {
        JUNGLE2_STATE ++;
        ASIA2_STATE ++;
        nav.clue3 = true;
      }
    }
    else if (USER == "POLAR_A") {
      if (JUNGLE2_STATE == 1) {
      }
      if (JUNGLE2_STATE == 2) {
        JUNGLE2_STATE ++;
        AFRICA2_STATE ++;
      }
    }
    else if (USER == "POLAR_B") {
    }
  }


  //determines if cursor over any of the trash
  public boolean cursorOverTrash() {
    return !isSleeping && 
      ((!pickedUpTrash1 && cursorOverTrash1()) ||
      (!pickedUpTrash2 && cursorOverTrash2()) ||
      (!pickedUpTrash3 && cursorOverTrash3()));
  }

  //determines if mouse over trash1
  public boolean cursorOverTrash1() {
    return ((trash1_x < mouseX) && (mouseX < (trash1_x + 100))) 
      && ((trash1_y < mouseY) && (mouseY < (trash1_y + 100)));
  }
  //determines if mouse over trash2
  public boolean cursorOverTrash2() {
    return ((trash2_x < mouseX) && (mouseX < (trash2_x + 100))) 
      && ((trash2_y < mouseY) && (mouseY < (trash2_y + 100)));
  }
  //determines if mouse over trash3
  public boolean cursorOverTrash3() {
    return ((trash3_x < mouseX) && (mouseX < (trash3_x + 100))) 
      && ((trash3_y < mouseY) && (mouseY < (trash3_y + 100)));
  }

  //determines if the mouse over the Camel
  public boolean cursorOverAnimal() {
        if (isSleeping) {
      return ((animalSleepingLeft < mouseX) && (mouseX < (animalSleepingLeft + 200)))
        && ((animalSleepingTop < mouseY) && (mouseY < (animalSleepingTop + 200)));
    }
    else {
    return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
      && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    }
  }

  //gets the current line the animal will be/is speaking
  public AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return GA_SLOTH1;
      }
      else if (JUNGLE2_STATE == 2) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 3) {
        return GA_SLOTH2;
      }
      else if (JUNGLE2_STATE == 4) {
        return SLOTH_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return GB_SLOTH1;
      }
    }
    else if (USER == "POLAR_A") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return PA_SLOTH1;
      }
      else if (JUNGLE2_STATE == 2) {
        return PA_SLOTH2;
      }
      else if (JUNGLE2_STATE == 3) {
        return SLOTH_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      //Stanley Sloth is asleep
    }
    else if (USER == "COBRA_A") {
      //Stanley Sloth is asleep
    }
    else if (USER == "COBRA_B") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return CB_SLOTH1;
      }
      else if (JUNGLE2_STATE == 2) {
        return CB_SLOTH2;
      }
      else if (JUNGLE2_STATE == 3) {
        return SLOTH_DUMMY;
      }
    }
    return SLOTH_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}

// Map
class Map {
  PImage background;
  
  Map() {
    this.background = loadImage("data/map.png");
  }
  
  // display the scene
  public void display() {
    image(background, 0, 0);
  }
}
    
  
// Nav
class Nav {

  PImage navbar;

  boolean clue1; //GA fur //GB //CA/ //CB //PA //PB
  boolean clue2; 
  boolean clue3;
  boolean clue4;

  int clue1xi = 57;
  int clue2xi = 211;
  int clue3xi = 368;
  int clue4xi = 524;
  int clueyi = 570;

  Nav() {
    this.navbar = loadImage("data/nav.png");
  }

  // display the scene
  public void display() {
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

  public void displayClue1() {
    if (USER == "GORILLA_A") {
      image(GA_CLUE1, clue1xi, clueyi);
    }
    else {
      image(TEST_CLUE1, clue1xi, clueyi);
    }
  }

  public void displayClue2() {
    if (USER == "GORILLA_A") {
      image(GA_CLUE2, clue2xi, clueyi);
    }
    else {
      image(TEST_CLUE2, clue2xi, clueyi);
    }
  }


  public void displayClue3() {
    if (USER == "GORILLA_A") {
      image(GA_CLUE3, clue3xi, clueyi);
    }
    else {
      image(TEST_CLUE3, clue3xi, clueyi);
    }
  }

  public void displayClue4() {
    if (USER == "GORILLA_A") {
      image(GA_CLUE4, clue4xi, clueyi);
    }
    else {
      image(TEST_CLUE4, clue4xi, clueyi);
    }
  }
}

// class for last scene after you win
class Win {

  int correctXi = 497;
  int correctYi =268;

  PImage background;
  PImage img;

  Win() {
  }

  public void display() {
    background = loadImage("data/box.png"); //change, not right
    image(background, 0, 0);
  }

  public void doGuess() {
    ON_GUESS = true;
    image(GUESS_SCENE_BG, 0, 0);
  }

  public void doWin() {
    img = loadImage("data/youwin.png");
    image(img, 0, 0);
  }

  public boolean mousePressedAnimal() { // yea we know this isn't super legit
    return false;
  }

  public boolean cursorOverCorrect() {
    return ((correctXi < mouseX) && (mouseX < (correctXi + 200)))
      && ((correctYi < mouseY) && (mouseY < (correctYi + 200)));
  }

  public void mousePressedOnGuess() {
    if (cursorOverCorrect()) {
      doWin();
    }
  }
}


}
}

