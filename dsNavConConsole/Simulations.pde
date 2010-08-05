/*-----------------------------------------------------------------------------*/
void SimulationDrawing()
{// just for simulation
    DeltaDist = (MesSpeed * CyclePeriod) / 1000; 
    Distance += DeltaDist;
    DeltaX = DeltaDist * (sin(MesAngle + HALF_PI));
    DeltaY = DeltaDist * (cos(MesAngle + HALF_PI));
    if (!CamFlag)
    {
      Graph(DeltaX+PrevXtmp,DeltaY+PrevYtmp);
    }
    Xpos=DeltaX+PrevXtmp;
    Ypos=DeltaY+PrevYtmp;
    PrevXtmp = DeltaX+PrevXtmp;
    PrevYtmp = DeltaY+PrevYtmp;
}

void ButtonSim()
 {
  BtnSim.update();
  if (BtnSim.released)
  {
    if(SimulationDrawFlag==true)
    {
      SimulationDrawFlag = false;
      SimulationRS232Flag = false;
      Sim=(" ");
    }
    else
    {
      SimulationDrawFlag = true;
      SimulationRS232Flag = true;
      Sim=("SIMULATION");
    }
  }
   // BtnSim.display();
 }

