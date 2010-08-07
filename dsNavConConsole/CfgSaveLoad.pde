/*-----------------------------------------------------------------------------*/
void LoadCfg()  // Load data from config.txt file
{
  if (! SimulationCfgFlag)
  {
    if (loadStrings("config.txt") != null)
    {
      StrCfg = loadStrings("config.txt");
    }
    else 
    {
      CfgDefault();
      saveStrings("config.txt",StrCfg);
    }
  }
  else
  {
    CfgDefault();
  }
  
  FillTextFields();
}

/*-----------------------------------------------------------------------------*/
void CfgDefault()
{//if file config.txt is not present a new one is created with defaults
      StrCfg[0] = "9000";
      StrCfg[1] = "7000";
      StrCfg[2] = "1000";
      StrCfg[3] = "9000";
      StrCfg[4] = "7000";
      StrCfg[5] = "1000";
      StrCfg[6] = "9999";
      StrCfg[7] = "7000";
      StrCfg[8] = "1";
      StrCfg[9] = "9999";
      StrCfg[10] = "8000";
      StrCfg[11] = "1";
      StrCfg[12] = "184872798";
      StrCfg[13] = "58040715";
      StrCfg[14] = "57891660";
      StrCfg[15] = "300";
      StrCfg[16] = "30";
      StrCfg[17] = "57600";
      StrCfg[18] = "0";
  
      StrCfg[19] =  "-5000";
      StrCfg[20] =  "5000";
      StrCfg[21] =  "-5000";
      StrCfg[22] =  "5000";
      StrCfg[23] =  "10";
      StrCfg[24] =  "10";
      StrCfg[25] =  "50";
      StrCfg[26] =  "50";
      StrCfg[27] =  "1";

      StrCfg[28] =  "-150";
      StrCfg[29] =  "0";
      StrCfg[30] =  "-500";
      StrCfg[31] =  "500";
      StrCfg[32] =  "15";
      StrCfg[33] =  "20";
      StrCfg[34] =  "100";
      StrCfg[35] =  "75";
      StrCfg[36] =  "3";
      StrCfg[37] =  "200";

      
     int SeqK=38;
     int SeqI;
     for (SeqI=0; SeqI<64; SeqI++)
     {
        StrCfg[SeqK] =  "0";
        SeqK++;
     }
     StrCfg[64] =  "75";
}

/*-----------------------------------------------------------------------------*/
void FillTextFields()
{
       textFont(CharFont, Z(10)); 
       InputSpeed1Kp.setValue(StrCfg[0]);
       InputSpeed1Ki.setValue(StrCfg[1]);
       InputSpeed1Kd.setValue(StrCfg[2]);
       InputSpeed2Kp.setValue(StrCfg[3]);
       InputSpeed2Ki.setValue(StrCfg[4]);
       InputSpeed2Kd.setValue(StrCfg[5]);
       InputAngleKp.setValue(StrCfg[6]);
       InputAngleKi.setValue(StrCfg[7]);
       InputAngleKd.setValue(StrCfg[8]);
       InputDistKp.setValue(StrCfg[9]);
       InputDistKi.setValue(StrCfg[10]);
       InputDistKd.setValue(StrCfg[11]);
       InputAxle.setValue(StrCfg[12]);
       InputWheel1.setValue(StrCfg[13]);
       
       
       
       
       InputWheel2.setValue(StrCfg[14]);
       InputCpr.setValue(StrCfg[15]);
       InputGear.setValue(StrCfg[16]);
       InputRS232bps.setValue(StrCfg[17]);
       InputRS232Com.setValue(StrCfg[18]);
       
       InputMGXmin.setValue(StrCfg[19]);
       InputMGXmax.setValue(StrCfg[20]);
       InputMGYmin.setValue(StrCfg[21]);
       InputMGYmax.setValue(StrCfg[22]);
       InputMGXstep.setValue(StrCfg[23]);
       InputMGYstep.setValue(StrCfg[24]);
       InputMGXSteps.setValue(StrCfg[25]);
       InputMGYSteps.setValue(StrCfg[26]);
       InputMGset.setValue("0");
       
       InputDGXmin.setValue(StrCfg[28]);
       InputDGXmax.setValue(StrCfg[29]);
       InputDGYmin.setValue(StrCfg[30]);
       InputDGYmax.setValue(StrCfg[31]);
       InputDGXstep.setValue(StrCfg[32]);
       InputDGYstep.setValue(StrCfg[33]);
       InputDGXSteps.setValue(StrCfg[34]);
       InputDGYSteps.setValue(StrCfg[35]);
       InputDGset.setValue("0");
       InputCycle.setValue(StrCfg[37]);
            
      if (! SimulationCfgFlag)
      {
        saveStrings("config.txt",StrCfg);
      }
       textFont(CharFont, Z(15)); 
      
      MainGridMinX = Integer.parseInt(StrCfg[19]);
      MainGridMaxX = Integer.parseInt(StrCfg[20]);
      MainGridMinY = Integer.parseInt(StrCfg[21]);
      MainGridMaxY = Integer.parseInt(StrCfg[22]);
      MainGridXstep = Integer.parseInt(StrCfg[23]);
      MainGridYstep = Integer.parseInt(StrCfg[24]);
      MainGridXstepSmall = Integer.parseInt(StrCfg[25]);
      MainGridYstepSmall = Integer.parseInt(StrCfg[26]);
      MainGridFlag = Integer.parseInt(StrCfg[27]);

      DetailGridMinX = Integer.parseInt(StrCfg[28]);
      DetailGridMaxX = Integer.parseInt(StrCfg[29]);
      DetailGridMinY = Integer.parseInt(StrCfg[30]);
      DetailGridMaxY = Integer.parseInt(StrCfg[31]);
      DetailGridXstep = Integer.parseInt(StrCfg[32]);
      DetailGridYstep = Integer.parseInt(StrCfg[33]);
      DetailGridXstepSmall = Integer.parseInt(StrCfg[34]);
      DetailGridYstepSmall = Integer.parseInt(StrCfg[35]);
      DetailGridFlag = Integer.parseInt(StrCfg[36]); 
      CyclePeriod = Integer.parseInt(StrCfg[37]);
      
       int SeqK;
       int SeqI;
       int SeqJ;
      
       SeqK=38;
       for (SeqI=0; SeqI<16; SeqI++)
       {
         for (SeqJ=0; SeqJ<4; SeqJ++)
         {
           Seq[SeqI][SeqJ] = Integer.parseInt(StrCfg[SeqK]);
           SeqK++;
         }
       }
       
      
      Input01Code.setValue(nf(Seq[0][0],0));
      Input01A.setValue(nf(Seq[0][1],0));
      Input01B.setValue(nf(Seq[0][2],0));
      Input01C.setValue(nf(Seq[0][3],0));
      Input02Code.setValue(nf(Seq[1][0],0));
      Input02A.setValue(nf(Seq[1][1],0));
      Input02B.setValue(nf(Seq[1][2],0));
      Input02C.setValue(nf(Seq[1][3],0));
      Input03Code.setValue(nf(Seq[2][0],0));
      Input03A.setValue(nf(Seq[2][1],0));
      Input03B.setValue(nf(Seq[2][2],0));
      Input03C.setValue(nf(Seq[2][3],0));
      Input04Code.setValue(nf(Seq[3][0],0));
      Input04A.setValue(nf(Seq[3][1],0));
      Input04B.setValue(nf(Seq[3][2],0));
      Input04C.setValue(nf(Seq[3][3],0));
      Input05Code.setValue(nf(Seq[4][0],0));
      Input05A.setValue(nf(Seq[4][1],0));
      Input05B.setValue(nf(Seq[4][2],0));
      Input05C.setValue(nf(Seq[4][3],0));
      Input06Code.setValue(nf(Seq[5][0],0));
      Input06A.setValue(nf(Seq[5][1],0));
      Input06B.setValue(nf(Seq[5][2],0));
      Input06C.setValue(nf(Seq[5][3],0));
      Input07Code.setValue(nf(Seq[6][0],0));
      Input07A.setValue(nf(Seq[6][1],0));
      Input07B.setValue(nf(Seq[6][2],0));
      Input07C.setValue(nf(Seq[6][3],0));
      Input08Code.setValue(nf(Seq[7][0],0));
      Input08A.setValue(nf(Seq[7][1],0));
      Input08B.setValue(nf(Seq[7][2],0));
      Input08C.setValue(nf(Seq[7][3],0));
      Input09Code.setValue(nf(Seq[8][0],0));
      Input09A.setValue(nf(Seq[8][1],0));
      Input09B.setValue(nf(Seq[8][2],0));
      Input09C.setValue(nf(Seq[8][3],0));
      Input10Code.setValue(nf(Seq[9][0],0));
      Input10A.setValue(nf(Seq[9][1],0));
      Input10B.setValue(nf(Seq[9][2],0));
      Input10C.setValue(nf(Seq[9][3],0));
      Input11Code.setValue(nf(Seq[10][0],0));
      Input11A.setValue(nf(Seq[10][1],0));
      Input11B.setValue(nf(Seq[10][2],0));
      Input11C.setValue(nf(Seq[10][3],0));
      Input12Code.setValue(nf(Seq[11][0],0));
      Input12A.setValue(nf(Seq[11][1],0));
      Input12B.setValue(nf(Seq[11][2],0));
      Input12C.setValue(nf(Seq[11][3],0));
      Input13Code.setValue(nf(Seq[12][0],0));
      Input13A.setValue(nf(Seq[12][1],0));
      Input13B.setValue(nf(Seq[12][2],0));
      Input13C.setValue(nf(Seq[12][3],0));
      Input14Code.setValue(nf(Seq[13][0],0));
      Input14A.setValue(nf(Seq[13][1],0));
      Input14B.setValue(nf(Seq[13][2],0));
      Input14C.setValue(nf(Seq[13][3],0));
      Input15Code.setValue(nf(Seq[14][0],0));
      Input15A.setValue(nf(Seq[14][1],0));
      Input15B.setValue(nf(Seq[14][2],0));
      Input15C.setValue(nf(Seq[14][3],0));
      Input16Code.setValue(nf(Seq[15][0],0));
      Input16A.setValue(nf(Seq[15][1],0));
      Input16B.setValue(nf(Seq[15][2],0));
      Input16C.setValue(nf(Seq[15][3],0));

 }
       
/*-----------------------------------------------------------------------------*/
void SaveCfg()  // Save current data to config.txt file
{
      StrCfg[0] = InputSpeed1Kp.getValue();
      StrCfg[1] = InputSpeed1Ki.getValue();
      StrCfg[2] = InputSpeed1Kd.getValue();
      StrCfg[3] = InputSpeed2Kp.getValue();
      StrCfg[4] = InputSpeed2Ki.getValue();
      StrCfg[5] = InputSpeed2Kd.getValue();
      StrCfg[6] = InputAngleKp.getValue();
      StrCfg[7] = InputAngleKi.getValue();
      StrCfg[8] = InputAngleKd.getValue();
      StrCfg[9] = InputDistKp.getValue();
      StrCfg[10] = InputDistKi.getValue();
      StrCfg[11] = InputDistKd.getValue();
      StrCfg[12] = InputAxle.getValue();
      StrCfg[13] = InputWheel1.getValue();
      StrCfg[14] = InputWheel2.getValue();
      StrCfg[15] = InputCpr.getValue();
      StrCfg[16] = InputGear.getValue();
      StrCfg[17] = InputRS232bps.getValue();
      StrCfg[18] = InputRS232Com.getValue();
      
      StrCfg[19] =  nf(MainGridMinX,0);
      StrCfg[20] =  nf(MainGridMaxX,0);
      StrCfg[21] =  nf(MainGridMinY,0);
      StrCfg[22] =  nf(MainGridMaxY,0);
      StrCfg[23] =  nf(MainGridXstep,0);
      StrCfg[24] =  nf(MainGridYstep,0);
      StrCfg[25] =  nf(MainGridXstepSmall,0);
      StrCfg[26] =  nf(MainGridYstepSmall,0);
      StrCfg[27] =  nf(MainGridFlag,0);

      StrCfg[28] =  nf(DetailGridMinX,0);
      StrCfg[29] =  nf(DetailGridMaxX,0);
      StrCfg[30] =  nf(DetailGridMinY,0);
      StrCfg[31] =  nf(DetailGridMaxY,0);
      StrCfg[32] =  nf(DetailGridXstep,0);
      StrCfg[33] =  nf(DetailGridYstep,0);
      StrCfg[34] =  nf(DetailGridXstepSmall,0);
      StrCfg[35] =  nf(DetailGridYstepSmall,0);
      StrCfg[36] =  nf(DetailGridFlag,0);
      StrCfg[37] =  nf(CyclePeriod,0);
      
      int SeqK;
      int SeqI;
      int SeqJ;
      
      SeqK=38;
      for (SeqI=0; SeqI<16; SeqI++)
      {
        for (SeqJ=0; SeqJ<4; SeqJ++)
        {
          StrCfg[SeqK] =  nf(Seq[SeqI][SeqJ],0);
          SeqK++;
        }
      }
      
      if (! SimulationCfgFlag)
      {
        saveStrings("config.txt",StrCfg);
      }
}


