class bird {
  PVector pos, vel, acc;
  PVector fall, jump;
  float r = 16;
  float d = r * 2;
  boolean alive = true;
  float[] inputs = new float[5];
  float score = 0;
  float fitness = 0;
  NeuralNetwork brain;

  bird() {
    pos = new PVector(64, height/2);
    vel = new PVector();
    jump = new PVector(0, 1);
    fall = new PVector(0, -1);
    score = 0;
    fitness = 0;
    brain = new NeuralNetwork(5, 64, 2);
  }

  bird(NeuralNetwork b) {
    pos = new PVector(64, height/2);
    vel = new PVector();
    jump = new PVector(0, -1);
    fall = new PVector(0, 1);
    score = 0;
    fitness = 0;
    brain = b.copy();
  }

  void mutate() {
    brain.mutate(.01);
  }

  void think(ArrayList<pipe> pipe) {
    pipe closest = null;
    float recordD = Float.POSITIVE_INFINITY;
    for (int i = 0; i < pipe.size(); i++) {
      pipe p = pipe.get(i);
      float d = (p.x+p.w) - pos.x;
      if (d < recordD && d > 0) {
        closest = pipe.get(i);
        recordD = d;
      }
    }


    inputs[0] = pos.y / height;
    inputs[1] = vel.y / 10;
    inputs[2] = closest.top / height;  
    inputs[3] = closest.bottom / width;
    inputs[4] = closest.x / width;
    float[] guess = brain.feedForward(inputs);
    if (guess[0] > guess[1]) {
      jump();
    }
    if (guess[1] > guess [0]) {
      fall();
    }
  }

  void show() {
    noStroke();
    fill(#FF4200);
    circle(pos.x, pos.y, d);
  }

  void update() {
    score++;
    //   vel.add(gravity);
    pos.add(vel);
  }

  void jump() {
    vel.add(jump);
  }

  void fall() {
    vel.add(fall);
  }

  boolean dead() {
    return (pos.y+r > height || pos.y < r);
  }
}
