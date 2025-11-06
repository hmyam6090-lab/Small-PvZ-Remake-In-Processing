//A looping game timer class to decide intervals of zombie spawning, peashooters shooting, and sun production
class Timer {
  int interval;
  int lastTime;

  Timer(int interval) {
    this.interval = interval;
    lastTime = millis();
  }

  boolean isReady() {
    if (millis() - lastTime >= interval) {
      lastTime = millis();
      return true;
    }
    return false;
  }
}
