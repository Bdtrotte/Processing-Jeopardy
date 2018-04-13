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
  
  void displayLarge()
  {
    noStroke();
    fill(backgroundColor);
    rect(0, 0, width, height);
    
    textSize(150);
    textAlign(CENTER, CENTER);
    fill(0);
    text(question, 4, 4, width, height);
    fill(255);
    text(question, 0, 0, width, height);
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