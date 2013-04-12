// Nav
class Nav {
  
  PImage navbar;
  
  Nav() {
    this.navbar = loadImage("data/nav.png");
  }
  
  // display the scene
  void display() {
    img = this.navbar;
    image(img, 0, 0);
  }
}
    
