class Paddle {
  float w = 100;
  int h = 40;
  int d = 20;
  float x = 520, y = 0;
  Paddle(int posY) {
    rectMode(CENTER);
    y = posY;
  }
  void update(float pos) {
    x = pos;
    if (w <= 20)w = 20;
  }
  void show() {
    fill(255);
    strokeWeight(3);
    stroke(0);
    pushMatrix();
    translate(x, y, h / 2);
    rotateX(HALF_PI);
    fill(255);
    box(w, h, d);
    popMatrix();
  }
}