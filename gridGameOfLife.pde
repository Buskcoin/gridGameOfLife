//static final int WIDTH = 500;
//static final int HEIGHT = 500;
  Grid grid;
void setup(){
  size(500,500);
grid = new Grid(width, height);
}
void draw(){
  ArrayList<Block> blocks = grid.getBlocks();
  for(Block b: blocks){
    b.draw();
  }
  blocks = grid.getNeighbors(blocks.get(15));
  for(Block b: blocks){
    b.setAlive(true);
  }
}

class Grid{
int blockWidth = 0;
 int blockHeight = 0;
  ArrayList<Block> blocks = new ArrayList<Block>();
  
  Grid(int w, int h){
    blockWidth = w;
    blockHeight = h;
    int posX = 0;

  for(int x = 0; x<width; x+=Block.WIDTH){
    posX++;
    int posY = 0;
    for(int y = 0; y<height; y+=Block.HEIGHT){
      posY++; 
      blocks.add(new Block(x,y,posX, posY));
     }
  }
  }
  
  ArrayList<Block> getBlocks(){
   return blocks;
  }
  
  ArrayList<Block> getNeighbors(Block b){
    ArrayList<Block> neighbors = new ArrayList<Block>();
    neighbors.add(blocks.get((b.getPosX()+1)*b.getPosY()));
     neighbors.add(blocks.get(b.getPosX()*(b.getPosY()+1)));
      neighbors.add(blocks.get((b.getPosX()+1)*(b.getPosY()+1)));
       neighbors.add(blocks.get((b.getPosX()-1)*b.getPosY()));
        neighbors.add(blocks.get(b.getPosX()*(b.getPosY()-1)));
         neighbors.add(blocks.get((b.getPosX()-1)*(b.getPosY()-1)));
    return neighbors;
  }
}

class Block{
 final static int WIDTH = 500/9;
 final static int HEIGHT = 500/9;
 int x;
 int y;
 int posX;
 int posY;
 boolean alive = false;
 Block(int x, int y, int posX, int posY){
   this.x = x;
   this.y = y;
   this.posX = posX;
   this.posY = posY;
 }
 void draw(){
   noStroke();
   int rgb = 255;
   if(alive){
     rgb = 0;
   }
   fill(rgb);
   rect(x,y,WIDTH,HEIGHT);
 }
 
 void setAlive(boolean alive){
   this.alive = alive; 
 }
 boolean isAlive(){
   return alive;
 }
 int getPosX(){
   return posX;
 }
 int getPosY(){
   return posY;
 }

}