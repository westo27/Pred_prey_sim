  import g4p_controls.*;
  import javax.swing.*; 
  import java.lang.*;
  
  /**
   * This is a Cellular Automata system that attempts to simulate the predator-prey interactions seen in the Lotka-Volterra model.
   *
   * Bugs: none known
   *
   * @author       Tom Weston
   * @version      4.0
   * @see also     Sim
   */
  
  //Global Variables
  GWindow window;
  int op1,op2;
  float op3;
  String op4;
  Sim sim;
  PrintWriter output;
  
  /** METHOD
  * Defines initial enviroment properties
  */
  void setup() 
  //User input handler
  {
    //User input prompt before runtime
    userInputHandler();
    
    //Properties of the main window
    size(500, 500);
    frameRate(10);
    smooth();
    
    //Sim object
    sim = new Sim(op2, op3, op4);
  
    //Init second window
    window =  GWindow.getWindow(this, "My Window", 100, 50, 500, 500, JAVA2D);
    window.addDrawHandler(this, "windowDraw");
    output = createWriter("results/ver_4_results.m"); 
  }
  
  /** METHOD
  * Continuously draws inside the window
  */
  void draw() 
  {
    background(255);
  
    sim.generate();
    sim.display();
    
    //Timer
    if (sim.generation == op1)
    {
      logResults();
    }
    
    System.out.println(sim.generation); 
  }
  
  /** METHOD
  * Continuously draws inside the second window
  *
  * @param PApplet The window to be drawn inside
  * @param GWinData Window data
  */
  public void windowDraw(PApplet app, GWinData data) 
  {
    frameRate(10);
    app.background(255);
    app.strokeWeight(2);
    
    //Predator graph
    app.fill(127,0,0);
    app.rect(50, 500, 50, -sim.predCount/10);
    app.text(sim.predCount,50,100);
    
    //Prey graph
    app.fill(102,102,255);
    app.rect(100, 500, 50, -sim.preyCount/10);
    app.text(sim.preyCount,100,100);
  }
  
  /** METHOD
  * Writes the results to a file
  */
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
  
  /** METHOD
  * Requests and handles user input before runtime
  */
  void userInputHandler(){
    try 
    { 
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    } 
    catch (Exception e) 
    { 
      e.printStackTrace();
    } 
    String op1s = JOptionPane.showInputDialog(frame, "How many generations would you like the simulation to run for?", 500);
    if(op1s != null) op1=Integer.parseInt(op1s);
    String op2s = JOptionPane.showInputDialog(frame, "What percentage of the board would you like filled initially?", 10);
    if(op2s != null) op2=Integer.parseInt(op2s);
    String op3s = JOptionPane.showInputDialog(frame, "What would you like the predator catch rate to be? (0.0 - 1.0)", 0.33);
    if(op3s != null) op3=java.lang.Float.parseFloat(op3s);
    op4 = JOptionPane.showInputDialog(frame, "What method of distribution would you like to use? Stochastic or deterministic? (s or d)", "d");
  }
