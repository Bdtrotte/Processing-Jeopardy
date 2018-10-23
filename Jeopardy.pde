import java.util.*;

Team[] teams = {
  new Team("Team 1"),
  new Team("Team 2"),
  new Team("Team 3"),
  new Team("Team 4"),
  new Team("Team 5")
};

//Calculus
Question[] questionSet1 = {
  new Question("Find dy/dx for x^3y^2z+3xyw+w^3+z^2+3y+6x = 9", 200),
  new Question("Find f'(x) for f(x) = sqrt(1-sqrt(2-sqrt(3-x)))", 400),
  new Question("A mathematician builds a washing machine which, for whatever reason, is 10 feet tall. Because he is a mathematician, he tells you the area, in square feet, of the horizontal cross section at height h is given by A(h) = 50h. Water begins to fill this monstrosity. When the height of the water is 5 feet, the height increases at a rate of 1 foot/min. Find the rate at which volume changes with respect to time at this point", 600),
  new Question("Demonstrate that for n = 1, 2 , 3, ...\nsin(a) = 2^nsin(a/2^n)cos(a/2)cos(a/4)...cos(a/2n)", 800),
  new Question("For what values (a,b) of positive real numbers does the improper integral:the integral from b to infinity of sqrt(sqrt(x+a)-sqrt(x)) - sqrt(sqrt(x)-sqrt(x-b)converge?", 1000)
};

//Algerbra
Question[] questionSet2 = {
  new Question("Determine if the following vectors span R^4: (1,2,0,-2) (2,4,0,-3) (3,6,1,-4) (4,8,2,-5) (1,1,1,0)", 200),
  new Question("Let sigma = ( 1 2 ) ( 1 4 3 2 ) ( 5 7 6 8 ) ( 3 1 2 ) in Sym(8) be a permutation. Determine order(sigma)sign(sigma).", 400),
  new Question("Let H,K <= G be subgroups of a finite group G. Prove that |HK| = |H||K|/|H intersect K|.", 600),
  new Question("Determine [Q(sqrt(2),cuberoot(2)) : Q] x |Sym(5)| mod 7", 800),
  new Question("Prove that the polynomial x^4 - 10x^2 - 99 is irreducible over Q.", 1000)
};

//Complex
Question[] questionSet3 = {
  new Question("What is arg(4/(sqrt(2)-isqrt(2))?", 200),
  new Question("Give a value of (-8i)^(1/3) not on the imaginary line.", 400)
};

//Discrete
Question[] questionSet4 = {
  new Question("How many ways can you arrange 30 people on a ferris wheel with 30 seats?", 200),
  new Question("How many unique arrangements of the letters in \"Math is hella lit\" are there?", 400),
  new Question("Suppose you have a set A with |A|=n, and a set B with |B|=m. How many distinct functions are there from A to B?", 600),
  new Question("Prove pascal's identity (n+1 choose k) = (n choose k) + (n choose k-1)", 800),
  new Question("Prove the binomial theorem: (a+b)^n = sum(i=0, n)( (n choose i)(a^n-i)(b^i) )", 1000)
};

//Geometry
Question[] questionSet5 = {
  new Question("Which 3D solid has the highest volume to surface area ratio?", 200),
  new Question("What is the interior angle (degrees) of one of the corners of a regular 24-gon?", 400),
  new Question("A Reuleaux triangle is a shape formed from the intersection of three circular disks, each having its center on the boundary of the other two. What is the area of a Reuleaux Triangle given the radius of the circles as R.", 600),
  new Question("Consider n-dimensional Euclidean space (R^n) with the standard coordinate axes, and center 2^n unit hyperspheres at each of the coordinates (+-1,...,+-1). What is the radius of a hypersphere centered at (0,...,0) tangent to all these other spheres?", 800),
  new Question("Consider a circle of radius r and a chord (above the center) of length c. Derive a formula for the smaller area cut off by the chord in terms of r and c.", 1000)
};

//Misc
Question[] questionSet6 = {
  new Question("How many primes less than 50 can be written as the sum of two square integers?", 600),
  new Question("A natural number n is called (m,k)-perfect if it satisfies the equation sigma^m(n) = kn,where sigma(n) = the sum of all the divisors of n. What is the smallest (2,3)-perfect number?", 800),
  new Question("Prove that the cardinality of the set of transcendental (i.e. is not a root of any polynomial with rational coefficients) elements of C is equal to that of R.", 1000)
};

Category[] cats = {
  new Category("Calculus", questionSet1),
  new Category("Algebra", questionSet2),
  new Category("Complex", questionSet3),
  new Category("Discrete", questionSet4),
  new Category("Geometry", questionSet5),
  new Category("Misc!", questionSet6)
};

Confetti[] confettiCanons;

Question currentQuestion = null;
int curRow;
int curCol;
boolean displayingQuestions = true;
Stack<Question> pastQuestions = new Stack<Question>();

GifBase gb;
SpookImage si;

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
  
  gb = new GifBase(this);
  si = new SpookImage(gb);
}

void draw()
{
  background(0);
  
  for (int i = 0; i < cats.length; ++i) {
    cats[i].display(i, cats.length);
  }
  
  if (displayingQuestions) {
    for (int i = 0; i < cats.length; ++i) {
      cats[i].mousePing(i, cats.length);
    }
  } else {
    currentQuestion.displayLarge(curCol, curRow, cats[curCol].questions.length, cats.length);
  }
  
  if (keyPressed) {
    switch(key) {
      case 's':
        displayTeams();
        return;
      case 'c':
        for (Confetti c : confettiCanons) {
          c.emit((int)random(3, 4));
        }
        break;
      case 'x':
        si.render();
        break;
    }
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