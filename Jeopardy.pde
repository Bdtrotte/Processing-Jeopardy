import java.util.Stack;

Team[] teams = {
  new Team("Team 1"),
  new Team("Team 2"),
  new Team("Team 3"),
  new Team("Team 4"),
  new Team("Team 5")
};

Question[] questionSet1 = {
  new Question("This is question a1", 200),
  new Question("This is question a2", 400),
  new Question("This is question a3", 600),
  new Question("This is question a4", 800),
  new Question("This is question a5", 1000)
};

Question[] questionSet2 = {
  new Question("This is question b1", 200),
  new Question("This is question b2", 400),
  new Question("This is question b3", 600),
  new Question("This is question b4", 800),
  new Question("This is question b5", 1000)
};

Question[] questionSet3 = {
  new Question("This is question c1", 200),
  new Question("This is question c2", 400),
  new Question("This is question c3", 600),
  new Question("This is question c4", 800),
  new Question("This is question c5", 1000)
};

Question[] questionSet4 = {
  new Question("This is question d1", 200),
  new Question("This is question d2", 400),
  new Question("This is question d3", 600),
  new Question("This is question d4", 800),
  new Question("This is question d5", 1000)
};

Question[] questionSet5 = {
  new Question("This is question e1", 200),
  new Question("This is question e2", 400),
  new Question("This is question e3", 600),
  new Question("This is question e4", 800),
  new Question("This is question e5", 1000)
};

Category[] cats = {
  new Category("Cat A", questionSet1),
  new Category("Cat B", questionSet2),
  new Category("Cat C", questionSet3),
  new Category("Cat D", questionSet4),
  new Category("Cat E", questionSet5)
};

Question currentQuestion = null;
boolean displayingQuestions = true;
Stack<Question> pastQuestions = new Stack<Question>();

void setup()
{
  fullScreen();
}

void draw()
{
  background(0);
  
  if (keyPressed && key == 's') {
    displayTeams();    
    return;
  }
  
  if (displayingQuestions) {
    for (int i = 0; i < cats.length; ++i) {
      cats[i].mousePing(i, cats.length);
      cats[i].display(i, cats.length);
    }
  } else {
    currentQuestion.displayLarge();
  }
}

void keyPressed()
{
  if (displayingQuestions) {
    switch(key) {
    case 'r':
      if (!pastQuestions.empty())
        pastQuestions.pop().reset();
      break;
    }
  } else if (currentQuestion != null) {
    int k = key;
  
    if (k >= 48 && k <= 57) {
      k -= 48;
      
      if (k > 0 && k <= teams.length) {
        currentQuestion.awardPoints(teams[k - 1]);
        pastQuestions.push(currentQuestion);
        currentQuestion = null;
        displayingQuestions = true;
        
        for (int i = 0; i < teams.length; ++i) {
          println("Team " + teams[i].name + " score: " + teams[i].points);
        }
        
        return;
      } else if (k == 0) {
        currentQuestion = null;
        displayingQuestions = true;
      }
    }
  }
}

void mousePressed()
{
  if (displayingQuestions) {
    Question q = null;
    for (int i = 0; i < cats.length; ++i) {
      q = cats[i].mousedOver();
      
      if (q != null) break;
    }
    
    currentQuestion = q;
    
    if (currentQuestion != null) {
      if (currentQuestion.wasPicked) return;
      displayingQuestions = false;
    }
  }
}

void displayTeams()
{
  textSize(80);
  
  float pxPerTeam = height / (float)teams.length;
  
  for (int i = 0; i < teams.length; ++i) {
    float y = i * pxPerTeam + pxPerTeam/2;
    
    fill(0);
    rect(0, i * pxPerTeam, width, pxPerTeam);
    fill(backgroundColor);
    rect(0, i * pxPerTeam + 2, width, pxPerTeam - 4);
    
    textAlign(LEFT, CENTER);
    fill(0);
    text(teams[i].name, 14, y + 4);
    fill(255);
    text(teams[i].name, 10, y);
    textAlign(RIGHT, CENTER);
    fill(0);
    text("$" + teams[i].points, width - 6, y + 4);
    fill(255, 255, 0);
    text("$" + teams[i].points, width - 10, y);
  }
}