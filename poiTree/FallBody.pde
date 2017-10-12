class FallBody{
  PVector position;
  PVector velocity;
  float gravity;
  float groundLevel;
  int state;
  int seedValue;
  
  FallBody(float posX, float posY, float velX, float velY, float g, float grnd, int stt){
    position = new PVector();
    velocity = new PVector();
    position.set(posX, posY);
    velocity.set(velX, velY);
    
    gravity = g;
    groundLevel = grnd;
    
    state = stt;
  }
  
  PVector getPosition(){
    return position;
  }
  
  int getState(){
    return state;
  }
  
  void setPosition(float posX, float posY){
    position.set(posX, posY);
  }
  
  void setVelocity(float velX, float velY){
    velocity.set(velX, velY);
  }
  
  void setState(int stt){
    state = stt;
  }
  
  void move(){
    if(state == 2) state = 0;
    if(state == 1){
      velocity.y += gravity; 
      position.y += velocity.y;
      position.x += velocity.x;
      if(position.x >= width/2 || position.x <= -width/2){
        velocity.x *= -1;
      }
      if(position.y >= groundLevel){
        velocity.set(0,0);
        state = 2;
      }
    }
  }
  
  void display(){
    if(state == 1){
      noStroke();
      fill(255, 16);
      ellipse(position.x, position.y, 16, 16);
      fill(255, 32);
      ellipse(position.x, position.y, 8, 8);
      fill(255, 64);
      ellipse(position.x, position.y, 4, 4);
      fill(255, 128);
      ellipse(position.x, position.y, 2, 2);
    }
  }
  
  void reset(){
    position.set(0,0);
    velocity.set(0,0);
    state = 0;
  }
}