import gifAnimation.*;

class GifBase
{
  Gif[] gifs;
  
  GifBase(PApplet pa)
  {
    gifs = new Gif[6];
    gifs[0] = new Gif(pa, "danceBoys.gif");
    gifs[1] = new Gif(pa, "cheeze.gif");
    gifs[2] = new Gif(pa, "creepen.gif");
    gifs[3] = new Gif(pa, "tenor.gif");
    gifs[4] = new Gif(pa, "spooky.gif");
    gifs[5] = new Gif(pa, "swim.gif");
    
    for (int i = 0; i < gifs.length; ++i) {
      gifs[i].loop();
    }
  }
  
  PImage randGif()
  {
    return gifs[(int)random(0, gifs.length)];
  }
}

void centerDrawImage(PImage img, float scale, boolean flip, float x, float y)
{
  pushMatrix();
  float xS = 1;
  if (flip)xS = -1;
  scale(xS * scale, scale);
  translate(xS * x / scale - img.width/2, y / scale - img.height/2);
  
  image(img, 0, 0);
  
  popMatrix();
}

class SpookImage
{
  GifBase gb;
  
  SpookImage(GifBase gb)
  {
    this.gb = gb;
  }
  
  void render()
  {
    centerDrawImage(gb.gifs[4], 1.5, false, width/2, height/4);
    centerDrawImage(gb.gifs[3], 1, false, width/20, height/4);
    centerDrawImage(gb.gifs[3], 1, true, width*19/20, height/4);
    centerDrawImage(gb.gifs[2], 1, false, width/20, height*5/6);
    centerDrawImage(gb.gifs[2], 1, true, width*19/20, height*5/6);
    centerDrawImage(gb.gifs[0], 2, false, width/2, height*2/3);
  }
}