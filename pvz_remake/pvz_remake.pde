//This project is my most ambitious yet because this game is my favourite childhood game and a big part of my childhood so I hope to do it justice!! 

//libraries 
import processing.sound.*;
import gifAnimation.*;
//------------GLOBALS-------------//
//Music
SoundFile bgMusic;

//Sun Count to plant
int sunCount = 100;
int sunCost = 50;
PImage sun;

//Colors
color lawnOdd = #1FDB3F;
color lawnEven = #10C12E;
color peashooterColor = #46F063;
color sunflowerColor = #FFD500;
color zombieColor = #8B00FF;

PImage lawnBg;

//Peashooter Variables
PImage peashooter;
PImage peaProjectile;
Gif peashooterAnimation;
ArrayList<Pea> peas = new ArrayList<Pea>();

//Sunflower Variables
PImage sunflower;
Gif sunflowerAnimation;
ArrayList<Sun> suns = new ArrayList<Sun>();

//Plant mechanics Variables
ArrayList<Plant> plants = new ArrayList<Plant>();
String currentPlant = "Sunflower";

//Zombie Variables
PImage zombie;
Gif zombieWalk;
ArrayList<Zombie> zombies = new ArrayList<Zombie>();
Timer zombieTimer = new Timer(10000);

//Lawn + UI
int lawnX = 200;          
int lawnY = 150;          
int lawnCols = 9;        
int lawnRows = 5;        
int cellSize = 100;      
boolean[][] occupied = new boolean[lawnCols][lawnRows]; 

PFont funnyfont;
PImage seedUI;
int plantUIY = 50;        
int plantUICardSize = 60; 
int plantUICardSpacing = 10;
//----------------------------------//

void setup() {
  size(1200, 700, P2D);
  
  bgMusic = new SoundFile(this, "pvztheme.mp3");
  bgMusic.play();
  
  //Loading Sprites
  lawnBg = loadImage("pvzlawn.png");
  seedUI = loadImage("seedUI.png");
  sun = loadImage("Sun.png");
  funnyfont = createFont("comicsans.ttf", 12);
  
  zombie = loadImage("zombie.png");
  zombieWalk = new Gif(this, "zombieWalk1.gif");
  zombieWalk.play();
  
  peashooter = loadImage("peashooterSeed.png");
  peaProjectile = loadImage("ProjectilePea.png");
  peashooterAnimation = new Gif(this, "peashooter.gif");
  peashooterAnimation.play();
  
  sunflower = loadImage("sunflowerSeed.png");
  sunflowerAnimation = new Gif(this, "sunflower.gif");
  sunflowerAnimation.play();
}

void draw() {
  background(135, 206, 235);
  image(lawnBg, -80, -70, 1650, 800);
 
  //UI Panel
  drawPlantSelectionUI();
  
  //Plants Loop
  for (int i = plants.size() - 1; i >= 0; i--) {
    Plant pl = plants.get(i);
    pl.update();
    pl.display();
  }
  
  for (Sun s : suns) {
    s.update();
    s.display();
    s.checkHover();
  }
  
  for (int i = suns.size() - 1; i >= 0; i--) {
    if (suns.get(i).collected) suns.remove(i);
  }

  //Zombies Loop
  for (int i = zombies.size() - 1; i >= 0; i--) {
    Zombie z = zombies.get(i);
    z.update();
    z.display();
    
    for (int j = plants.size() - 1; j >= 0; j--) {
      Plant pl = plants.get(j);
      
      if (checkCollision(pl.x, pl.y, 40, z.x, z.y, 30)) {
        if (plants.get(j).hp < 0) {
            //FREE TILES UP WHEN PLANT DIES
            int col = plants.get(j).getCol();
            int row = plants.get(j).getRow();
            occupied[col][row] = false;
            
            //KILL THE PLANT
            plants.remove(j); 
            zombies.get(i).speed = 1;
        }
        else {
          plants.get(j).beingEaten();
          zombies.get(i).speed = 0;
        }
      }
    }
  }
  
  
  //Peas Loop
  for (int i = peas.size() - 1; i >= 0; i--) {
    Pea p = peas.get(i);
    p.update();
    p.display();

    for (int j = zombies.size() - 1; j >= 0; j--) {
      Zombie z = zombies.get(j);
      if (checkCollision(p.x, p.y, p.size/2, z.x, z.y, 30)) { 
        peas.remove(i);
        if (zombies.get(j).hp < 0) zombies.remove(j);
        else zombies.get(j).hp -= 20;
        break;
      }
    }

    // Remove peas that go off-screen
    if (p.x > width) {
      peas.remove(i);
    }
  }
  
  if (zombieTimer.isReady()) {
   int yRow = lawnY + 50 + (int(random(lawnRows)) * cellSize);
   zombies.add(new Zombie((int) random(1, 4), lawnX + lawnCols*cellSize + 50, yRow, 1));
  }
}

//Function to check collision
boolean checkCollision(float x1, float y1, float r1, float x2, float y2, float r2) {
  float d = dist(x1, y1, x2, y2);
  return d < (r1 + r2);
}


//Little rectangle at the top to select seed packs
void drawPlantSelectionUI() {
  int x = lawnX;
  int y = plantUIY;

  fill(#F7E891);
  stroke(0);
  image(seedUI, 135, 55);
  rect(144, 115, 55, 22);
  fill(0);
  textFont(funnyfont);
  text(sunCount, 163, 130);
  
  fill(255);
  image(sunflower, x + plantUICardSpacing, y + 10, plantUICardSize-5, plantUICardSize+15);
  image(peashooter, x + plantUICardSize+5, y + 10, plantUICardSize-5, plantUICardSize+15);

  noFill();
  stroke(255, 255, 0);
  strokeWeight(3);
  if (currentPlant.equals("Sunflower")) {
    rect(x + plantUICardSpacing-2, y + 8, plantUICardSize-5, plantUICardSize+15, 8);
  } else {
    rect(x + plantUICardSize+5, y + 8, plantUICardSize-5, plantUICardSize+15, 8);
  }
  strokeWeight(1);
}

void mousePressed() {
  if (mouseY >= plantUIY + 10 && mouseY <= plantUIY + 10 + plantUICardSize) {
    if (mouseX >= lawnX + plantUICardSpacing && mouseX <= lawnX + plantUICardSpacing + plantUICardSize) {
      currentPlant = "Sunflower";
    }
    if (mouseX >= lawnX + plantUICardSpacing*1.5 + plantUICardSize && mouseX <= lawnX + plantUICardSpacing*1.5 + plantUICardSize*1.5) {
      currentPlant = "Peashooter";
    }
  }

  switch (currentPlant) {
      case "Peashooter":
        sunCost = 100;
        break;
      case "Sunflower":
        sunCost = 50;
        break;
      case "Wallnut":
        sunCost = 100;
        break;
  }

  int col = (mouseX - lawnX) / cellSize;
  int row = (mouseY - lawnY) / cellSize;
  if (col >= 0 && col < lawnCols && row >= 0 && row < lawnRows) {
    if (!occupied[col][row]) {
      if (sunCount >= sunCost) {
        sunCount -= sunCost;
        plants.add(new Plant(currentPlant, lawnX + col * cellSize, lawnY + row * cellSize));
        occupied[col][row] = true;
      }
    } else {
      println("Tile already occupied!");
    }
  }
  
  for (Sun s : suns) {
    s.checkHover();
  }
}
