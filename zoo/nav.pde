// Nav
class Nav {
  PImage background;
  
  Nav() {
    this.background = loadImage("data/nav.png");
  }
  
  // display the scene
  void display() {
    img = this.background;
    image(img, 0, 0);
  }
}
    
  
