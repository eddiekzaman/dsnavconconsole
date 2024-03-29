/*-----------------------------------------------------------------------------*/
void DefineMainGrid ()
{
   DefineGrid(MainGridMinX, MainGridMaxX, MainGridMinY, MainGridMaxY, MainGridXstep, 
               MainGridYstep, MainGridXstepSmall, MainGridYstepSmall, MainGridFlag);
   Grid = get(Z(57),Z(21),Z(751),Z(751));
}

/*-----------------------------------------------------------------------------*/
void DefineDetailsGrid ()
{
  int ii;
  int MaxInd;
  
  DefineGrid(DetailGridMinX, DetailGridMaxX, DetailGridMinY, DetailGridMaxY, 
               DetailGridXstep, DetailGridYstep, DetailGridXstepSmall, 
               DetailGridYstepSmall, DetailGridFlag);
               
   Yk = Yk/2;
   
/*  // When scale changes, the plot buffer is flushed
  for (ii=1; ii< MaxSpeedData; ii++)
  {
    Speed1 [ii] = 0;
  }
  
     for (ii=1; ii< MaxSpeedData; ii++)
  {
    Speed2 [ii] = 0;
  }
*/

/*  //////////////// Debug
  if (Step >= 1)
  {
     MaxInd = (int)(MaxSpeedData/Step);
  }
  else
  {
    MaxInd = MaxSpeedData;
  }

  for (ii=1; ii< (MaxInd); ii++)
  {
    Speed1 [ii] = ((int) (sin(radians(ii))*(400)))*Yoffset/MaxYvalue;
  }
  
     for (ii=1; ii< MaxInd; ii++)
  {
    Speed2 [ii] = ((int) (cos(radians(ii))*(400)))*Yoffset/MaxYvalue;
  }
  //////////////// Debug */
}

/*-----------------------------------------------------------------------------*/
void DefineGrid(int MinX, int MaxX, int MinY, int MaxY, int Xstep, int Ystep, 
                int XstepSmall, int YstepSmall, int Flag)
{
  int ind;
  float GridStepX = (float)(Xsize)/(float)(Xstep);
  float GridStepY = (float)(Ysize)/(float)(Ystep);
  float GridStepXsmall = (float)(Xsize)/(float)(XstepSmall);
  float GridStepYsmall = (float)(Ysize)/(float)(YstepSmall);
  int ScaleXstep = (MaxX-MinX)/Xstep;
  int ScaleYstep = (MaxY-MinY)/Ystep;
    
  Xk = (float)Xsize / (float)(MaxX-MinX);
  Yk = (float)Ysize / (float)(MaxY-MinY);
  Xkofst = (0 - MinX) * Xk;
  Ykofst = (0 - MinY) * Yk;
  float Step1tmp = (((float)(MaxSpeedData)) / ((float)(MaxX-MinX)));
  float Step2tmp = (float)(CyclePeriod)/1000;
  Step = (Step1tmp*Step2tmp);
  pushMatrix();
  translate(RelX0,RelY0);
  rotate(-HALF_PI);
  fill(0,0,0);
  stroke(200,200,200);
  strokeWeight(5);
  rect(0, 0, Xsize, Ysize);
  strokeWeight(1);
  stroke(255,255,255);
  // rotating system switches X with Y
  textAlign(CENTER);
  fill(255,255,255);
  
  rotate(HALF_PI);
  for (ind=0; ind <= Xstep; ind++)
  {
     text(MinX+(ScaleXstep*ind), (ind*GridStepX), Z(20));
  }
  
  Xscale = get(Z(30), Z(775), Z(800), Z(20));
  
  textAlign(RIGHT);
  if (Flag==3)
  { 
    for (ind=1; ind <= Ystep/2-1; ind++)
    {
       text(MinY+(ScaleYstep*2*ind), -5, -(ind*GridStepY-5));
    }
    
    for (ind=1; ind <= Ystep/2-1; ind++)
    {
       text(MinY+(ScaleYstep*2*ind), -5, -((ind+Ystep/2)*GridStepY-5));
    }
  }
  else
  {
    for (ind=0; ind <= Ystep; ind++)
    {
       text(MinY+(ScaleYstep*ind), -5, -(ind*GridStepY-5));
    }
  }
  Yscale = get(Z(10),Z(10),Z(45),Z(770));

  rotate(PI);
  rotate(HALF_PI);
  for (ind=1; ind < Ystep; ind++)
  {
     line( (int)(ind*GridStepY), 3, (int)(ind*GridStepY), Xsize-3);
  }
  
  for (ind=1; ind < Xstep; ind++)
  {
     line( 3, (int)(ind*GridStepX), Ysize-3, (int)(ind*GridStepX));
  }
  
  for (ind=1; ind < YstepSmall; ind++)
  {
     line( (int)(ind*GridStepYsmall), Xkofst-5, (int)(ind*GridStepYsmall), Xkofst+5);
  }
  
  for (ind=1; ind < XstepSmall; ind++)
  {
     line( Ykofst-5, (int)(ind*GridStepXsmall), Ykofst+5, (int)(ind*GridStepXsmall));
  }

  if (Flag == 3)
  {
     for (ind=1; ind < XstepSmall; ind++)
     {
       line( Ysize/4-5, (int)(ind*GridStepXsmall), Ysize/4+5, (int)(ind*GridStepXsmall));
       line( Ysize-Ysize/4-5, (int)(ind*GridStepXsmall), Ysize-Ysize/4+5, (int)(ind*GridStepXsmall));
     }
  } 
  popMatrix();
}

/*-----------------------------------------------------------------------------*/
float XGraph(float X)
{
  float Xnew;
  Xnew = (float)(X * Xk + Xkofst); 
  return Xnew;
}

/*-----------------------------------------------------------------------------*/
float YGraph(float Y)
{
  float Ynew;
  Ynew = (float)(Y * Yk + Ykofst);
  return Ynew;
}

/*-----------------------------------------------------------------------------*/
void MyLine (float X0, float Y0, float X1, float Y1)
{
  pushMatrix();
  translate(RelX0,RelY0);
  rotate(-HALF_PI);
  // rotating system switches X with Y
  line (YGraph(Y0), XGraph(X0), YGraph(Y1), XGraph(X1));
  popMatrix();
}

/*-----------------------------------------------------------------------------*/
void Robot (float X0, float Y0)
{ 
  float RobotQuadSize = 200;    // the octagon is inscribed in a square
  float RobotRadius;
  float OctAngle;
  float[][] Corners = new float[8][2];
  
  if(InBound(X0,Y0))
  {
  RobotRadius = RobotQuadSize/(cos(PI/8));
  int RobotSize = (int)(Xk*RobotRadius/2); //in mm
  float radStep = (2*PI / 8); // 'there's 2 pi radians in 360 degrees
  float Rads;
  if (SimulationDrawFlag)          // simulation
    {
      OctAngle=MesAngle-radStep/2;
    }
    else
    {
      OctAngle=radians(MesAngle)-radStep/2-PI/2;
    }
  pushMatrix();
  translate(RelX0,RelY0);
  rotate(-HALF_PI);
  // rotating system switches X with Y
  strokeWeight(3);
  stroke(255,255,0);
  i = 0;
  for (Rads = -PI; Rads <= PI; Rads+= radStep)
  {
    Corners[i][0] = YGraph(Y0) + RobotSize * cos(Rads - radStep + OctAngle);
    Corners[i][1] = XGraph(X0) + RobotSize * sin(Rads - radStep + OctAngle);
    if (i>0)
    {
      line (Corners[i-1][0], Corners[i-1][1], Corners[i][0], Corners[i][1]);
    }
    i ++;
  }
  
  stroke(255,255,0);
  strokeWeight(3);
  fill(#FFFF00,200);
  triangle (YGraph(Y0), XGraph(X0), Corners[7][0], Corners[7][1], Corners[0][0], 
          Corners[0][1]) ;
  int QuadSize=20;
  
  quad(Corners[6][0], Corners[6][1], Corners[5][0], Corners[5][1], Corners[5][0]
        + Xk*QuadSize*cos(radStep*4 + OctAngle), Corners[5][1]
        + Yk*QuadSize*sin(radStep*4 + OctAngle), Corners[6][0] 
        + Xk*QuadSize*cos(radStep*5 + OctAngle), Corners[6][1] 
        + Yk*QuadSize*sin(radStep*5 + OctAngle));
        
  quad(Corners[1][0], Corners[1][1], Corners[2][0], Corners[2][1], Corners[2][0] 
        + Xk*QuadSize*cos(radStep*1 + OctAngle), Corners[2][1] 
        + Yk*QuadSize*sin(radStep*1 + OctAngle), Corners[1][0] 
        + Xk*QuadSize*cos(radStep*0 + OctAngle), Corners[1][1] 
        + Yk*QuadSize*sin(radStep*0 + OctAngle));
        
  popMatrix();
  fill(255,255,255);
  }
}

/*-----------------------------------------------------------------------------*/
void Objects(float Xcoord, float Ycoord, int Cell)
{
  int Val=0;
  pushMatrix();
  translate(RelX0,RelY0);
  rotate(-HALF_PI);
  // rotating system switches X with Y
  fill(0,0,255);  
  if (Cell<=7)
  {
    fill(0,255,0);  // green = obstacle
    Val=CellSize/7*Cell;
  }
  else if (Cell >=8 && Cell <10)
  {
    fill(255,255,0);  //  yellow = cell visited
    Val=CellSize/3;
  }
  else if (Cell>=12)
  {
    fill(0,255,255);  // purple = target found
    Val=CellSize/2;
  }
  
  rectMode(CENTER);
  strokeWeight(1);
      
  if (InBound(Xcoord, Ycoord))
  {
    rect (YGraph(Ycoord), XGraph(Xcoord), (Val*Yk), (Val*Xk));
  }
  rectMode(LEFT);
  popMatrix();
  fill(255,255,255);
}

/*-----------------------------------------------------------------------------*/
void Graph(float Xcoord, float Ycoord)
{
    /* following statements are needed to translate the reference system from
    0(top-left), 750(bottom right) to  bottom-left, top-right scale values
    */
    strokeWeight(3);
    stroke(255,0,0);
    MyLine(Xcoord, Ycoord, PrevX, PrevY);
    PrevX = Xcoord;
    PrevY = Ycoord;
}

/*-----------------------------------------------------------------------------*/
void Plot ()
{
  int ind = 1;
  int ptr;
  int IndPrev;
  int MaxInd;
  float StepTmp;
  pushMatrix();
  translate(RelX0,RelY-(Yoffset));
  rotate(-HALF_PI);
  strokeWeight(3);
  stroke(255,255,0);
  // rotating system switches X with Y
  
  if (Step >= 1)
  {
     MaxInd = (int)(MaxSpeedData/Step);
     StepTmp = Step;
  }
  else
  {
    MaxInd = MaxSpeedData;
    StepTmp = 1;
  }
  
  if (SpeedDataPtr>=MaxInd)
  {
    SpeedDataPtr=0;
  }
  
  IndPrev = (int)(StepTmp);
  for (ind=1; ind < MaxInd; ind++)
  {
    ptr=(ind+SpeedDataPtr) % MaxInd;
    if (ptr>0)
    {
      line(Z((Speed1[ptr-1])), (int)(Z(IndPrev)), Z((Speed1[ptr])), (int)(Z(ind*StepTmp+1)));
      IndPrev = (int)(ind*StepTmp);
    }
  }
  popMatrix();

  pushMatrix();
  translate(RelX0,RelY+Yoffset);
  rotate(-HALF_PI);
  strokeWeight(3);
  stroke(0,0,255);
  // rotating system switches X with Y

  IndPrev = (int)(StepTmp);
  for (ind=1; ind < MaxInd; ind++)
  {
    ptr=(ind+SpeedDataPtr) % MaxInd;
    if (ptr>0)
    {
      line(Z((Speed2[ptr-1])), (int)(Z(IndPrev)), Z((Speed2[ptr])), (int)(Z(ind*StepTmp+1)));
      IndPrev = (int)(ind*StepTmp);
    }
  }
  popMatrix();
  
  /*
  pushMatrix();
  translate(RelX0,RelY);
  rotate(-HALF_PI);
  strokeWeight(3);
  stroke(255,0,0);
  // rotating system switches X with Y
  
  for (ind=1; ind < MaxSpeedData; ind++)
  {
    ptr=(ind+SpeedDataPtr) % (MaxSpeedData);
    if (ptr<(MaxSpeedData-1))
    {
      line((Speed0[ptr] * Yk), ind, (Speed0[ptr+1] * Yk), ind+1);
    }

  }
  popMatrix();
 */
}


