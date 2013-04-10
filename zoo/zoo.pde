PImage img;

void setup() {
  background(255);
  size(960,650);
  
  img = loadImage("data/frosty_1.png");
  image(img, 0, 0);
}
