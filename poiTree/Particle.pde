class Particle{
  PVector position;
  PVector velocity;
  PVector acceleration;
  int motionState;
  int appearanceState;
  float groundLevel;
  int particleColor;
  
  Particle(){
    position = new PVector(0,0);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    motionState = 0;
    appearanceState = 0;
  }
  
  void setPosition(PVector pos){
    position.set(pos);
  }
  
  void setAppearance(int s){
    appearanceState = s;
  }
  
  void setMotion(int s){
    motionState = s;
  }
  
  void move(){
    switch(motionState){
      case 0:
        break;
      case 1:
        acceleration.y = 0.3;
        velocity.y += acceleration.y;
        position.y += velocity.y;
        if(position.y >= groundLevel + velocity.y){
          motionState = 0;
          appearanceState = 0;
          velocity.set(0,0);
        }
        break;
      /*case 2:
        velocity.x = -0.01 * position.x;
        velocity.y = -0.01 * position.y;
        position.x += velocity.x;
        position.y += velocity.y;
        if(position.magSq() <= 5){
          motionState = 0;
          velocity.set(0,0);
        }
        break;*/
    }
  }
  
  void display(){
    switch(appearanceState){
      case 0:
        break;
      case 1:
        stroke(particleColor, 200);
        strokeWeight(2);
        point(position.x, position.y);
        break;
      /*case 2:
        stroke(255, 16);
        strokeWeight(1);
        point(position.x, position.y);
        break;*/
    }
  }
  
  void reset(){
    position.set(0,0);
    velocity.set(0,0);
    acceleration.set(0,0);
    motionState = 0;
    appearanceState = 0;
  }
}