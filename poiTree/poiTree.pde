import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;

Poi poi;
FallBody fallBody;
ParticleTree[] particleTrees;

float[] cos;
float[] sin;

int songID;
int rotationCount = 0;
float soundVolume;
PVector vectorBuffer;
int rotationCountBuffer = 0;
int treeTracker = 0;
int treeCounter = 0;
int groundLevelDice = 0;
float waveRingX = 0;
float waveRingY = 0;
float waveRingAng = 0;

void setup(){
  size(435, 870); //fullScreen();
  frameRate(45);
  background(0);
  smooth();
  
  minim = new Minim(this); //to enable loading files from local directory
  song = minim.loadFile("dlig.mp3", 1024);
  songID = int(random(5));
    
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(10000);
  bl = new BeatListener(beat, song);
  
  song.play();
  
  poi = new Poi();
  
  fallBody = new FallBody(0,0,0,0, 0.3, height*0.95 - width/2, 0);
  
  particleTrees = new ParticleTree[11];
  for(int i = 0; i<11; ++i){
    particleTrees[i] = new ParticleTree();
  }

  cos = new float[360];
  sin = new float[360];
  for(int i = 0; i<360; ++i){
    cos[i] = cos(radians(i));
    sin[i] = sin(radians(i));
  }
}

void draw(){  
  noStroke();
  fill(0, 20);
  rect(0, 0, width, height);
  
  strokeWeight(2);
  int hInc = int(height * 0.005);
  int wInc = 4;
  int groundColor = 16;
  for(int h = int(height * 0.85); h <= height; h += hInc){
    stroke(groundColor, 40);
    for(int w = 0; w <= width; w += wInc)
      point(w, h);
    wInc+=2;
    groundColor += 25;
    println(groundColor);
    hInc *= 1.3;
  };
  //noStroke();
  /*fill(32, 40);
  rect(0, height*0.85, width, height * 0.01);
  fill(48, 40);
  rect(0, height*0.86, width, height * 0.02);
  fill(80, 40);
  rect(0, height*0.88, width, height * 0.04);
  fill(144, 40);
  rect(0, height*0.92, width, height * 0.09);*/
  
  soundVolume = (song.left.level()+song.right.level())*0.5;
  //println(soundVolume);
  
  pushMatrix();
    translate(width/2, width/2);
    
    pushMatrix();
      if(rotationCount++ >= 360) rotationCount = 0;
      rotate(radians(rotationCount));
      
      poi.move(soundVolume);
      poi.display(soundVolume);

      if(beat.isHat() && fallBody.getState() == 0 && treeCounter < 11){  
        poi.setState(1);
      }
      if(poi.getState() == 2 && poi.getRadiusMod() <= 0.15){
        fallBody.setState(1);
        fallBody.setPosition(0,0);
        fallBody.setVelocity(poi.getInstVelocity().x, poi.getInstVelocity().y);
        groundLevelDice = int(random(4));
        switch(groundLevelDice){
          case 0:
            fallBody.groundLevel = height*0.92 - width/2;
            fallBody.seedValue = 4;
            break;
          case 1:
            fallBody.groundLevel = height*0.88 - width/2;
            fallBody.seedValue = 3;
            break;
          case 2:
            fallBody.groundLevel = height*0.86 - width/2;
            fallBody.seedValue = 2;
            break;
          case 3:
            fallBody.groundLevel = height*0.85 - width/2;
            fallBody.seedValue = 1;
            break;
        }
      }
    popMatrix();
    
    if(fallBody.getState() == 2){
      vectorBuffer = fallBody.getPosition();
      for(int i = 0; i < particleTrees.length; ++i){
        if(particleTrees[i].getState() == 0){
          particleTrees[i].resetAppearance();
          particleTrees[i].formBranches(0, vectorBuffer, random(height/40) + height/20 + height/100*fallBody.seedValue, 0f, fallBody.groundLevel, fallBody.seedValue * 50);
          particleTrees[i].setState(1);
          particleTrees[i].setGeneration(0);
          particleTrees[i].setPartInBranch(0);
          break;
        }
      }
    }
    fallBody.move();
    fallBody.display();
    
    treeCounter = 0;
    for(int i = particleTrees.length - 1; i >= 0; --i){
      if(particleTrees[i].getState() == 2){
        ++treeCounter;
      }
     
      particleTrees[i].changeTree();
      particleTrees[i].displayTree();
    }
    
    if(treeCounter >= 8){
      if(soundVolume > 0.25){
        for(ParticleTree pt: particleTrees){
          if(pt.getState() == 2){
            pt.setState(3);
            pt.setGeneration(4);
            pt.setPartInBranch(9);
          }
        }
      }
      else{
        treeTracker = int(random(11));
        while(particleTrees[treeTracker].getState() != 2) treeTracker = int(random(11));  
        particleTrees[treeTracker].setState(3);
        particleTrees[treeTracker].setGeneration(4);
        particleTrees[treeTracker].setPartInBranch(9);
      }
    }
       
    pushMatrix();
      for(int i = 0; i < song.bufferSize() - 1; i+=2){
        waveRingAng = map(i, 0, song.bufferSize(), 0, 360);
        waveRingX = (width/4 + (width/10)*song.left.get(i)) * cos[int(radians(waveRingAng))];
        waveRingY = (width/4 + (width/10)*song.left.get(i)) * sin[int(radians(waveRingAng))];
        stroke(255, 64);
        strokeWeight(2);
    
        rotate(radians(waveRingAng));
        point(waveRingX, waveRingY);
      }
    popMatrix();
  popMatrix();
}

void mousePressed(){
  poi.reset();
  for(ParticleTree pt: particleTrees) pt.reset();
  fallBody.reset();
  /*
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(10000);

  bl = new BeatListener(beat, song);*/
  
  song.rewind(); 
  song.play();
  background(0);
}