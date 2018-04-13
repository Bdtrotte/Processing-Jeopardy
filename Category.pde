class Category
{
  String name;
  Question[] questions;
  
  Category(String n, Question[] q)
  {
    name = n;
    questions = q;
  }
  
  void mousePing(int column, int totalColumns)
  {
    for (int i = 0; i < questions.length; ++i)
      questions[i].mousePing(column, i, questions.length, totalColumns);
  }
  
  void display(int column, int totalColumns)
  {
    float pxPerRow = height / (float)(questions.length + 1);
    float pxPerCol = width / (float)totalColumns;
    
    float x = pxPerCol * column;
    float y = 0;
    
    fill(0);
    rect(x, y, pxPerCol, pxPerRow);
    fill(80, 80, 255);
    rect(x + borderWidth * 2, y + borderWidth * 2, pxPerCol - borderWidth * 4, pxPerRow - borderWidth * 4);
    
    textSize(30);
    textAlign(CENTER, CENTER);
    fill(0);
    text(name, x + 4, y + 4, pxPerCol, pxPerRow);
    fill(255);
    text(name, x, y, pxPerCol, pxPerRow);
    
    for (int i = 0; i < questions.length; ++i)
      questions[i].displaySmall(column, i, questions.length, totalColumns);
  }
}