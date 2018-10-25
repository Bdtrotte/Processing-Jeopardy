import java.util.List;

class GhostHive
{
  ArrayList<Ghost> ghosts;
  Gif gif;
  
  GhostHive(Gif gif)
  {
    ghosts = new ArrayList<Ghost>();
    this.gif = gif;
  }
  
  void emit(float x, float y, int n)
  {
    for (int i = 0; i < n; ++i)
      ghosts.add(new Ghost(x, y, random(0, TWO_PI), random(10, 20), gif));
  }
  
  void updateAndDisplay()
  {
    int i = 0;
    while (i < ghosts.size()) {
      if (ghosts.get(i).update())
        ghosts.get(i++).render();
      else
        ghosts.remove(i);
    }
  }
}

class Ghost
{
  float x,y,dir,speed, a;
  Gif gif;
  
  Ghost(float x, float y, float dir, float speed, Gif gif)
  {
    a = 0;
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.speed = speed;
    
    this.gif = gif;
  }
  
  boolean update()
  {
    x += cos(dir) * speed;
    y += sin(dir) * speed;
    dir += cos(a += 0.7)/5;
    
    float o = 20;
    return x > -o && x < width + o && y > -o && y < width + o;
  }
  
  void render()
  {
    centerDrawImage(gif, 1, false, x, y, dir + PI/2);
  }
}