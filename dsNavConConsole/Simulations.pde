/*-----------------------------------------------------------------------------*/
void SimulationDrawing()
{// just for simulation
    DeltaDist = (MesSpeed * CyclePeriod) / 1000; 
    Distance += DeltaDist;
    DeltaX = DeltaDist * (sin(MesAngle + HALF_PI));
    DeltaY = DeltaDist * (cos(MesAngle + HALF_PI));
    if (!CamFlag)
    {
      Xpos=DeltaX+PrevXtmp;
      Ypos=DeltaY+PrevYtmp;
    }
    Xpos=DeltaX+PrevXtmp;
    Ypos=DeltaY+PrevYtmp;
    PrevXtmp = DeltaX+PrevXtmp;
    PrevYtmp = DeltaY+PrevYtmp;
}


