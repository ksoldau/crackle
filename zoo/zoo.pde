PImage img;
Intro intro;
Jungle1 jungle;

int WIDTH = 960;
int HEIGHT = 650;

//setup runs once
void setup() {
  background(255);
  size(WIDTH,HEIGHT);
  
  // load image that says "Zoo guess who click here to start"
  img = loadImage("data/frosty_1.png");
  image(img, 0, 0);
  
  intro = new Intro();
  jungle = new Jungle1(2, false);
}

// draw is called directly after setup
// called automatically, don't mess with it
void draw() {
}

void doIntro() {
  intro.display();
}

void doJungle() {
  jungle.display();
}

void keyPressed() {
  if (key==ENTER) {
    //doIntro();
  }
}

void mousePressed() {
if (mouseX < 20 && mouseY > 0 && mousePressed == true) {
  doIntro();}
  else if (mouseX > 500 && mouseY > 0 && mousePressed == true) {
   doJungle();
  }
}

  
  



