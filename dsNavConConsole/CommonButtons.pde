/*-----------------------------------------------------------------------------*/  
void ButtonSpeed()
{
  BtnSendSpeed.update();
    if (BtnSendSpeed.released)
    {
      // 1 int (range -500 mm/s +500 mm/s)
      DesSpeed = RangeCheckInt(InputSpeed.getValue(), -500, 500);
      InputSpeed.setValue(nf(DesSpeed,3));
      controlP5.controller("bar").setValue(DesSpeed);
      TxIntValue[0] = DesSpeed;
      TxData(0, 'S', 1, 1);
    }
    BtnSendSpeed.display();
}    
 
/*-----------------------------------------------------------------------------*/  
void ButtonQuit()
{
    BtnQuit.update();
    if (BtnQuit.released)
    {
//      MeanValues.flush();
//      MeanValues.close();
      exit();
    }
    BtnQuit.display();
}

/*-----------------------------------------------------------------------------*/  
void ButtonStartSeq()
{
	    BtnStartSeq.update();
    if (BtnStartSeq.released)
    {
      TxData(0, '#', 0, 0);
    }
    BtnStartSeq.display();
}

/*-----------------------------------------------------------------------------*/  
void ButtonConfig()
{
    BtnConfig.update();
    if (BtnConfig.released)
    {
      PanelIndx = 2;
      InputFieldsConfig();
      background(bg);
      textFont(CharFont, 15); 
//      MeanValues.flush();
//      MeanValues.close();
    }
    BtnConfig.display();
}

/*-----------------------------------------------------------------------------*/  
void ButtonXY()
{
    BtnSendXY.update();
    if (BtnSendXY.released)
    {
      //2 int ( X, Y) (range -20000 mm +20000 mm)
      DesCoordX = RangeCheckInt(InputCoordX.getValue(), -20000, 20000);
      InputCoordX.setValue(nf(DesCoordX,4));
      DesCoordY = RangeCheckInt(InputCoordY.getValue(), -20000, 20000);
      InputCoordY.setValue(nf(DesCoordY,4));
      TxIntValue[0] = DesCoordX;
      TxIntValue[1] = DesCoordY;
      TxData(0, 'P', 2, 1);
    }
    BtnSendXY.display();
}

/*-----------------------------------------------------------------------------*/  
void ButtonDist()
{
    BtnSendDist.update();
    if (BtnSendDist.released)
    {
      // 1 int (range -20000 mm + 20000 mm)
      DesDist = RangeCheckInt(InputDist.getValue(), -20000, 20000);
      InputDist.setValue(nf(DesDist,4));
      TxIntValue[0] = DesDist;
      TxData(0, 'D', 1, 1);
    }
    BtnSendDist.display();
}    

/*-----------------------------------------------------------------------------*/  
void ButtonReset()
{
    BtnSendReset.update();
    if (BtnSendReset.released)
    {
      StopFlag = true;
      TxData(0, '*', 0, 0);
    }
    BtnSendReset.display();
}

/*-----------------------------------------------------------------------------*/  
void ButtonHalt()
{
    BtnSendHalt.update();
    if (BtnSendHalt.released)
    {
		Halt();
    }
    BtnSendHalt.display();
}

/*-----------------------------------------------------------------------------*/  
void Halt()
{
    TxData(0, 'H', 0, 0);
    SmsFlag = false;
    DesSpeed = 0;     
    InputSpeed.setValue(nf(DesSpeed,3));
    controlP5.controller("bar").setValue(DesSpeed);
}

/*-----------------------------------------------------------------------------*/  
void ButtonDebug()
{
    if (DebugFlag)
    {
      BtnDebugOn.update();
      if (BtnDebugOn.released)
      {
        DebugFlag=false;
        TxIntValue[0] = 0;
        TxData(0, 'f', 1, 0);
      }
      BtnDebugOn.display();
    }
    else
    {
      BtnDebugOn.display();
      BtnDebugOff.update();
      if (BtnDebugOff.released)
      {
        DebugFlag=true;
        TxIntValue[0] = 1;
        TxData(0, 'f', 1, 0);
      }
      BtnDebugOff.display();
    }
}

/*-----------------------------------------------------------------------------*/  
void ButtonStop()
{
    if (StopFlag)
    {
      BtnStopOn.update();
      if (BtnStopOn.released)
      {
      if (!PreInitRS232Flag)
        {
          StopFlag=false;
        }
      }
      BtnStopOn.display();
    }
    else
    {
      BtnStopOn.display();
      BtnStopOff.update();
      if (BtnStopOff.released)
      {
        StopFlag=true;
      }
      BtnStopOff.display();
    }
}

/*-----------------------------------------------------------------------------*/  
void ButtonVersion()
{
    BtnSendVersion.update();
    if (BtnSendVersion.released)
    {
      int VerLen = 26;
      TxData(0, 'R', 0, 0);  
      if (RxData('R',VerLen))
      {
        for (i=HeadLen; i < VerLen+HeadLen; i++)
        {
          Ver[i-HeadLen]= (char)(RxBuff[i]);
        }
      }
    }
    textAlign(LEFT);
    textFont(CharFont,Z(10));
    text("X: "+Xpos,Z(700),Z(20));
    text("Y: "+Ypos,Z(760),Z(20));
    text(VerCon, Z(100), Z(20));
    textAlign(RIGHT);
    String VerS = new String(Ver);
    textFont(CharFont, Z(15)); 
    text(VerS, Z(1148), Z(672)); 
    fill(255,0,0);
    textFont(CharFont, Z(28)); 
    text(Sim, Z(500), Z(21));
    fill(255,255,255);
    textFont(CharFont, Z(15)); 
    BtnSendVersion.display();
}

/*-----------------------------------------------------------------------------*/  
void ButtonMap()
{
    int Xshift;
    int Yshift;
    int MapSendIndx;
    int Xindx;
    int Yindx;
    float Xcoord;
    float Ycoord;
    int CellValue;
    
    BtnMap.update();
    
    if (TxMapFlag)
    {
      TxMapFlag=false;
      delay(1000);
      
      for (Yindx = 0; Yindx < MapYsize; Yindx++)
      {
        TxIntValue[0] = Yindx;  // request a row of grid map matrix
        TxData(0, '$', 1, 0);
        if (RxData('$',MapXsizeR+6))
        {
          MapSendIndx = RxBuff[HeadLen]; // normalized index of the current row on field map matrix
          // see at descreng.txt in dsPID33 software at reference [22g]
          Xshift = Int16toint32(((RxBuff[HeadLen+1] << 8) + (RxBuff[HeadLen+2])));
          Yshift = Int16toint32(((RxBuff[HeadLen+3] << 8) + (RxBuff[HeadLen+4])));
          Ycoord = RealCoord(Yindx, Yshift, MinMapY, MaxMapY, MapYsize);
  //        println();  // debug
  //        println();  // debug
  //        println ("(X:"+Xshift+" Y:"+Yshift+" Ycoord:"+Ycoord+" Yindx:"+Yindx+ ") *** "); // debug
          for (Xindx = 0; Xindx < MapXsizeR; Xindx++)
          {
             CellValue=RxBuff[Xindx+HeadLen+5] & 0x0F; // lower nibble
             Xcoord = RealCoord(Xindx*2, Xshift, MinMapX, MaxMapX, MapXsize);
             Objects(Xcoord, Ycoord, CellValue);
             CellValue=(RxBuff[Xindx+HeadLen+5] & 0xF0) >> 4; // upper nibble
 //            print("("+Xcoord+" "+CellValue+")  ");  // debug
             Xcoord = RealCoord(Xindx*2+1, Xshift, MinMapX, MaxMapX, MapXsize);
             Objects(Xcoord, Ycoord, CellValue);
//             print("("+Xcoord+" "+CellValue+") ");  // debug
          }
        }
      }    
    }
    
    if (BtnMap.released)
    {
      StopFlag=true;
      TxMapFlag=true;
      controlP5.controller("bar").setValue(0);  // stop the motors
      TxIntValue[0] = 0;
      TxData(0, 'S', 1, 1);
      BtnStopOn.display();
    }
    BtnMap.display();
}

/*-----------------------------------------------------------------------------*/  
float RealCoord(int Index, int Shift, float MinMap, float MaxMap, int MapSize)
{/* return real coordinates also when the filed matrix was translated forth or
    backward. For details see at descreng.txt in dsPID33 software at ref.[22g]*/
  float MapShift;
  
  if (Shift == 0)  // no field translation
  {
    MapShift = MinMap;      // not shifted
  }
  else if (Shift > 0)  // beyond max limit
  {
    if (Index < Shift)
    {
      MapShift = MaxMap;        // shifted forward
    }
    else
    {
      MapShift = MinMap;      // not shifted
    }
  }
  else  // < 0, behind min limit
  {
    if (Index > (MapSize + Shift))  // in this case Shift is negative
    {
      MapShift = MinMap;     // shifted backward
      Index = - (MapSize - Index);
    }
    else
    {
      MapShift = MinMap;      // not shifted
    }
  }
  
  return(Index * CellSize) + MapShift;
}
