class Poi{
  float handX;
  float handY;
  float handInitlAng;
  float handPhaseAng;
  float handAngularV;
  float handLength;
  float handLengthAng;
  
  float ballX;
  float ballY;
  float stringInitlAng;
  float stringPhaseAng;
  float stringAngularV;
  float stringLength;
  float stringLengthAng;
  
  float radiusMod;
  
  float prevBallX;
  float prevBallY;
  
  int state;
  int style;
  int form;
  
  Poi(){
    handX = 0;
    handY = 0;
    handInitlAng = random(TWO_PI);
    handPhaseAng = handInitlAng;
    handAngularV = 0;
    handLength = 0;
    handLengthAng = random(TWO_PI);
    
    ballX = 0;
    ballY = 0;
    stringInitlAng = random(TWO_PI);
    stringPhaseAng = stringInitlAng;
    stringAngularV = 0;
    stringLength = 0;
    stringLengthAng = random(TWO_PI);
    
    radiusMod = 1;
    
    prevBallX = 0;
    prevBallY = 0;
    
    state = 0;
    style = 0;
    form = 0;
  }
  
  void setState(int stt){
    state = stt;
  }
  
  void setStyle(int stl){
    style = stl;
  }
  
  void setRadiusMod(float rmod){
    radiusMod  = rmod;
  }
  
  int getState(){
    return state;
  }
  
  float getRadiusMod(){
    return radiusMod;
  }
  
  PVector getPosition(){
    PVector p = new PVector();
    p.set(ballX, ballY);
    return p;
  }
  
  PVector getInstVelocity(){
    PVector v = new PVector();
    v.set(ballX - prevBallX, ballY - prevBallY);
    return v;
  }
  
  void move(float soundVolume){
    prevBallX = ballX;
    prevBallY = ballY;
    
    switch(style){
      case 0:
        handLength = width * 0.06;
        stringLength = width * 0.024;
      
        handAngularV = 0.3 * soundVolume;
        stringAngularV = 0.3;
        break;
      case 1:
        handLengthAng += 0.3* soundVolume;
        handLength = width * 0.06 * (0.5 + cos[int(degrees(handLengthAng))%360]);
        stringLength = width * 0.024;
      
        handAngularV = 0.3 * soundVolume;
        stringAngularV = 0.3;
        break;
      case 2:
        handLengthAng += 0.3 * soundVolume;
        handLength = 0;
        stringLength = width * 0.09 * cos[int(degrees(3*stringPhaseAng))%360];
      
        handAngularV = 0.3 * soundVolume;
        stringAngularV = 0.3 * soundVolume;
        break;
    }
    
    handPhaseAng += handAngularV;
    stringPhaseAng += stringAngularV;

    handX = handLength * cos[int(degrees(handPhaseAng))%360];//cos(handPhaseAng);//cos[int(degrees(handPhaseAng))%360];
    handY = handLength * sin[int(degrees(handPhaseAng))%360];//sin(handPhaseAng);//sin[int(degrees(handPhaseAng))%360];
    
    if(state == 1){
      radiusMod -= 0.05;
      if(radiusMod <= 0.05){
        style = int(random(3));
        state = 2;
      }
    }
    if(state == 2){
      radiusMod += 0.05;
      if(radiusMod >= 1){
        radiusMod = 1;
        state = 0;
      }
    }
    
    ballX = radiusMod * (handX + stringLength * cos[int(degrees(stringPhaseAng))%360]);//cos(stringPhaseAng);//cos[int(degrees(stringPhaseAng))%360];
    ballY = radiusMod * (handY + stringLength * sin[int(degrees(stringPhaseAng))%360]);//sin(stringPhaseAng);//sin[int(degrees(stringPhaseAng))%360];
  }
  
  void display(float soundVolumeCoeff){
    soundVolumeCoeff*=soundVolumeCoeff;
    noStroke();
    fill(255, map(soundVolumeCoeff, 0, 0.1, 16, 31));
    ellipse(ballX, ballY, 16, 16);
    fill(255, map(soundVolumeCoeff, 0, 0.1, 32, 63));
    ellipse(ballX, ballY, 8, 8);
    fill(255, map(soundVolumeCoeff, 0, 0.1, 64, 127));
    ellipse(ballX, ballY, 4, 4);
    fill(255, map(soundVolumeCoeff, 0, 0.1, 128, 255));
    ellipse(ballX, ballY, 2, 2);
  }

void reset(){
    handX = 0;
    handY = 0;
    handInitlAng = random(TWO_PI);
    handPhaseAng = handInitlAng;
    handAngularV = 0;
    handLength = 0;
    handLengthAng = random(TWO_PI);
    
    ballX = 0;
    ballY = 0;
    stringInitlAng = random(TWO_PI);
    stringPhaseAng = stringInitlAng;
    stringAngularV = 0;
    stringLength = 0;
    stringLengthAng = random(TWO_PI);
    
    radiusMod = 1;
    
    prevBallX = 0;
    prevBallY = 0;
    
    state = 0;
    style = 0;
    form = 0;
  }
}