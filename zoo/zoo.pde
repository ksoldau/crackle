import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import java.text.NumberFormat;
import processing.video.*;

import gifAnimation.*; //from http://www.extrapixel.ch/processing/gifAnimation/

//elements
PImage TRASH_IMAGE;
PImage ROCK_IMAGE;
PImage CHERRY_BLOSSOM;
PImage BAMBOO_IMAGE;
PImage FISH_IMAGE;
PImage VINES_IMAGE;
PImage VINES_CUT_IMAGE;
PImage SLOTH_TOKEN_IMAGE; 

//items user might collect
PImage CHERRY_BLOSSOM_CORNER;
PImage FISH_CORNER;
PImage BAMBOO_CORNER;
PImage SLOTH_TOKEN_CORNER;

//clues
PImage CLUE1;
PImage CLUE2;
PImage CLUE3;
PImage CLUE4;

//clue audio
AudioSample CLUE1_AUDIO;
AudioSample CLUE2_AUDIO;
AudioSample CLUE3_AUDIO;
AudioSample CLUE4_AUDIO;

//guess scene
PImage GUESS_SCENE_BG;

// declaring variables outside of so they can be used anywhere
// a la "public" in standard java
int ANIMAL_TALKING_START_TIME;
//
int CLUE_TALKING_START_TIME;

int OPENING_START_TIME;

int CURRENT_TIME;

PImage BACKGROUND_IMG;
Intro INTRO;
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
Habitat[] LIST_OF_HABITATS = new Habitat[9]; 



// Navigation,arrows, map, owl
Nav NAV;
Arrows ARROWS;
Map MAP;
Owl OWL;

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





//Audio for Guess screen
AudioSample TRY_AGAIN_AUDIO;


//------------------------------------------------
//Static variables

//width and height of scenes and total height
int WIDTH;
int HEIGHT;
int HABITAT_HEIGHT;

//coordinates for start button on welcome page
int STARTXi;
int STARTXf;
int STARTYi;
int STARTYf;

//coordinates for map button
int MAPXi;
int MAPXf;
int MAPYi;
int MAPYf;

//coordinates for help button
int HELPXi;
int HELPXf;
int HELPYi;
int HELPYf;

//coordinates for left arrow button
int LEFTXi;
int LEFTXf;
int LEFTYi;
int LEFTYf;

//coordinates for right arrow button
int RIGHTXi;
int RIGHTXf;
int RIGHTYi;
int RIGHTYf;

//--------------------------------------------
//Dynamic variables 

// if a certain screen is up
boolean WELCOME_SCREEN; // is it on the welcome screen
boolean ON_INTRO; // is it on the intro screen
boolean ON_MAP; 
boolean ON_GUESS;
boolean ON_WIN;

boolean HAS_ITEM;

//current habitat number
int HABITAT_NUMBER;

//current help owl
int HELP;
//list of Helps
PImage[] LIST_HELP_IMAGES = new PImage[13];
//is it on help
boolean ON_OWL;
//initialize lines //test for now
AudioSample TEST_OWL;
AudioSample[] LIST_OWL_AUDIO = new AudioSample[13];

//time owl started talking
int OWL_TALKING_START_TIME;

//last habitat number
int LAST_HABITAT_NUMBER;

//is the current animal talking
boolean ANIMAL_TALKING;
boolean CLUE_TALKING;

//did user make animal snore
boolean Z;

//the opening sequence
Movie OPENING_MOVIE;

//final movie scenes
Movie GORILLA_WIN_MOVIE;
Movie COBRA_WIN_MOVIE;
Movie POLAR_WIN_MOVIE;


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
int NUMZFRAMES;
int AUDIO_LENGTH;



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

  WIDTH = 960;
  HEIGHT = 650;
  HABITAT_HEIGHT = 540;
  size(WIDTH, HEIGHT);


  //width and height of scenes and total height

  //coordinates for start button on welcome page
  STARTXi = 400; //wrong
  STARTXf = 560; //wrong
  STARTYi = 500; //wrong
  STARTYf = 550; //wrong

  //coordinates for map button
  MAPXi = 780;
  MAPXf = 960;
  MAPYi = 550;
  MAPYf = 690;

  //coordinates for help button
  HELPXi = 680;
  HELPXf = 760;
  HELPYi = 550;
  HELPYf = 690;

  //coordinates for left arrow button
  LEFTXi = 24;
  LEFTXf = 127;
  LEFTYi = 226;
  LEFTYf = 301;

  //coordinates for right arrow button
  RIGHTXi = 834;
  RIGHTXf = 942;
  RIGHTYi = 226;
  RIGHTYf = 301;

  //--------------------------------------------
  //Dynamic variables 

  // if a certain screen is up
  WELCOME_SCREEN = true; // is it on the welcome screen
  ON_INTRO = false; // is it on the intro screen
  ON_MAP = false; 
  ON_GUESS = false;
  ON_WIN = false;

  HAS_ITEM = false;

  //is it on help
  ON_OWL = false;

  //last habitat number
  LAST_HABITAT_NUMBER = 8;

  //is the current animal talking
  ANIMAL_TALKING = false;
  CLUE_TALKING = false;

  //did user make animal snore
  Z = false;

  NUMZFRAMES = 13;

  //elements for scenes
  TRASH_IMAGE= loadImage("data/elements/trash.png");
  ROCK_IMAGE = loadImage("data/elements/rock.png");
  CHERRY_BLOSSOM = loadImage("data/elements/cherryblossom.png");
  FISH_IMAGE = loadImage("data/elements/fish.png");
  BAMBOO_IMAGE = loadImage("data/elements/bamboo.png");
  VINES_IMAGE = loadImage("data/elements/vineswhole.png");  
  VINES_CUT_IMAGE = loadImage("data/elements/vinescut.png"); 
  SLOTH_TOKEN_IMAGE = loadImage("data/elements/slothtoken.png");

  CHERRY_BLOSSOM_CORNER = loadImage("data/elements/cherryblossomcorner.png");
  FISH_CORNER = loadImage("data/elements/fishcorner.png");
  BAMBOO_CORNER = loadImage("data/elements/bamboocorner.png");
  SLOTH_TOKEN_CORNER = loadImage("data/elements/slothtokencorner.png");


  // load image that says "Zoo guess who click here to start"
  BACKGROUND_IMG = loadImage("data/welcome.png");
  image(BACKGROUND_IMG, 0, 0);

  //helpowls
  LIST_HELP_IMAGES[0] = loadImage("data/oscar/help_calvin_288.png"); 
  LIST_HELP_IMAGES[1] =loadImage("data/oscar/help_gerry_288.png"); 
  LIST_HELP_IMAGES[2] =loadImage("data/oscar/help_leonard_288.png");
  LIST_HELP_IMAGES[3] =loadImage("data/oscar/help_tina_288.png");
  LIST_HELP_IMAGES[4] =loadImage("data/oscar/help_patty_288.png");
  LIST_HELP_IMAGES[5] =loadImage("data/oscar/help_peter_288.png");
  LIST_HELP_IMAGES[6] =loadImage("data/oscar/help_sam_288.png");
  LIST_HELP_IMAGES[7] =loadImage("data/oscar/help_eliza_288.png");
  LIST_HELP_IMAGES[8] =loadImage("data/oscar/help_stanley_288.png");



  //intro 
  INTRO = new Intro();
  OPENING_MOVIE = new Movie(this, "opening.mov");
  
  //final winning movies
  GORILLA_WIN_MOVIE = new Movie(this, "jungle.mov");
  COBRA_WIN_MOVIE = new Movie(this, "africa.mov");
  POLAR_WIN_MOVIE = new Movie(this, "polar.mov");
  

  // randomly chooses which animal and which 
  // iteration of that animal the user will play
  chooseUser();
  println("YOU ARE THIS USER" + USER);
  //USER = "COBRA_B";

  //chooses correct habitat number to start on based on user animal
  setFirstHabitatNumber();
  //set the first help numner 
  setFirstHelp();

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
  NAV = new Nav();

  //initialize the class for the arrows
  ARROWS = new Arrows();

  //initialize the class for the map
  MAP = new Map();

  //initialize the win class
  WIN = new Win();

  //initialize the Owl class
  OWL = new Owl();

  // Setting up sound engine
  minim = new Minim(this);

  //AFRICA_BG = minim.loadFile("africa_bg.mp3", 512);
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
  initializeHelpAudioAndImages();
  initializeClueAudio();
  TRY_AGAIN_AUDIO = minim.loadSample("try_again.mp3", 512);
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
    LAST_HABITAT_NUMBER = 0;
  }
  else if (USER == "POLAR_B") {
    HABITAT_NUMBER = 3;
  }
}

//set first help number 
void setFirstHelp() {
  HELP = HABITAT_NUMBER;
}

//initialize the audio
void initializeAudio() {
  //Audio for just GORILLA_A
  if (USER == "GORILLA_A") {
    CAMEL_DUMMY = minim.loadSample("CAMEL_DUMMY.mp3", 512); 
    ELEPHANT_DUMMY = minim.loadSample("ELEPHANT_DUMMY.mp3", 512);
    PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
    SLOTH_DUMMY = minim.loadSample("SLOTH_DUMMY.mp3", 512);
    SEAL_DUMMY = minim.loadSample("SEAL_DUMMY.mp3", 512);
    LION_DUMMY = minim.loadSample("LION_DUMMY.mp3", 512);

    GA_CAMEL1 = minim.loadSample("GA_CAMEL1.mp3", 512); //***
    GA_ELEPHANT1 = minim.loadSample("GA_ELEPHANT1.mp3", 512); 
    GA_PANDA1 = minim.loadSample("GA_PANDA1.mp3", 512);
    GA_SLOTH1 = minim.loadSample("GA_SLOTH1.mp3", 512);
    GA_PANDA2 = minim.loadSample("GA_PANDA2.mp3", 512);
    GA_SEAL1 = minim.loadSample("GA_SEAL1.mp3", 512);
    GA_CAMEL2 = minim.loadSample("GA_CAMEL2.mp3", 512);
    GA_LION1 = minim.loadSample("GA_LION1.mp3", 512);
    GA_SLOTH2 = minim.loadSample("GA_SLOTH2.mp3", 512);
    GA_LION2 = minim.loadSample("GA_LION2.mp3", 512);
  }


  else if (USER == "GORILLA_B") {
    //Dummy lines
    CAMEL_DUMMY = minim.loadSample("CAMEL_DUMMY.mp3", 512);
    GIRAFFE_DUMMY = minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    TIGER_DUMMY = minim.loadSample("TIGER_DUMMY.mp3", 512);
    PENGUIN_DUMMY = minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    SEAL_DUMMY = minim.loadSample("SEAL_DUMMY.mp3", 512);
    SLOTH_DUMMY = minim.loadSample("SLOTH_DUMMY.mp3", 512);

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
    //Dummy lines
    CAMEL_DUMMY = minim.loadSample("CAMEL_DUMMY.mp3", 512);
    LION_DUMMY = minim.loadSample("LION_DUMMY.mp3", 512);
    TIGER_DUMMY = minim.loadSample("TIGER_DUMMY.mp3", 512);
    PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
    PENGUIN_DUMMY = minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    ELEPHANT_DUMMY = minim.loadSample("ELEPHANT_DUMMY.mp3", 512);

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
    //Dummy lines
    GIRAFFE_DUMMY = minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    LION_DUMMY = minim.loadSample("LION_DUMMY.mp3", 512);
    TIGER_DUMMY = minim.loadSample("TIGER_DUMMY.mp3", 512);
    PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
    SEAL_DUMMY = minim.loadSample("SEAL_DUMMY.mp3", 512);
    SLOTH_DUMMY = minim.loadSample("SLOTH_DUMMY.mp3", 512);

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
    //Dummy lines
    CAMEL_DUMMY = minim.loadSample("CAMEL_DUMMY.mp3", 512);
    GIRAFFE_DUMMY = minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
    PENGUIN_DUMMY = minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    ELEPHANT_DUMMY = minim.loadSample("ELEPHANT_DUMMY.mp3", 512);
    SLOTH_DUMMY = minim.loadSample("SLOTH_DUMMY.mp3", 512);

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
    //Dummy lines
    GIRAFFE_DUMMY = minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    TIGER_DUMMY = minim.loadSample("TIGER_DUMMY.mp3", 512);
    PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
    PENGUIN_DUMMY = minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    SEAL_DUMMY = minim.loadSample("SEAL_DUMMY.mp3", 512);
    ELEPHANT_DUMMY = minim.loadSample("ELEPHANT_DUMMY.mp3", 512);

    PB_TIGER1 = minim.loadSample("PB_TIGER1.mp3", 512);
    PB_GIRAFFE1 = minim.loadSample("PB_GIRAFFE1.mp3", 512);
    PB_ELEPHANT1 = minim.loadSample("PB_ELEPHANT1.mp3", 512);
    PB_SEAL1 = minim.loadSample("PB_SEAL1.mp3", 512);
    PB_SEAL2 = minim.loadSample("PB_SEAL2.mp3", 512);
    PB_PENGUIN1 = minim.loadSample("PB_PENGUIN1.mp3", 512);
    PB_PANDA1 = minim.loadSample("PB_PANDA1.mp3", 512);
  }
}

void initializeHelpAudioAndImages() {
  if (USER == "GORILLA_A") {
    LIST_OWL_AUDIO[0] =  minim.loadSample("oscar/help_camel_0.mp3", 512);  //("oscar/owl_help_0.mp3", 512);
    LIST_OWL_AUDIO[2] =  minim.loadSample("oscar/help_lion_2.mp3", 512);  //("oscar/owl_help_2.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("oscar/help_tiger_3.mp3", 512);  //("oscar/owl_help_3.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("oscar/help_panda_4.mp3", 512); //("oscar/owl_help_4.mp3", 512);
    LIST_OWL_AUDIO[6] =  minim.loadSample("oscar/help_seal_6.mp3", 512); //("oscar/owl_help_6.mp3", 512);
    LIST_OWL_AUDIO[7] =  minim.loadSample("oscar/help_elephant_7.mp3", 512); //("oscar/owl_help_7.mp3", 512);
    LIST_OWL_AUDIO[8] =  minim.loadSample("oscar/help_sloth_8.mp3", 512); //("oscar/owl_help_8.mp3", 512);

    LIST_OWL_AUDIO[9] = minim.loadSample("owl_help_9_ga_trash.mp3", 512);
    LIST_HELP_IMAGES[9] = loadImage("data/oscar/help_stanley_288.png");
  }
  else if (USER == "GORILLA_B") {
    LIST_OWL_AUDIO[0] =  minim.loadSample("oscar/help_camel_0.mp3", 512);
    LIST_OWL_AUDIO[1] =  minim.loadSample("oscar/help_giraffe_1.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("oscar/help_tiger_3.mp3", 512);
    LIST_OWL_AUDIO[5] =  minim.loadSample("oscar/help_penguin_5.mp3", 512);
    LIST_OWL_AUDIO[6] =  minim.loadSample("oscar/help_seal_6.mp3", 512);
    LIST_OWL_AUDIO[8] =  minim.loadSample("oscar/help_sloth_8.mp3", 512);
  }
  else if (USER == "COBRA_A") {
    LIST_OWL_AUDIO[0] =  minim.loadSample("oscar/help_camel_0.mp3", 512);
    LIST_OWL_AUDIO[2] =  minim.loadSample("oscar/help_lion_2.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("oscar/help_tiger_3.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("oscar/help_panda_4.mp3", 512);
    LIST_OWL_AUDIO[5] =  minim.loadSample("oscar/help_penguin_5.mp3", 512);
    LIST_OWL_AUDIO[7] =  minim.loadSample("oscar/help_elephant_7.mp3", 512);
  }
  else if (USER == "COBRA_B") {
    LIST_OWL_AUDIO[1] =  minim.loadSample("oscar/help_giraffe_1.mp3", 512);
    LIST_OWL_AUDIO[2] =  minim.loadSample("oscar/help_lion_2.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("oscar/help_tiger_3.mp3", 512);
    LIST_OWL_AUDIO[8] =  minim.loadSample("oscar/help_sloth_8.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("oscar/help_panda_4.mp3", 512);
    LIST_OWL_AUDIO[6] =  minim.loadSample("oscar/help_seal_6.mp3", 512);

    LIST_OWL_AUDIO[10] = minim.loadSample("owl_help_10_cb_rock.mp3", 512);
    LIST_HELP_IMAGES[10] = loadImage("data/oscar/help_stanley_288.png");
  }
  else if (USER == "POLAR_A") {
    LIST_OWL_AUDIO[0] =  minim.loadSample("oscar/help_camel_0.mp3", 512);
    LIST_OWL_AUDIO[1] =  minim.loadSample("oscar/help_giraffe_1.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("oscar/help_panda_4.mp3", 512);
    LIST_OWL_AUDIO[5] =  minim.loadSample("oscar/help_penguin_5.mp3", 512);
    LIST_OWL_AUDIO[7] =  minim.loadSample("oscar/help_elephant_7.mp3", 512);
    LIST_OWL_AUDIO[8] =  minim.loadSample("oscar/help_sloth_8.mp3", 512);

    LIST_OWL_AUDIO[11] = minim.loadSample("owl_help_11_pa_fish.mp3", 512);
    LIST_OWL_AUDIO[12] = minim.loadSample("owl_help_12_pa_vines.mp3", 512);
    LIST_HELP_IMAGES[11] = loadImage("data/oscar/help_patty_288.png");
    LIST_HELP_IMAGES[12] = loadImage("data/oscar/help_stanley_288.png");
  }
  else if (USER == "POLAR_B") {
    LIST_OWL_AUDIO[1] =  minim.loadSample("oscar/help_giraffe_1.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("oscar/help_tiger_3.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("oscar/help_panda_4.mp3", 512);
    LIST_OWL_AUDIO[7] =  minim.loadSample("oscar/help_elephant_7.mp3", 512);
    LIST_OWL_AUDIO[6] =  minim.loadSample("oscar/help_seal_6.mp3", 512);
    LIST_OWL_AUDIO[5] =  minim.loadSample("oscar/help_penguin_5.mp3", 512);
  }
  else {

    LIST_OWL_AUDIO[0] =  minim.loadSample("oscar/help_camel_0.mp3", 512);
    LIST_OWL_AUDIO[1] =  minim.loadSample("oscar/help_giraffe_1.mp3", 512);
    LIST_OWL_AUDIO[2] =  minim.loadSample("oscar/help_lion_2.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("oscar/help_tiger_3.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("oscar/help_panda_4.mp3", 512);
    LIST_OWL_AUDIO[5] =  minim.loadSample("oscar/help_penguin_5.mp3", 512);
    LIST_OWL_AUDIO[6] =  minim.loadSample("oscar/help_seal_6.mp3", 512);
    LIST_OWL_AUDIO[7] =  minim.loadSample("oscar/help_elephant_7.mp3", 512);
    LIST_OWL_AUDIO[8] =  minim.loadSample("oscar/help_sloth_8.mp3", 512);

    /*LIST_OWL_AUDIO[0] =  minim.loadSample("owl_help_0.mp3", 512);
     LIST_OWL_AUDIO[1] =  minim.loadSample("owl_help_1.mp3", 512);
     LIST_OWL_AUDIO[2] =  minim.loadSample("owl_help_2.mp3", 512);
     LIST_OWL_AUDIO[3] =  minim.loadSample("owl_help_3.mp3", 512);
     LIST_OWL_AUDIO[4] =  minim.loadSample("owl_help_4.mp3", 512);
     LIST_OWL_AUDIO[5] =  minim.loadSample("owl_help_5.mp3", 512);
     LIST_OWL_AUDIO[6] =  minim.loadSample("owl_help_6.mp3", 512);
     LIST_OWL_AUDIO[7] =  minim.loadSample("owl_help_7.mp3", 512);
     LIST_OWL_AUDIO[8] =  minim.loadSample("owl_help_8.mp3", 512); */
  }
}

void initializeClueAudio() {
  if (USER == "GORILLA_A") {
    CLUE1_AUDIO = minim.loadSample("GA_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("GA_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("GA_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("GA_CLUE4.mp3", 512);
  }
  else if (USER == "GORILLA_B") {
    CLUE1_AUDIO = minim.loadSample("GB_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("GB_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("GB_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("GB_CLUE4.mp3", 512);
  }
  else if (USER == "COBRA_A") {
    CLUE1_AUDIO = minim.loadSample("CA_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("CA_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("CA_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("CA_CLUE4.mp3", 512);
  }
  else if (USER == "COBRA_B") {
    CLUE1_AUDIO = minim.loadSample("CB_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("CB_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("CB_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("CB_CLUE4.mp3", 512);
  }
  else if (USER == "POLAR_A") {
    CLUE1_AUDIO = minim.loadSample("PA_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("PA_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("PA_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("PA_CLUE4.mp3", 512);
  }
  else if (USER == "POLAR_B") {
    CLUE1_AUDIO = minim.loadSample("PB_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("PB_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("PB_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("PB_CLUE4.mp3", 512);
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
    CLUE1 = loadImage("data/clues/clue_fur.png");
    CLUE2 = loadImage("data/clues/clue_plants.png");
    CLUE3 = loadImage("data/clues/clue_2legs.png");
    CLUE4 = loadImage("data/clues/clue_black.png");
  }
  else if (USER == "GORILLA_B") {
    CLUE1 = loadImage("data/clues/clue_plants.png");
    CLUE2 = loadImage("data/clues/clue_climbstrees.png");
    CLUE3 = loadImage("data/clues/clue_muscular.png");
    CLUE4 = loadImage("data/clues/clue_black.png");
  }
  else if (USER == "COBRA_A") {
    CLUE1 = loadImage("data/clues/clue_sharpteeth.png");
    CLUE2 = loadImage("data/clues/clue_scales.png");
    CLUE3 = loadImage("data/clues/clue_poisonous.png");
    CLUE4 = loadImage("data/clues/clue_longtongue.png");
  }
  else if (USER == "COBRA_B") {  
    CLUE1 = loadImage("data/clues/clue_sharpteeth.png");
    CLUE2 = loadImage("data/clues/clue_scales.png");
    CLUE3 = loadImage("data/clues/clue_eggs.png");
    CLUE4 = loadImage("data/clues/clue_eatsmice.png");
  }
  else if (USER == "POLAR_A") {  
    CLUE1 = loadImage("data/clues/clue_white.png");
    CLUE2 = loadImage("data/clues/clue_4paws.png");
    CLUE3 = loadImage("data/clues/clue_blacknose.png");
    CLUE4 = loadImage("data/clues/clue_sharpteeth.png");
  }
  else if (USER == "POLAR_B") {
    CLUE1 = loadImage("data/clues/clue_4paws.png");
    CLUE2 = loadImage("data/clues/clue_fur.png");
    CLUE3 = loadImage("data/clues/clue_fish.png");
    CLUE4 = loadImage("data/clues/clue_claws.png");
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

  CURRENT_TIME = millis();

  frameRate(12);
  drawCursor();

  if (ON_INTRO) {
    frameRate(30); //29.97 maybe but not dealing with that
    image(OPENING_MOVIE, 0, 0, 960, 540);
    if (OPENING_MOVIE.time() >= 10) {
      ON_INTRO = false;
    }
  }
  
  if (ON_WIN) {
    frameRate(30);
    if (USER == "GORILLA_A" || USER == "GORILLA_B") {
      image(GORILLA_WIN_MOVIE, 0, 0, 960, 540);
    }
    else if (USER == "COBRA_A" || USER == "COBRA_B") {
      image(COBRA_WIN_MOVIE, 0, 0, 960, 540);
    }
    else if (USER == "POLAR_A" || USER == "POLAR_B") {
      image(POLAR_WIN_MOVIE, 0, 0, 960, 540);
    }
  } 

  else if (CLUE_TALKING && 
    (CURRENT_TIME - CLUE_TALKING_START_TIME >= AUDIO_LENGTH)) {
    CLUE_TALKING = false;
  }

  //automatically shows the guessing screen if need be
  else if (shouldShowGuess()) {
    WIN.doGuess();
  }

  else if (LAST_HABITAT_NUMBER != HABITAT_NUMBER) {
    Z = false;//cancel the Zs
  }

  //to stop the animal from visibly speaking if audio over
  else if (ANIMAL_TALKING && 
    (CURRENT_TIME - ANIMAL_TALKING_START_TIME >= AUDIO_LENGTH)) {
    ANIMAL_TALKING = false;
    doScene(HABITAT_NUMBER);
  }

  //to display the correct animal for current habitat
  else if (ON_GUESS) {
    pauseAll();
  }

  //makes owl stay up as long as audio plays
  else if (ON_OWL) {
    if  (CURRENT_TIME - OWL_TALKING_START_TIME >= LIST_OWL_AUDIO[HELP].length()) {
      ON_OWL = false;
    }
    else {
      doOwl();
    }
  }

  else if (ON_MAP) {
    doMap();
  }


  else if (!ON_MAP && !WELCOME_SCREEN && !ON_INTRO && !ON_GUESS) { 
    doScene(HABITAT_NUMBER);
    //LIST_OF_HABITATS[HABITAT_NUMBER].displayAnimal(); //HERE IS WHERE ANIMALS ARE DISPLAYED
    //println(Z);
    if (Z) {
      LIST_OF_HABITATS[HABITAT_NUMBER].displayZs();
      println(Z);
    }
  }
  //printMem(); //DEBUG: To monitor memory usage

  //plays correct background music
  if (!WELCOME_SCREEN && !ON_INTRO && !ON_GUESS &&!ON_WIN) {
    whenPlay();
  }
}


// SOUNDS

void playBg() {  
  if (HABITAT_NUMBER == 0 || HABITAT_NUMBER == 1 || HABITAT_NUMBER == 2) {
    pauseAll();
    FROSTY_BG.loop(); //changed because of audio limit, both are wind sounds
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

//determines if this is the point where the guess screen should automatically pop up 
boolean shouldShowGuess() {
  if (! (!ANIMAL_TALKING && CURRENT_TIME - ANIMAL_TALKING_START_TIME >= AUDIO_LENGTH + 500)) {
    return false;
  }
  if (USER == "GORILLA_A" && AFRICA3_STATE == 4) { 
    return true;
  }
  else if (USER == "GORILLA_B" && JUNGLE2_STATE == 2) {
    return true;
  }
  else if (USER == "COBRA_A" && ASIA1_STATE == 2) {
    return true;
  }
  else if (USER == "COBRA_B" && FROSTY2_STATE == 3) { 
    return true;
  }
  else if (USER == "POLAR_A" && AFRICA2_STATE == 2) {
    return true;
  }
  else if (USER == "POLAR_B" && ASIA2_STATE == 2) {
    return true;
  }
  else {
    return false;
  }
}

void pauseAll() {
  //AFRICA_BG.pause();
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

    if (cursorOver(STARTXi, STARTXf, STARTYi, STARTYf)) {
      cursor(HAND);
    }
    else {
      cursor(ARROW);
    }
  } 
  
  else if (ON_GUESS) {
    if (WIN.cursorOverGuessOption()) {
      cursor(HAND);
    }
    if (NAV.cursorOverClue()) {
      cursor(HAND);
    }
    else {
      cursor(ARROW);
    }
  }

  else if (ANIMAL_TALKING || ON_OWL || ON_INTRO || CLUE_TALKING) {
    if (ON_GUESS && WIN.cursorOverGuessOption())
    {
      cursor(HAND);
    } 
    else {
      cursor(ARROW);
    }
  }

  else if 
    (cursorOverMapButton() || 
    cursorOverHelp() || 
    cursor_over_left() ||
    cursor_over_right() ||
    (!LIST_OF_HABITATS[HABITAT_NUMBER].isSleeping &&
    LIST_OF_HABITATS[HABITAT_NUMBER].cursorOverAnimal()) ||
    (ON_MAP && (
  cursorOverAfrica1() ||
    cursorOverAfrica2() ||
    cursorOverAfrica3() ||
    cursorOverAsia1() ||
    cursorOverAsia2() ||
    cursorOverFrosty1() ||
    cursorOverFrosty2() ||
    cursorOverJungle1() ||
    cursorOverJungle2() ))) 
  {
    cursor(HAND);
  }
  else if (LIST_OF_HABITATS[HABITAT_NUMBER].cursorOverElement()) {
    cursor(HAND);
  }
  else if (NAV.cursorOverClue()) {
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
  NAV.display();
  INTRO.display();
  ON_INTRO = true;
}

// map screen
void doMap() {
  MAP.display();
  ON_MAP = true;
}

//help Oscar Owl
void doOwl() {
  OWL.displayOwl();
  ON_OWL = true;
}

//---------------------
// all of the do methods display the habitat for each 
// specified habitat
// arrows are displayed because the backgrounds will hide them.

void doAfrica1() {
  AFRICA1.display();
  ARROWS.display();
  NAV.display();
}
void doAfrica2() {
  AFRICA2.display();
  ARROWS.display();
  NAV.display();
}

void doAfrica3() {
  AFRICA3.display();
  ARROWS.display();
  NAV.display();
}

void doAsia1() {
  ASIA1.display();
  ARROWS.display();
  NAV.display();
}

void doAsia2() {
  ASIA2.display();
  ARROWS.display();
  NAV.display();
}

void doFrosty1() {
  FROSTY1.display();
  ARROWS.display();
  NAV.display();
}

void doFrosty2() {
  FROSTY2.display();
  ARROWS.display();
  NAV.display();
}

void doJungle1() {
  JUNGLE1.display();
  ARROWS.display();
  NAV.display();
}

void doJungle2() {
  JUNGLE2.display();
  ARROWS.display();
  NAV.display();
}

//------------------------------------
//actions to take if mouse is pressed

// assume: on welcome screen
// determines what actions to perform if mouse pressed 
void mousePressedWelcomeScreen() {
  if (cursor_over_start() && mousePressed == true) {
    doIntro();
    WELCOME_SCREEN = false;
    OPENING_START_TIME = millis();
  }
}

// if mouse is pressed, do this stuff 
void mousePressed() {
  if (ON_WIN) 
  { }
  //if welcome screen is up 
  else if (WELCOME_SCREEN) { 
    mousePressedWelcomeScreen();
  }
  else if (ON_INTRO) {
  }
  //if an animal is talking
  else if (ANIMAL_TALKING || ON_OWL || CLUE_TALKING) {
  } //stops user from clicking on things while animal talking

  else if (!WELCOME_SCREEN && !ON_INTRO && NAV.cursorOverClue()) {
    NAV.mousePressedOnClue();
  }

  //if map is up
  else if (ON_MAP) {
    mousePressedOnMap();
  }

  else if (ON_GUESS) {
    WIN.mousePressedOnGuess();
  }

  //if over map 
  else if (cursorOverMapButton()) {
    doMap();
    ON_MAP = true;
  }

  //if over help
  else if (cursorOverHelp()) {
    OWL.talkOwl();
    ON_OWL = true;
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
  if (cursorOverMapButton()) {
    ON_MAP = false;
  }
  else if (cursorOverHelp()) {
    OWL.talkOwl();
    ON_OWL = true;
  }
  else if (cursorOverAfrica1()) {
    doAfrica1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 0;
    ON_MAP = false;
  }
  else if (cursorOverAfrica2()) {
    doAfrica2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 1;
    ON_MAP = false;
  }
  else if (cursorOverAfrica3()) {
    doAfrica3();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 2;
    ON_MAP = false;
  }
  else if (cursorOverAsia1()) {
    doAsia1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 3;
    ON_MAP = false;
  }
  else if (cursorOverAsia2()) {
    doAsia2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 4;
    ON_MAP = false;
  }
  else if (cursorOverFrosty1()) {
    doFrosty1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 5;
    ON_MAP = false;
  }
  else if (cursorOverFrosty2()) {
    doFrosty2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 6;
    ON_MAP = false;
  }
  else if (cursorOverJungle1()) {
    doJungle1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 7;
    ON_MAP = false;
  }
  else if (cursorOverJungle2()) {
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
boolean cursorOver(int xmin, int xmax, int ymin, int ymax) {
  return xmin < mouseX && mouseX < xmax && ymin < mouseY && mouseY < ymax;
}

// determines if cursor over the start button 
// assume: on welcome page
boolean cursor_over_start() {
  return cursorOver(STARTXi, STARTXf, STARTYi, STARTYf);
}


//assume: not on welcome screen, not on map
// determines if mouse pressed in a habitat
boolean cursorOverHabitat() {
  return cursorOver(0, 960, 0, 540);
}

// determines if cursor over map 
boolean cursorOverMapButton() {
  return cursorOver(MAPXi, MAPXf, MAPYi, MAPYf);
}
boolean cursorOverHelp() {
  return cursorOver(HELPXi, HELPXf, HELPYi, HELPYf);
}
boolean cursor_over_left() {
  return cursorOver(LEFTXi, LEFTXf, LEFTYi, LEFTYf);
}
boolean cursor_over_right() {
  return cursorOver(RIGHTXi, RIGHTXf, RIGHTYi, RIGHTYf);
}

// assuming in the map
boolean cursorOverAfrica1() {
  return cursorOver(473, 562, 96, 160);
}
boolean cursorOverAfrica2() {
  return cursorOver(564, 654, 171, 237);
}
boolean cursorOverAfrica3() {
  return cursorOver(581, 670, 270, 336);
}
boolean cursorOverAsia1() {
  return cursorOver(527, 616, 370, 435);
}
boolean cursorOverAsia2() {
  return cursorOver(423, 513, 409, 474);
}
boolean cursorOverFrosty1() {
  return cursorOver(318, 407, 369, 433);
}
boolean cursorOverFrosty2() {
  return cursorOver(267, 356, 272, 336);
}
boolean cursorOverJungle1() {
  return cursorOver(283, 372, 171, 235);
}
boolean cursorOverJungle2() {
  return cursorOver(373, 461, 95, 159);
}


//method for opening intro
void movieEvent(Movie m) {
  if (m == OPENING_MOVIE) {
    OPENING_MOVIE.read();
  }
  else if (m == GORILLA_WIN_MOVIE) {
    GORILLA_WIN_MOVIE.read();
  }
  else if (m == POLAR_WIN_MOVIE) {
    POLAR_WIN_MOVIE.read();
  }
  else if (m == COBRA_WIN_MOVIE) {
    COBRA_WIN_MOVIE.read();
  }
}

