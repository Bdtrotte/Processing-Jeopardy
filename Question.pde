int borderWidth = 2;
color backgroundColor = color(50, 50, 255);

class Question
{
  String question;
  int pointValue;
  Team winner;
  
  boolean wasPicked;
  boolean isMousedOver;
  
  Question(String q, int pv)
  {
    question = q;
    pointValue = pv;
    
    winner = null;
    wasPicked = false;
    isMousedOver = false;
  }
  
  void displaySmall(int column, int row, int totalRows, int totalColumns)
  {
    float pxPerRow = height / (float)(totalRows + 1);
    float pxPerCol = width / (float)totalColumns;
    
    float x = column * pxPerCol;
    float y = pxPerRow + row * pxPerRow;
    
    noStroke();
    fill(0);
    rect(x, y, pxPerCol, pxPerRow);
    fill(backgroundColor);
    rect(x + borderWidth, y + borderWidth, pxPerCol - 2 * borderWidth, pxPerRow - 2 * borderWidth);
    
    textSize(50);
    textAlign(CENTER, CENTER);
    String s = "$" + pointValue;
    fill(0);
    text(s, x + 4, y + 4, pxPerCol, pxPerRow);
    fill(255, 255, 0);
    text(s, x, y, pxPerCol, pxPerRow);
    
    if (wasPicked) {
      fill(0, 200);
      rect(x, y, pxPerCol, pxPerRow);
      textAlign(CENTER, BOTTOM);
      textSize(30);
      fill(200);
      text(winner.name, x, y, pxPerCol, pxPerRow - 4);
    } else if (isMousedOver) {
      fill(0, 100);
      rect(x, y, pxPerCol, pxPerRow);
    }
  }
  
  float bigProg = 0;
  
  void displayLarge(int column, int row, int totalRows, int totalColumns)
  {
    bigProg += 0.05;
    
    if (bigProg < 1.5) {
      float pxPerRow = height / (float)(totalRows + 1);
      float pxPerCol = width / (float)totalColumns;
      
      float x = column * pxPerCol;
      float y = pxPerRow + row * pxPerRow;
      
      pushMatrix();
      
      float f = min(bigProg, 1);
      
      float xS = width / pxPerCol;
      float yS = height / pxPerRow;
      
      xS = (xS - 1) * f + 1;
      yS = (yS - 1) * f + 1;
      
      if (bigProg > 1) {
        background(backgroundColor);
        float _f = (bigProg - 1) * 2;
        xS *= (1 - _f);
      }
      
      translate((width / 2 - x - pxPerCol / 2) * f + x + pxPerCol / 2, 
                (height / 2 - y - pxPerRow / 2) * f + y + pxPerRow / 2);
      scale(xS, yS);
      translate(-x - pxPerCol / 2, -y - pxPerRow / 2);
      
      displaySmall(column, row, totalRows, totalColumns);
      
      popMatrix();
    } else {
      background(backgroundColor);
      
      float f = min(1, (bigProg - 1.5) * 2);
      
      pushMatrix();
      
      translate(width/2, height/2);
      scale(f, 1);
      translate(-width/2, -height/2);
      
      noStroke();
      fill(backgroundColor);
      rect(0, 0, width, height);
      
      textSize(150);
      textAlign(CENTER, CENTER);
      fill(0);
      text(question, 4, 4, width, height);
      fill(255);
      text(question, 0, 0, width, height);
      
      popMatrix();
    }
  }
  
  void mousePing(int column, int row, int totalRows, int totalColumns)
  {
    float pxPerRow = height / (float)(totalRows + 1);
    float pxPerCol = width / (float)totalColumns;
    
    float x = column * pxPerCol;
    float y = pxPerRow + row * pxPerRow;
    
    isMousedOver = mouseX >= x &&
                   mouseY >= y &&
                   mouseX <  x + pxPerCol &&
                   mouseY <  y + pxPerRow;
  }
  
  boolean mousedOver()
  {
    return isMousedOver;
  }
  
  void awardPoints(Team t)
  {
    bigProg = 0;
    wasPicked = true;
    winner = t;
    t.points += pointValue;
  }
  
  void reset()
  {
    if (!wasPicked) return;
    
    winner.points -= pointValue;
    winner = null;
    wasPicked = false;
  }
}