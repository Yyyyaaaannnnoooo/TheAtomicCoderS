class Paddle {
  float w = 100;
  int h = 40;
  int d = 20;
  float x = 520, y = 0;
  int yUpdate = 0;
  int theCanvasWidth;
  Paddle(int posY, int canvasWidth) {
    rectMode(CENTER);
    y = posY;
    theCanvasWidth = canvasWidth;
  }
  void update() {
    x += yUpdate;
    x = constrain(x, 0, theCanvasWidth);
    if (w <= 20)w = 20;
  }
  void move(int inc) {
    yUpdate = inc;
    
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