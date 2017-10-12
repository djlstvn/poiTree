class ParticleTree{
  Particle[] particles;
  int treeState = 0; //0 = idle; 1 = grow tree;  
  int branchGeneration = 0;
  int particleInBranch = 0;
  
  ParticleTree(){
    particles = new Particle[310];
    for(int i = 0; i < 310; ++i) particles[i] = new Particle();
    treeState = 0;
  }
  
  int getState(){
    return treeState;
  }
  
  void setState(int s){
    treeState = s;
  }
  
  void setGeneration(int g){
    branchGeneration = g;
  }
  
  void setPartInBranch(int p){
    particleInBranch = p;
  }
  
  void displayTree(){
    for(int index = 0; index < 310; ++index){
      particles[index].display();
    }
  }
    
  void resetAppearance(){
    for(int index = 0; index < 310; ++index){
      particles[index].setAppearance(0);
    }
  }
  
  void formBranches(int branchID, PVector iniPos, float branchLen, float branchAng, float groundLevel, int treeColor){
    if(branchID <= 30){
      int iniIndex = branchID * 10; //branchID: ID of the trunk is 0
      
      PVector displacement = PVector.fromAngle(-HALF_PI + branchAng);
      displacement.setMag(branchLen * 0.1);
      
      PVector position = iniPos;

      for(int index = iniIndex; index < iniIndex + 10; ++index){
        position.add(displacement);
        particles[index].setPosition(position);
        particles[index].groundLevel = groundLevel;
        particles[index].particleColor = treeColor;
      }
      
      displacement.setMag(0);
      formBranches(branchID*2+1, PVector.add(iniPos, displacement), branchLen * (0.5 + random(0.5)), -random(QUARTER_PI), groundLevel, treeColor);
      //why da heck can't i just use iniPos?????? actually why shouldn't i use position in the first place???
      formBranches(branchID*2+2, PVector.add(iniPos, displacement), branchLen * (0.5 + random(0.5)), random(QUARTER_PI), groundLevel, treeColor);
    }
  }
  
  void changeTree(){
    int branchesInGen = 0;
    int index = 0;
    
    switch(treeState){
      case 0:
        break;
      case 1:
        if(random(2)>1){
          branchesInGen = int(pow(2, branchGeneration));
          for(int i = 0; i < branchesInGen; ++i){
            index = (branchesInGen - 1 + i) * 10 + particleInBranch;
            particles[index].setAppearance(1);
          }
          
          ++particleInBranch;
          if(particleInBranch == 10){
            particleInBranch = 0;
            ++branchGeneration;
          }
          if(branchGeneration == 5){
            treeState = 2;
          }
        }
        break;
      case 3:
        if(random(5)>4){
          branchesInGen = int(pow(2, branchGeneration));
          for(int i = branchesInGen - 1; i >= 0; --i){
            index = (branchesInGen - 1 + i) * 10 + particleInBranch;
            particles[index].setMotion(1);
  
          }
          --particleInBranch;
          if(particleInBranch < 0){
            particleInBranch = 9;
            --branchGeneration;
          }
          if(branchGeneration < 0){
            treeState = 0;
          }
        }
        break;
      /*case 4:
        if(random(5)>4){
          branchesInGen = int(pow(2, branchGeneration));
          for(int i = branchesInGen - 1; i >= 0; --i){
            index = (branchesInGen - 1 + i) * 10 + particleInBranch;
            particles[index].setMotion(2);
  
          }
          --particleInBranch;
          if(particleInBranch < 0){
            particleInBranch = 9;
            --branchGeneration;
          }
          if(branchGeneration < 0){
            treeState = 5;
          }
        }*/
    }
    
    for(index = 0; index < 310; ++index){
      particles[index].move();
    }
  }

  void reset(){
    for(Particle p : particles) p.reset();
    treeState = 0; 
    branchGeneration = 0;
    particleInBranch = 0;
  }

}