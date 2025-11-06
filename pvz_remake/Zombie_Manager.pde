//ZOMBIE MANAGER, Difficulty variable decides health of zombie and is random
public class Zombie {
  int difficulty;
  int x;
  int y;
  int hp;
  int speed;

  public Zombie(int difficulty, int x, int y, int speed) {
    this.difficulty = difficulty;
    this.x = x;
    this.y = y;
    this.speed = speed;
    
    if (difficulty == 1) this.hp = 50;
    else if (difficulty == 2) this.hp = 100;
    else if (difficulty == 3) this.hp = 150;
    else this.hp = 300;
  }

  void update() {
    x -= 1*speed;
  }

  void display() {
    image(zombieWalk, x-30, y-70, 80, 120);
  }
}
