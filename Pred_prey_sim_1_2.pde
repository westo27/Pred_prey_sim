import g4p_controls.*;

// Tom Weston
// ver 1.3

GWindow window;
Sim sim;
PrintWriter output;

void setup() 
{
  size(500, 500);
  frameRate(60);
  smooth();
  sim = new Sim();

  window =  GWindow.getWindow(this, "My Window", 100, 50, 500, 500, JAVA2D);
  window.addDrawHandler(this, "windowDraw");
  output = createWriter("ver_1_2.m"); 
}

void draw() 
{
  background(255);

  sim.generate();
  sim.display();
  
  if (sim.generation == 500)
  {
    //logResults();
  }
  
  System.out.println(sim.generation); 
}

public void windowDraw(PApplet app, GWinData data) 
{
  app.background(255);
  app.strokeWeight(2);

  app.fill(127,0,0);
  app.rect(50, 500, 50, -sim.predCount/10);
  
  app.fill(102,102,255);
  app.rect(100, 500, 50, -sim.preyCount/10);
}

void logResults() {
  output.println("pred=[");
  for(int i=0; i<sim.predCountArr.size(); i++)
  {
    output.print(sim.predCountArr.get(i) + ",");
  }
  output.println("];");
  
  output.println("prey=[");
  for(int i=0; i<sim.preyCountArr.size(); i++)
  {
    output.print(sim.preyCountArr.get(i) + ",");
  }
  output.println("];");
  output.println("plot(pred,'r');");
  output.println("hold on;");
  output.println("plot(prey,'b');");
  
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}
