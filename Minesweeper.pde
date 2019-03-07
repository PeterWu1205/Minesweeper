

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i < NUM_ROWS; i++)
    {
        for (int j = 0; j < NUM_COLS; j++)
        {
            buttons[i][j] = new MSButton(i,j);
        }
    }
    
    
    
    setBombs();
}
public void setBombs()
{
    int row = (int)(Math.random()* NUM_ROWS);
    int col = (int)(Math.random()* NUM_COLS);
    for (int i = 0; i < NUM_ROWS; i++)
    {
        for (int j = 0; j < NUM_COLS; j++)
        {
            if (!bombs.contains(buttons[row][col]))
            {
                bombs.add(buttons[row][col]);
                System.out.println(row + "," + col);
            }
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
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

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed() 
    {
        clicked = true;
        if (mouseButton == RIGHT)
        {
            marked = !marked;
            if(marked == false)
            {
                clicked = false;
            }
        }
        else if (bombs.contains(buttons[r][c]))
        {
            displayLosingMessage();
        }
        else if (countBombs(r,c) > 0)
        {
            setLabel(" "+countBombs(r,c));
        }
        else
        {
            for (int i = r -1; i <= r+1 ; i++)
            {
                for (int j = c-1; j <= c+1; j++)
                {
                    if ((isValid(i,j) == true) && (buttons[i][j].isClicked() == false))
                    {
                        buttons[i][j].mousePressed();
                    }
                }
            }
        }
    }


    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if ((r > -1) && (c > -1) && (r < NUM_ROWS) && (c < NUM_COLS))
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for (int i = row -1; i <= row +1 ; i++)
        {
            for (int j = col -1; j <= col +1 ; j++)
            {
                if ((isValid(row,col) == true) && (bombs.contains(buttons[row][col])))
                {
                    numBombs++;
                }
            }
        }
        return numBombs;
    }
}



