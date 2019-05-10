import java.util.*;

Team[] teams = {
  new Team("Team 1"),
  new Team("Team 2"),
  new Team("Team 3"),
  new Team("Team 4"),
  new Team("Team 5")
};

//Algebra
Question[] questionSet1 = {
  new Question("X + 9 = 26\nWhat is X?", 200),
  new Question("Y = 4X + 1\nY + 5 = -12 + Z\nZ - 14 = 8\nWhat is X?", 400),
  new Question("Let f = (3156)(24)(987) be a permutation. What is the smallest e such that f^e = Id?", 600),
  new Question("What is the automorphism group of the following graph: (a square, but with a fifth vertex in the middle connected to all 4 other vertices)", 800),
  new Question("Give a group homomorphism from ZxZ to R.", 1000)
};

//Number Theory
Question[] questionSet2 = {
  new Question("What is the 4th term in the 5th row of pascal’s triangle?", 200),
  new Question("Find an integer between 0 and 40 such that x ≡ 4 mod 5 and x ≡ 3 mod 7", 400),
  new Question("phi(n) is a function defined as the number of integers m less than n such that gcd(m,n) = 1. What is the highest value of phi for 0 < n < 100?", 600),
  new Question("What is the largest number you can write with the digits 1-9 without repeating digits, such that the number is divisible by 6?", 800)
};

//Geometry
Question[] questionSet3 = {
  new Question("Consider a rectangle with sides lengths 1 and x. What should x be so that the ratio between perimeter and area is 7?", 200),
  new Question("Consider a cube centered at the origin in R^3 of side length 2, and place a sphere of radius 1 at each corner of the cube (so they’re each tangent to the 3 adjacent ones). What is the radius of a 9th sphere centered at the origin tangent to each of these 8 spheres?", 600),
  new Question("Consider an icosahedron (12 verts, 20 triangular faces). We “cut off” each of the 12 vertices, leaving a regular pentagon in its place surrounded by regular hexagons. How many edges does this new solid have?", 800),
  new Question("Divide a circle into congruent divisions such that at least one of them does not touch the center.", 1000)
};

//Meta Math
Question[] questionSet4 = {
  new Question("This proposition from Euclid’s elements is often called “Pons Asinorum.”", 200),
  new Question("While both Leibnitz and Newton are credited with discovering The Calculus, this defamed one definitively published first.", 400),
  new Question("L'Hôpital’s rule was not discovered by L'Hôpital. This mathematician did.", 600),
  new Question("This mathematician was the first woman awarded the Fields Medal", 800),
  new Question("List these mathematicians by the age at which they died, low to high: Gauss, Ramanujan, Galois, Abel, Euler, and Riemann.", 1000)
};

//Misc
Question[] questionSet5 = {
  new Question("What is seven times five minus nine times four, all squared, minus 13?", 200),
  new Question("How many squares are there between 0 and 200?", 400),
  new Question("How many real roots does x^6 - 1 have", 600),
  new Question("Give an example of a function from R to R that is discontinuous at uncountable many points and continuous at uncountably many points.", 800)
};

Category[] cats = {
  new Category("Algebra", questionSet1),
  new Category("Number Theory", questionSet2),
  new Category("Geometry", questionSet3),
  new Category("Math History", questionSet4),
  new Category("Misc", questionSet5)
};

Confetti[] confettiCanons;

Question currentQuestion = null;
int curRow;
int curCol;
boolean displayingQuestions = true;
Stack<Question> pastQuestions = new Stack<Question>();

void setup()
{
  size(1200,800);
  //fullScreen();
  
  smooth();
  
  Confetti[] cc = {
    new Confetti(width     / 10, 0*height / 10, PI/2, PI/2, 5, 2),
    new Confetti(width * 3 / 10, 0*height / 10, PI/2, PI/2, 5, 2),
    new Confetti(width     /  2, 0*height / 10, PI/2, PI/2, 5, 2),
    new Confetti(width * 7 / 10, 0*height / 10, PI/2, PI/2, 5, 2),
    new Confetti(width * 9 / 10, 0*height / 10, PI/2, PI/2, 5, 2)
  };
  
  confettiCanons = cc;
}

void draw()
{
  background(0);
  
  for (int i = 0; i < cats.length; ++i) {
    cats[i].display(i, cats.length);
  }
  
  if (keyPressed) {
    switch(key) {
      case 's':
        displayTeams();
        return;
      case 'c':
        for (Confetti c : confettiCanons) {
          c.emit((int)random(3, 13));
        }
        break;
    }
  }
  
  if (displayingQuestions) {
    for (int i = 0; i < cats.length; ++i) {
      cats[i].mousePing(i, cats.length);
    }
  } else {
    currentQuestion.displayLarge(curCol, curRow, cats[curCol].questions.length, cats.length);
  }
  
  for (Confetti c : confettiCanons) {
    c.updateAndDisplay();
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
    case 'p':
      printScores();
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
        
        return;
      } else if (k == 0) {
        currentQuestion.bigProg = 0;
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
    int qr = -1;
    int qc = -1;
    for (int i = 0; i < cats.length; ++i) {
      for (int j = 0; j < cats[i].questions.length; ++j) {
        if (cats[i].questions[j].mousedOver()) {
          q = cats[i].questions[j];
          qr = j;
          qc = i;
        }
      }
    }
    
    currentQuestion = q;
    curRow = qr;
    curCol = qc;
    
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

void printScores()
{
  for (int i = 0; i < teams.length; ++i) {
    println("Team \"" + teams[i].name + "\" has " + teams[i].points +" points");
  }
  println();
}