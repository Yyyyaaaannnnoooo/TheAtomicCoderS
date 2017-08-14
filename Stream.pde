class Stream {
  ArrayList <PVector> stream;
  PVector[] crossStream;
  boolean isCrossed = false, showBox = false, hittedWater = false;
  color c;
  int step = 0, pxl = 15, pollution = 0;
  int x, y, z, x1, y1, z1, x2, y2, z2;
  Stream (int x1_, int y1_, int z1_, int x2_, int y2_, int z2_, color col, boolean sb) {
    stream = new ArrayList <PVector>();
    x1 = x1_;
    y1 = y1_;
    z1 = z1_;
    x2 = x2_;
    y2 = y2_;
    z2 = z2_;    
    c = col;
    showBox = sb;
    ///making streams with "elbows"
    ///calculating the midpoint with some offset
    float d = abs(y2 - y1);
    int midPoint = int(d * random(0.15, 0.85));
    for (int i = y1; i < midPoint; i += 5) {
      stream.add(new PVector(x1, i, z1));
    }
    for (int i = x1; i < x2; i += 5) {
      stream.add(new PVector(i, midPoint, z1));
    }
    for (int i = midPoint; i < y2; i += 5) {
      stream.add(new PVector(x2, i, z1));
    }
    for (int i = z1; i < 0; i += 5) {
      stream.add(new PVector(x2, y2, i));
    }
  }

  Stream (int x_, int y_, int z_, color col, boolean sb) {
    stream = new ArrayList <PVector>();
    x = x_;
    y = y_;
    z = z_;
    c = col;
    showBox = sb;
    for (int i = z; i < 0; i += 5) {
      stream.add(new PVector(x, y, i));
    }
  }
  void update() {
    step += 2;
  }

  void show() {
    stroke(c);
    noFill();
    strokeWeight(5);
    beginShape();
    for (int i = 0; i < stream.size(); i++) {
      PVector p = stream.get(i);
      vertex(p.x, p.y, p.z);
    }
    endShape();
    if (showBox) {
      PVector p = stream.get(step % stream.size());
      pushMatrix();
      translate(p.x, p.y, p.z);
      noStroke();
      fill(c);
      box(pxl);
      popMatrix();
    }
    if (isCrossed) {
      int index = step % crossStream.length;
      pushMatrix();
      translate(crossStream[index].x, crossStream[index].y, crossStream[index].z);
      noStroke();
      fill(radWaste);
      box(pxl);
      popMatrix();
      if (index == 0)hittedWater = true;
      else hittedWater = false;
    }
  }
  ///function that generates a new path when to streams are crossing///
  void crossingStream(Stream s1, Stream s2) {
    int s1End = 0, s2Begin = 0;
    for (int i = 0; i < s1.stream.size(); i++) {
      PVector p1 = s1.stream.get(i);
      for (int j = 0; j < s2.stream.size(); j++) {
        PVector p2 = s2.stream.get(j);
        float d = PVector.dist(p1, p2);
        if (d < 5) {
          isCrossed = true;
          s1End = i;
          s2Begin = j;
        }
      }
    }
    ///here we create a new array of vectors containing
    ///all the positions of the crossed streams
    ///try it with arrayCopy();
    int numVec = s1End + (s2.stream.size() - s2Begin);
    crossStream = new PVector[numVec];
    for (int i = 0; i < crossStream.length; i++) {
      if (i < s1End) {
        PVector p3 = s1.stream.get(i);
        crossStream[i] = new PVector(p3.x, p3.y, p3.z);
      } else {
        PVector p3 = s2.stream.get(i + (s2Begin - s1End));
        crossStream[i] = new PVector(p3.x, p3.y, p3.z);
      }
    }
  }
}