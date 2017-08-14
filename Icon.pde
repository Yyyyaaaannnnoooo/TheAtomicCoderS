class Icon {
  Health h;
  PImage[] dancingGuy = new PImage[2];
  boolean dead = false, hitted = false, updateHealth = false;
  PImage icon;
  int hitCounter = 0, step = 0, health = 3, prevHealth = health;
  private int deadCounter = 60;
  PVector pos;
  Icon(float posX, float posY) {
    h = new Health(posX, posY);
    //load icons
    String pathIcon = dataPath("") + "/icons";
    String[] filenames = listFileNames(pathIcon);
    icon = loadIcon(pathIcon, filenames[floor(random(1, filenames.length))], color(255), color(0, 0));
    pos = new PVector(posX, posY);
  }
  void update() {
    //make the icon disappear
    if (health < 1)deadCounter--;
    if (deadCounter < 0)dead = true;
    //reset the health animation
    if (prevHealth != health) {
      h.showAnimation = true;
      prevHealth = health;
    }
  }
  void show() {
    imageMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255);
    image(icon, 0, 0);    
    popMatrix();
    if (health == 2) {  
      h.update();
      h.show(0);
    }
    if (health == 1) {
      h.update();
      h.show(1);
    }
    if (health < 1) {
      h.update();
      h.show(2);
    }
  }
}