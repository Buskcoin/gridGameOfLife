//static final int WIDTH = 500;
//static final int HEIGHT = 500;
Grid grid;
ArrayList <Block> dispell;
ArrayList <Block> revive;
ArrayList<Block> blocks;
boolean go = false;
void setup() {
  size(1000, 1000);
  grid = new Grid(width, height);
  blocks = grid.getBlocks();
  //for(Block b : blocks){
  //  if(random(4) > 3)
  //   b.setAlive(true);
  //}
  dispell = new ArrayList <Block>();
  revive = new ArrayList <Block>();
  frameRate(30);
}
int mouseClicks=0;
void draw() {
  if (mousePressed) {
    for (Block b : blocks) {
      if (isClickedOn(b)) {
        b.setAlive(true);
        b.draw();
      }
    }
    
  }
  if (go){
    run();
    }
}
boolean isClickedOn(Block b){
  return mouseX > b.getX()&& mouseX < b.getX() +10 && mouseY > b.getY() && mouseY < b.getY() +10;
}

void keyPressed(){
  if(go) 
  go = false;
  else
  go = true;
  
}

void run() {
  for (Block b : blocks) {
    b.draw();
    int neighbors = countNeighbors(b);
    if (b.isAlive()) {
      if (neighbors < 2 || neighbors > 3) {
        dispell.add(b);
      }
    } else if (neighbors == 3) {
      revive.add(b);
    }
  }
  for (Block b : dispell) {
    b.setAlive(false);
  }
  dispell = new ArrayList<Block>();
  for (Block b : revive) {
    b.setAlive(true);
  }
  revive = new ArrayList<Block>();
}

int countNeighbors(Block b) {
  ArrayList<Block> neighbors = grid.getNeighbors(b);
  int neighborCount = 0;
  for (Block neighbor : neighbors) {
    if (neighbor.isAlive()) {
      neighborCount++;
    }
  }
  return neighborCount;
}

class Grid {
  int blockWidth = 0;
  int blockHeight = 0;
  ArrayList<Block> blocks = new ArrayList<Block>();

  Grid(int w, int h) {
    blockWidth = w;
    blockHeight = h;
    int posX = 0;

    for (int x = 0; x<width; x+=Block.WIDTH) {

      int posY = 0;
      for (int y = 0; y<height; y+=Block.HEIGHT) {

        blocks.add(new Block(x, y, posX, posY));
        posY++;
      }
      posX++;
    }
  }

  ArrayList<Block> getBlocks() {
    return blocks;
  }

  ArrayList<Block> getNeighbors(Block b) {
    ArrayList<Block> neighbors = new ArrayList<Block>();
    if ((b.getPosX()+1)*100+(b.getPosY()+1) < blocks.size()-1 && (b.getPosX()-1)*100+(b.getPosY()-1) > 0) {
      neighbors.add(blocks.get((b.getPosX()+1)*100+b.getPosY()));
      neighbors.add(blocks.get(b.getPosX()*100+(b.getPosY()+1)));
      neighbors.add(blocks.get((b.getPosX()+1)*100+(b.getPosY()+1)));
      neighbors.add(blocks.get((b.getPosX()-1)*100+b.getPosY()));
      neighbors.add(blocks.get(b.getPosX()*100+(b.getPosY()-1)));
      neighbors.add(blocks.get((b.getPosX()-1)*100+(b.getPosY()-1)));
      neighbors.add(blocks.get((b.getPosX()-1)*100+(b.getPosY()+1)));
      neighbors.add(blocks.get((b.getPosX()+1)*100+(b.getPosY()-1)));
    }
    return neighbors;
  }
}

class Block {
  final static int WIDTH = 1000/100;
  final static int HEIGHT = 1000/100;
  int x;
  int y;
  int posX;
  int posY;
  boolean alive = false;
  Block(int x, int y, int posX, int posY) {
    this.x = x;
    this.y = y;
    this.posX = posX;
    this.posY = posY;
  }
  void draw() {
    noStroke();
    int rgb = 255;
    if (alive) {
      rgb = 0;
    }
    fill(rgb);
    rect(x, y, WIDTH, HEIGHT);
  }

  void setAlive(boolean alive) {
    this.alive = alive;
  }
  boolean isAlive() {
    return alive;
  }
  int getPosX() {
    return posX;
  }
  int getPosY() {
    return posY;
  }
  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
}