int numRobots = 80;
float[] potentials = new float[numRobots];
float[] dampingFactors = new float[numRobots];
float k = 0.999f;

void setup()
{
  size(800, 600);
  
  for(int i = 0; i < numRobots; i++) dampingFactors[i] = k;
}

void draw()
{
  background(255);
  rectMode(CORNERS);
  float maxPotential = 1;
  float[] newDampingFactors = new float[numRobots];
  float[] newPotentials = new float[numRobots];
  for (int i = 0; i < numRobots; i++)
  {
    float x = min(getDampingFactor(i-1), getDampingFactor(i+1));
    newDampingFactors[i] = x + (k - x)*0.5f;
    newPotentials[i] = max(getPotential(i-1), getPotential(i+1)) * dampingFactors[i];
    float x1 = map(i, 0, numRobots, 0, width);
    float y1 = map(potentials[i], 0, maxPotential, height, 0);
    float x2 = map(i+1, 0, numRobots, 0, width);
    float y2 = height;
    noStroke();
    fill(255, 0, 0);
    rect(x1, y1, x2, y2);
    noFill();
    stroke(0);
    rect(x1, 0, x2, y2);
  }
  dampingFactors = newDampingFactors;
  potentials = newPotentials;

  if (mousePressed)
  {
    int robot = (int) map(mouseX, 0, width, 0, numRobots);
    if(robot < 0 || robot >= numRobots) return;
    if(mouseButton == LEFT) //Induce signal
    {
      potentials[robot] = 1;
      dampingFactors[robot] = k;
    }
    if(mouseButton == RIGHT) //Erase Signal
    {
      //potentials[robot] = 0;
      dampingFactors[robot] = 0.1;
    }
    
  }
}

float getPotential(int i)
{
  if (i >= 0 && i < numRobots) return potentials[i];
  else return 0.0f;
}

float getDampingFactor(int i)
{
  if (i >= 0 && i < numRobots) return dampingFactors[i];
  else return 1.0f;
}

int lNeighbor(int i)
{
  if (i == 0) return numRobots - 1;
  else return (i-1)%numRobots;
}

int rNeighbor(int i)
{
  return (i+1) % numRobots;
}


