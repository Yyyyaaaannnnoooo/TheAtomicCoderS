class Health {
  PImage[] emotions;
  float speed = 2, x, y;
  int life = 30;
  PVector pos, vel, acc, target;
  boolean showAnimation = true;
  Health(float x_, float y_) {
    x = x_;
    y = y_;
    //load the emtions
    String path = dataPath("") + "/emotions";
    String[] filenames = listFileNames(path);
    filenames = listFileNames(path);    
    emotions = new PImage[3];
    for (int i = 0; i < emotions.length; i++) {
      emotions[i] = loadIcon(path, filenames[i], color(0), color(255));
      emotions[i].resize(round(emotions[i].width * 0.75), 0);
    }
    pos = new PVector(x, y);
    target = new PVector(x, y - 300);
    vel = new PVector(0, 0);
  }

  void update() {
    PVector dir = PVector.sub(target, pos);
    dir.normalize();
    dir.mult(0.1);
    vel.add(dir);
    vel.limit(speed);
    pos.add(vel);
    life--;
    if (life <= 0) {
      pos = new PVector(x, y);
      showAnimation = false;
      life = 30;
    }
  }

  void show(int index) {
    if (showAnimation) {
      imageMode(CENTER);
      pushMatrix();
      translate(pos.x, pos.y);
      image(emotions[index], 0, 0);
      popMatrix();
    }
  }
}