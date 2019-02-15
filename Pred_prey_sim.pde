import g4p_controls.*;

// Tom Weston
// ver 0.3

GWindow window;
Sim sim;

void setup() 
{
  size(500, 500);
  frameRate(10);
  smooth();
  sim = new Sim();

  window =  GWindow.getWindow(this, "My Window", 100, 50, 500, 500, JAVA2D);
  window.addDrawHandler(this, "windowDraw");
}

void draw() 
{
  background(255);

  sim.generate();
  sim.display();
}

public void windowDraw(PApplet app, GWinData data) 
{
  app.background(255);
  app.strokeWeight(2);

  app.fill(127,0,0);
  app.rect(50, 500, 50, -sim.predCount/30);
  
  app.fill(102,102,255);
  app.rect(100, 500, 50, -sim.preyCount/30);
  System.out.println(sim.predCount);
}

// reset board when mouse is pressed
void mousePressed() 
{
  sim.init();
}
