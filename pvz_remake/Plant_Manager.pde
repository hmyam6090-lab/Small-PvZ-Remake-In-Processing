//Plant Manager that handles peashooters, sunflowers, and wallnuts (which havent been implemented yet!)
class Plant {
  String currentPlant;
  int x, y;
  int hp;
  int sunCost;
  Timer sunflowerTimer = new Timer(7000);
  Timer peashooterTimer = new Timer(4000);
  Timer eatTimer = new Timer(500);

  Plant(String currentPlant, int x, int y) {
    this.currentPlant = currentPlant;
    this.x = lawnX + 50 + round((x - lawnX) / cellSize) * cellSize;
    this.y = lawnY + 50 + round((y - lawnY) / cellSize) * cellSize;
    
    switch (currentPlant) {
      case "Peashooter":
        this.hp = 25;
        break;
      case "Sunflower":
        this.hp = 50;
        break;
      case "Wallnut":
        this.hp = 300;
        break;
    }
  }

  void update() {
    if (currentPlant.equals("Sunflower")) produceSun();
    if (currentPlant.equals("Peashooter")) shootPea();  
  }
  
  void shootPea() {
    if (peashooterTimer.isReady()) {
      peas.add(new Pea(x + 25, y - 20));  
    }
  }
  
  void produceSun() {
    if (sunflowerTimer.isReady()) {
      suns.add(new Sun(x, y - 40));
    }
  }

  void display() {
    if (currentPlant.equals("Sunflower")) {
      image(sunflowerAnimation, x - 35, y - 35, 75, 75);
    } else if (currentPlant.equals("Peashooter")) {
      image(peashooterAnimation, x - 50, y - 65, 110, 110);
    }
  }
  
  void beingEaten() {
    if (eatTimer.isReady()) {
      hp -= 25;
    }
  } 
  
  int getCol() {
    return (x - lawnX) / cellSize;
  }

  int getRow() {
    return (y - lawnY) / cellSize;
  }
}
