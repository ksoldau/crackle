// Nav
class Nav {
  
  PImage navbar;
  
  Nav() {
    this.navbar = loadImage("data/nav.png");
  }
  
  // display the scene
  void display() {
    image(navbar, 0, 0);
  }
}
    
