class Particle {
  PVector pos, target, vel, acc;
  PVector[] trail;
  float speed = 5;
  int r = 7, count = 0, particleLife = 300, pSize = 10;
  color c;
  boolean removeParticle = false, t;
  //position and target of the particle
  Particle(float posX, float posY, float posZ, float trX, float trY, float trZ, boolean hasTrail) {
    c = color(0, 255, 0, 175);
    t = hasTrail;
    target = new PVector(trX, trY, trZ);
    pos = new PVector(posX, posY, posZ);
    vel = new PVector(0, 0, 0);
    trail = new PVector[25];
  }
  void update() {
    PVector dir = PVector.sub(target, pos);
    dir.normalize();
    dir.mult(0.25);
    acc = dir;
    vel.add(acc);
    vel.limit(speed);
    pos.add(vel);
    trail[count % trail.length] = new PVector(pos.x, pos.y, pos.z);
    count++;
    particleLife--;
    if (particleLife < 0) removeParticle = true;
  }
  void show() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    fill(c);
    noStroke();
    box(15);
    popMatrix();
    if (t) {
      pushMatrix();
      noFill();
      beginShape();
      for (int i = 0; i < trail.length; i++) {
        strokeWeight(3);
        stroke(255, 0, 0);
        if (trail[i] != null)vertex(trail[i].x, trail[i].y, trail[i].z);
      }
      endShape();
      popMatrix();
    }
  }
  //the ionized particle hits a target
  void hit(Particle p, Paddle pad, ArrayList <Icon> i) {
    for (Icon theTarget : i) {
      float d = PVector.dist(theTarget.pos, p.pos);
      if (d < 5) {
        p.removeParticle = true;
        theTarget.health--;
        a.playNotes(2);
      }
    }
    if (p.pos.x < pad.x + pad.w && p.pos.x > pad.x - pad.w
    && p.pos.y > pad.y - pad.h / 2 && p.pos.y < pad.y + pad.h / 2) {
      p.removeParticle = true;
      pad.w -= 0.5;
    }
  }
}