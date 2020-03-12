import de.bezier.guido.*;
private int NUM_ROWS = 5; 
private int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
public ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{

    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    mines = new ArrayList <MSButton>();
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    
    //your code to initialize buttons goes here
    //buttons = new MSButton[NUM_ROWS][NUM_COLS];
    buttons = fill2D(buttons);
    setMines();
}

public void setMines()
{
    
    while(mines.size() < NUM_ROWS){
        int r = (int)(Math.random()*NUM_ROWS);
        int c = (int)(Math.random()*NUM_COLS);
        if(!mines.contains(buttons[r][c])){
            mines.add(buttons[r][c]);
            System.out.println(r+"," +c);
        }
    }
    
    
    
    
}


public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int row, int col)
{
    if(row>NUM_ROWS||col>NUM_COLS){
    return false;
  }else if(row<0||col<0){
    return false;
  } 
  return true;
}
public int countMines(int row, int col, ArrayList mines)
{
    int total = 0;
      //top left 1
      if(isValid(row-1,col-1)==true&&mines.contains(buttons[row][col])){
        total = total + 1;
        
      //top middle 2
      }if(isValid(row-1,col)==true&&mines.contains(buttons[row][col])){
        total = total + 1;
        
      //top right 3
      }if(isValid(row-1,col+1)==true&&mines.contains(buttons[row][col])){
        total = total + 1;
        
      //middle left 4
      }if(isValid(row,col-1)==true&&mines.contains(buttons[row][col])){
        total = total + 1;
        
      //middle right 5
      }if(isValid(row,col+1)==true&&mines.contains(buttons[row][col])){
        total = total + 1;
        
      //bottom left 6
      }if(isValid(row+1,col-1)==true&&mines.contains(buttons[row][col])){
        total = total + 1;
      
      //bottom middle 7
      }if(isValid(row+1,col)==true&&mines.contains(buttons[row][col])){
        total = total + 1;
      
      //bottom right 8
      }if(isValid(row+1,col+1)==true&&mines.contains(buttons[row][col])){
        total = total + 1;
      }
  
    return total;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT && flagged == true){
            clicked = false;
            flagged = false;
        }else if(mouseButton == RIGHT && flagged == false){
            flagged = true;
        }else if(mines.contains(this)){
            displayLosingMessage();
        }else if(countMines(myRow,myCol,mines)>0){
            setLabel(String.valueOf(countMines(myRow,myCol,mines)));
            System.out.println(countMines(myRow,myCol,mines));
        }else{
            superPress(myRow-1,myCol-1,buttons);
            superPress(myRow-1,myCol+1,buttons);
            superPress(myRow-1,myCol,buttons);
            superPress(myRow,myCol-1,buttons);
            superPress(myRow,myCol+1,buttons);
            superPress(myRow+1,myCol-1,buttons);
            superPress(myRow+1,myCol+1,buttons);
            superPress(myRow+1,myCol,buttons);
            
            
        }
        //your code here
    }
    public void draw () 
    {
        System.out.println(mines);    
        if (flagged)
            fill(0);
         else if(clicked && mines.contains(this) ){
            fill(255,0,0);
            
        }
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public void superPress(int row, int col, MSButton[][] button){
        if(isValid(row,col)==true&&!mines.contains(buttons[row][col])){
            buttons[row][col].mousePressed();
        }
    }
}


public MSButton[][] fill2D(MSButton[][] vals){
  MSButton[][] newvals = new MSButton[vals.length][vals[0].length];
   for(int i=0;i<vals.length;i++)
      for(int j=0;j<vals[i].length;j++)
        newvals[i][j]=new MSButton(i,j);
    return newvals;
}
/*

*/

/*
            if(isValid(myRow,myCol-1) && !mines.contains(buttons[myRow][myCol-1])){
                buttons[myRow][myCol-1].mousePressed();
            }
            if(isValid(myRow-1,myCol-1)==true&&!mines.contains(buttons[myRow-1][myCol-1])){
                buttons[myRow-1][myCol-1].mousePressed();
            //top middle 2
            }
            if(isValid(myRow-1,myCol)==true&&!mines.contains(buttons[myRow-1][myCol])){
                buttons[myRow-1][myCol].mousePressed();

            //top right 3
            }
            if(isValid(myRow-1,myCol+1)==true&&!mines.contains(buttons[myRow-1][myCol+1])){
                buttons[myRow-1][myCol+1].mousePressed();

            //middle left 4
            }
            if(isValid(myRow,myCol-1)==true&&!mines.contains(buttons[myRow][myCol-1])){
                buttons[myRow][myCol-1].mousePressed();

            //middle right 5
            }
            if(isValid(myRow,myCol+1)==true&&!mines.contains(buttons[myRow][myCol+1])){
                buttons[myRow][myCol+1].mousePressed();

            //bottom left 6
            }
            if(isValid(myRow+1,myCol-1)==true&&!mines.contains(buttons[myRow+1][myCol-1])){
                buttons[myRow+1][myCol-1].mousePressed();

            //bottom middle 7
            }
            if(isValid(myRow+1,myCol)==true&&!mines.contains(buttons[myRow+1][myCol])){
                buttons[myRow+1][myCol].mousePressed();

            //bottom right 8
            }
            if(isValid(myRow+1,myCol+1)==true&&!mines.contains(buttons[myRow+1][myCol+1])){
                buttons[myRow+1][myCol+1].mousePressed();

            }
            */