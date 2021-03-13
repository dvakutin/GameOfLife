import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20; //mark constants with capital letters
public final static int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program


public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );
  buttons = new Life[NUM_ROWS][NUM_COLS]; //creates a 2d array that is empty
  //your code to initialize buttons goes here
  for(int r = 0; r < NUM_ROWS; r++) //initializes rows
  {
    for(int c = 0; c < NUM_COLS; c++) //initializes columns
    {
      buttons[r][c] = new Life(r, c);
    }
  }
  //your code to initialize buffer goes here
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  for(int r = 0; r < NUM_ROWS; r++)
  {
    for(int c = 0; c < NUM_COLS; c++)
    {
      buffer[r][c] = true;
    }
  }
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for(int r = 0; r < NUM_ROWS; r++)
    for(int c = 0; c < NUM_COLS; c++)
    {
      if(countNeighbors(r, c) == 3)
      {
        buffer[r][c] = true;
      }
      else if(countNeighbors(r, c) == 2 && buttons[r][c].getLife() == true)
      {
        buffer[r][c] = true;
      }
      else
      {
        buffer[r][c] = false;
      }
      buttons[r][c].draw();
    }
  copyFromBufferToButtons();
}

public void keyPressed() {
  if(key == ' ')
  {
    running = !running;
  }
}

public void copyFromBufferToButtons() {
  for(int r = 0; r < NUM_ROWS; r++)
  {
    for(int c = 0; c < NUM_COLS; c++)
    {
      if(buffer[r][c] == true)
        {
          buttons[r][c].setLife(true);
        }
        else
        {
          buttons[r][c].setLife(false);
        }
        buttons[r][c].draw();
    }
  }
}

public void copyFromButtonsToBuffer() {
  for(int r = 0; r < NUM_ROWS; r++)
  {
    for(int c = 0; c < NUM_COLS; c++)
    {
      if(buttons[r][c].getLife() == true)
      {
        buffer[r][c] = true;
      }
      else
      {
        buffer[r][c] = false;
      }
    }
  }
}

public boolean isValid(int r, int c) {
  if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
  {
    return true;
  }
  return false;
}

public int countNeighbors(int row, int col) {
  int numneg = 0;
    if(isValid(row, col) == true)
  {
    if(isValid(row - 1, col - 1) && buffer[row - 1][col - 1] == true)
    {
      numneg++;
    }
    if(isValid(row - 1, col) && buffer[row - 1][col] == true)
    {
      numneg++;
    }
    if(isValid(row - 1, col + 1) && buffer[row - 1][col + 1] == true)
    {
      numneg++;
    }  
    if(isValid(row, col - 1) && buffer[row][col - 1] == true)
    {
      numneg++;
    }
    if(isValid(row, col + 1) && buffer[row][col + 1] == true)
    {
      numneg++;
    }
    if(isValid(row + 1, col - 1) && buffer[row + 1][col - 1] == true)
    {
      numneg++;
    }
    if(isValid(row + 1, col) && buffer[row + 1][col] == true)
    {
      numneg++;
    }
    if(isValid(row + 1, col + 1) && buffer[row + 1][col + 1] == true)
    {
      numneg++;
    }
  }
  return numneg;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;
  private int colo;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    colo = 150;
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
    colo = color(21, 160, 253);
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill(colo);
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code -- completed!
    return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
