//Pea class for peashooters
public class Pea {
  float x, y;
  float speed = 5;
  float size = 20;

  Pea(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    x += speed;
  }

  void display() {
    image(peaProjectile, x, y-15);
  }
}
