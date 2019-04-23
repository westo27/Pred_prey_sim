class Sim 
{
  // Window divider
  int div = 8;
  // Column and rows to store x and y coords for board[][]
  int columns, rows;
  // Predator and prey counts each cycle
  int preyCount, predCount;
  int generation;

  // Board, this 2D array fills every position on the board
  int[][] board;
  ArrayList<Integer> predCountArr = new ArrayList<Integer>();
  ArrayList<Integer> preyCountArr = new ArrayList<Integer>();

  Sim() 
  {
    // Initialize rows, columns and set-up arrays
    columns = width/div;
    rows = height/div;
    board = new int[columns][rows];
    generation = 0;
    init();
  }

  void init() {
    //Loop through board array and call predPreyPicker() on each entity
    for (int i =1;i < columns-1;i++) 
    {
      for (int j =1;j < rows-1;j++) 
      {
        board[i][j] = predPreyPicker();
      }
    }
  }

  //Creates the new generation, called each cycle by the draw() function
  void generate() 
  {    
    //Reset prey and pred count from last cycle
    preyCount = 0;
    predCount = 0;
    int[][] next = new int[columns][rows];

    //Loop through board and count the number of cells within the moore neighborhood
    for (int x = 1; x < columns-1; x++) 
    {
      for (int y = 1; y < rows-1; y++) 
      {
        // Add up all the states in a 3x3 surrounding grid
        int predNeighbors = 0;
        int preyNeighbors = 0;
        for (int i = -1; i <= 1; i++) 
        {
          for (int j = -1; j <= 1; j++) 
          {
            if (board[x+i][y+j] == 1) preyNeighbors++;
            else if (board[x+i][y+j] == 2) predNeighbors++;
          }
        }

        //Subtract the cells own state from the neighbor count
        if (board[x][y] == 1) preyNeighbors--;
        else if (board[x][y] == 2) predNeighbors--;

        // Rules for Prey
        if (board[x][y] == 1)
        {
          if (predNeighbors > 0) next[x][y] = 0; //Eaten
          else next[x][y] = board[x][y]; //Stasis
        }
        
        // Rules for Predators
        if (board[x][y] == 2)
        {
          if (predNeighbors > 2) next[x][y] = 0; //Overpopulation
          else if (preyNeighbors < 1) next[x][y] = 0; //Starvation
          else next[x][y] = board[x][y]; //Stasis
        }
        
        // Rules for Space
        if (board[x][y] == 0)
        {
          if (predNeighbors >= 2 && preyNeighbors >= 1) next[x][y] = 2; //Breed pred
          else if (preyNeighbors >= 2) next[x][y] = 1; //Breed prey
          else next[x][y] = 0;        
        }
      }
    }
    this.counter();
    preyCountArr.add(preyCount);
    predCountArr.add(predCount);
    //Change board into next in time for the next cycle
    board = next;
    generation++;
  }

  //Display the cells, called by draw() on each cycle
  void display() 
  {
    for ( int i = 0; i < columns;i++) 
    {
      for ( int j = 0; j < rows;j++) 
      {
        if ((board[i][j] == 2)) fill(127,0,0); //Pred
        else if ((board[i][j] == 1)) fill(102,102,255); //Prey
        else if ((board[i][j] == 0)) fill(255); //Blank 
        stroke(0);
        rect(i*div, j*div, div, div);
      }
    }
  }
  
  int predPreyPicker()
  {
    int rtn;
    float r = random(0,1);
    if (r < 0.05) rtn = 1; //Blue prey5%
    else if (r < 0.08) rtn = 2; //Red pred3%
    else rtn = 0; //White empty 94%
    return rtn;
  }
  
  void counter()
  {
      for (int x = 1; x < columns-1; x++) 
      {
        for (int y = 1; y < rows-1; y++) 
        {
         if (board[x][y] == 1) preyCount++;
         if (board[x][y] == 2) predCount++;  
      }
    }
  }
}
