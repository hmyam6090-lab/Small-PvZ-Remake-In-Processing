//Sun class for the sunflower
class Sun {
  float x, y;
  float fallSpeed = 1.5;
  boolean collected = false;
  boolean landed = false;
  float targetY; // where the sun stops falling

  Sun(float startX, float startY) {
    x = startX;
    y = startY;
    targetY = y + random(50, 100); // how far it falls from the sunflower
  }

  void update() {
    if (!landed) {
      y += fallSpeed;
      if (y >= targetY) {
        landed = true;
      }
    }
  }

  void display() {
    if (!collected) {
      image(sun, x - 25, y - 25, 75, 75);
    }
  }


  //CHECK IF MOUSE IS HOVERED OVER THE SUN TO COLLECT IT
  void checkHover() {
    if (!collected && dist(mouseX, mouseY, x, y) < 25) {
      collected = true;
      sunCount += 25;  // now add to sunCount when collected
    }
  }
}
