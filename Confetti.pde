import java.util.List;

float gravity = 0.5;

class Confetti {
  ArrayList<Confet> confets;
  float posX, posY, dir, dirVar, speed, speedVar;
  
  Confetti(float posX, float posY, float dir, float dirVar, float speed, float speedVar)
  {
    confets = new ArrayList<Confet>();
    
    this.posX = posX;
    this.posY = posY;
    this.dir = dir;
    this.dirVar = dirVar;
    this.speed = speed;
    this.speedVar = speedVar;
  }
  
  void emit(int n) 
  {
    for (int i = 0; i < n; ++i) {
      float d = dir + random(-dirVar, dirVar);
      float s = speed + random(-speedVar, speedVar);
      color cl = color(random(0, 255), random(0, 255), random(0, 255));
      Confet c = new Confet(posX, posY, cos(d) * s, sin(d) * s, cl);
      confets.add(c);
    }
  }
  
  void updateAndDisplay()
  {
    int i = 0;
    while(i < confets.size()) {
      if (confets.get(i).update()) {
        confets.get(i++).display();
      } else {
        confets.remove(i);
      }
    }
  }
}

class Confet {
  float x, y, xS, yS;
  color c;
  
  Confet(float _x, float _y, float _xS, float _yS, color _c)
  {
    x = _x;
    y = _y;
    xS = _xS;
    yS = _yS;
    c = _c;
  }
  
  boolean update()
  {
    yS += gravity;
    
    x += xS;
    y += yS;
    
    float o = 20;
    return x > -o && x < width + o && y > -o && y < width + o;
  }
  
  void display()
  {
    noStroke();
    fill(c);
    ellipse(x, y, 12, 12);
  }
}