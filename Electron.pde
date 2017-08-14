//this class defines the electrons rotating around the atom
class Electron {
  float w, h, rotY, rotZ, incZ, incY, count;
  PVector pos;
  PVector electron;
  PVector[] trail = new PVector[50];  
  Electron(float rotationY, float rotationZ, float x, float y, float z, float w_, float h_) {
    w = w_;
    h = h_;
    rotY = rotationY;
    rotZ = rotationZ;
    pos = new PVector(x, y, z);
    incZ = random(0.03, 0.001);
    incY = random(0.03, 0.001);
  }
  void update() {
    rotY += incY;
    rotZ += incZ;
    count += .51;
  }

  // Draw the Electron
  void show() {
    color c = color(255, 0, 0);
    stroke(c);
    strokeWeight(1);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateY(rotY);
    rotateZ(rotZ);
    noFill();
    beginShape();
    for ( float a = 0; a < TWO_PI; a += .7) {
      float x = cos(a) * w;
      float y = sin(a) * h;
      vertex(x, y);
    }
    endShape(CLOSE);
    float a = count % 360;
    float x = cos(radians(a)) * w;
    float y = sin(radians(a)) * h;
    translate(x, y);
    noStroke();
    fill(c);
    box(10);
    popMatrix();
  }
}