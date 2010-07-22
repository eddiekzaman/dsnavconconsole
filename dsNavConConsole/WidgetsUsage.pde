/*-----------------------------------------------------------------------------*/  
void MainPanel()  // Main panel controls
{
    Grid = get(Z(57),Z(21),Z(751),Z(751));
    background(bg);
    image(Grid,Z(57),Z(21));
    image(Xscale,Z(30),Z(775));
    image(Yscale,Z(10),Z(10));
        
    Sms();
    ButtonSms();
    ButtonConfig();
    ButtonQuit();
    ButtonSpeed();
    ButtonXY();
    ButtonDist();
    ButtonReset();
    ButtonStartSeq();
    ButtonHalt();
    ButtonDebug();
    ButtonStop();
    ButtonVersion();   
    ButtonSim();
    ButtonMap();
    
    Knob(1162, 333, 0, 360, 0, 360, 12, "Des.Angle=", "°" ); 
    GaugeAngle();
    GaugeAngleCompass();
    GaugeSpeed();
    GaugeCurrent();
    ReleasedFlag = false;
    MainPanelText();
}

/*-----------------------------------------------------------------------------*/
void ConfigPanel()  // Config panel controls
{
    int Kp;
    int Ki;
    int Kd;
    int K;
    int Wheel1;
    int Wheel2;
    int Cpr;
    int Gear;
    long Ksp1;
    long Ksp2;
    float Kvel1;
    float Kvel2;
    
    background(bgConfig);
    text("Last Error",Z(1230),Z(505));
    text(ErrorCode,Z(1230),Z(525));
    ConfigPanelText();
    
    BtnRun.display();
    BtnRun.update();
    
    textFont(CharFont, Z(8)); 
    
    BtnSeqL.update();
    if (BtnSeqL.released)
    {
      PanelIndx = 4;
      InputFieldsSequencer();
      background(bgSequencer);
      StandardFont();
    }
    BtnSeqL.display();
    
    BtnSendCfgKSpeed1.update();
    if (BtnSendCfgKSpeed1.released)
    {
      // 6 int K x 10.000 (range 0 +9999)
      Kp = RangeCheckInt(InputSpeed1Kp.getValue(), 0, 9999);
      InputSpeed1Kp.setValue(nf(Kp,0));
      Ki = RangeCheckInt(InputSpeed1Ki.getValue(), 0, 9999);
      InputSpeed1Ki.setValue(nf(Ki,0));
      Kd = RangeCheckInt(InputSpeed1Kd.getValue(), 0, 9999);
      InputSpeed1Kd.setValue(nf(Kd,0));
      TxIntValue[0] = Kp;
      TxIntValue[1] = Ki;
      TxIntValue[2] = Kd;
      Kp = RangeCheckInt(InputSpeed2Kp.getValue(), 0, 9999);
      InputSpeed2Kp.setValue(nf(Kp,0));
      Ki = RangeCheckInt(InputSpeed2Ki.getValue(), 0, 9999);
      InputSpeed2Ki.setValue(nf(Ki,0));
      Kd = RangeCheckInt(InputSpeed2Kd.getValue(), 0, 9999);
      InputSpeed2Kd.setValue(nf(Kd,0));
      TxIntValue[3] = Kp;
      TxIntValue[4] = Ki;
      TxIntValue[5] = Kd;
      TxData(0, 'K', 6, 1);
    }
    BtnSendCfgKSpeed1.display();
   
    BtnSendCfgKAngle.update();
    if (BtnSendCfgKAngle.released)
    {
      // 3 int K x 10.000 (range 0 +9999)
      Kp = RangeCheckInt(InputAngleKp.getValue(), 0, 9999);
      InputAngleKp.setValue(nf(Kp,0));
      Ki = RangeCheckInt(InputAngleKi.getValue(), 0, 9999);
      InputAngleKi.setValue(nf(Ki,0));
      Kd = RangeCheckInt(InputAngleKd.getValue(), 0, 9999);
      InputAngleKd.setValue(nf(Kd,0));
      TxIntValue[0] = Kp;
      TxIntValue[1] = Ki;
      TxIntValue[2] = Kd;
      TxData(0, 'k', 3, 1);
    }
    BtnSendCfgKAngle.display();
    
    BtnSendCfgKDist.update();
    if (BtnSendCfgKDist.released)
    {
      // 3 int K x 10.000 (range 0 +9999)
      Kp = RangeCheckInt(InputDistKp.getValue(), 0, 9999);
      InputDistKp.setValue(nf(Kp,0));
      Ki = RangeCheckInt(InputDistKi.getValue(), 0, 9999);
      InputDistKi.setValue(nf(Ki,0));
      Kd = RangeCheckInt(InputDistKd.getValue(), 0, 9999);
      InputDistKd.setValue(nf(Kd,0));
      TxIntValue[0] = Kp;
      TxIntValue[1] = Ki;
      TxIntValue[2] = Kd;
      TxData(0, 'J', 3, 1);
    }
    BtnSendCfgKDist.display();


    BtnSendCfgWheels.update();
    if (BtnSendCfgWheels.released)
    {
      /* Axle size (pico meters) 
         Ksp = constants for traveled distance calculation: 
         SPACE_ENC_4X (micron / 1.000.000 = picoM)
         3  long 
         
         Speed calculation K in micron/second = 401.1588
	 Speed calculation K in m/s as a power of 2 to semplify dsPID elaboration
	 Kvel[] << 15 ( x 2^15) 
         2 long, 2 x 4 bytes
         for a detailde description see descrEng.txt in dsPID33 folder
         
         All values are computed starting from mechanical parameters of the wheels 
         and the encoders
      */
      textFont(CharFont, Z(8)); 
      K = RangeCheckInt(InputAxle.getValue(), 0, 999999999);
      InputAxle.setValue(nf(K,0));
            
      Wheel1 = RangeCheckInt(InputWheel1.getValue(), 0, 999999999);
      InputWheel1.setValue(nf(Wheel1,0));

      Wheel2 = RangeCheckInt(InputWheel2.getValue(), 0, 999999999);
      InputWheel2.setValue(nf(Wheel2,0));
      
      Cpr = RangeCheckInt(InputCpr.getValue(), 0, 9999);
      InputCpr.setValue(nf(Cpr,0));
      
      Gear = RangeCheckInt(InputGear.getValue(), 0, 999);
      InputGear.setValue(nf(Gear,0));
      
      Ksp1 = (long)((Wheel1*PI*1000)/(Cpr*Gear*4));
      Ksp2 = (long)((Wheel2*PI*1000)/(Cpr*Gear*4));
      TxIntValue[0] = K/100;
      TxIntValue[1] = (int)(Ksp1);
      TxIntValue[2] = (int)(Ksp2);
      TxData(0, 'M', 3, 2);

      Delay(2);
      
      Kvel1=(Wheel1*PI*Fcy*32768) /(Cpr*Gear*1000) ;
      Kvel2=(Wheel2*PI*Fcy*32768) /(Cpr*Gear*1000) ;
      TxIntValue[0] = (int)(Kvel1);
      TxIntValue[1] = (int)(Kvel2);
      print("Kvel1-"+TxIntValue[0] + "  Kvel2-"+TxIntValue[1]);
      println("  Axle-"+K/100+"  Ksp1 long-"+Ksp1+"  Ksp2-"+Ksp2);
      TxData(0, 'L', 2, 2);
    }
    BtnSendCfgWheels.display();

    BtnSendCfgRS232.update();
    if (BtnSendCfgRS232.released)
    {
       RS232ComPort = RangeCheckInt(InputRS232Com.getValue(), 0, SerialList.length-1);
       RS232Bps = RangeCheckInt(InputRS232bps.getValue(), 1200, 115200);
       try
       { 
          if (! SimulationRS232Flag)
          {
            if (RS232FirstInit)
            {
              RS232Port = new Serial(this, Serial.list()[RS232ComPort], RS232Bps);
              RS232FirstInit=false;
            }
            else
            {
             RS232Port.stop(); // if not first initialization, close previous port 
                               // before opening the new one
             RS232Port = new Serial(this, Serial.list()[RS232ComPort], RS232Bps);
            }

            PreInitRS232Flag = false;          // turn ON real RS232 sending
            CharTime = (115200 / RS232Bps) * 1.5; // waiting time is a function of bps
            RS232Port.clear();
         }
         else
         {
            PreInitRS232Flag = true;          // still in simulation
         }
     }
     catch(Exception e)    // not a valid COM port
     {
           RS232Port.stop();
           RS232ComPort = 99;
           PreInitRS232Flag = true;          // turn OFF real RS232 sending
     } 

       InputRS232Com.setValue(nf(RS232ComPort,0));
       InputRS232bps.setValue(nf(RS232Bps,0));
    }
    BtnSendCfgRS232.display();
    
    BtnSendError.update();
    if (BtnSendError.released)
    {
      TxData(0, 'e', 0, 1);
      Delay(2);              // wait for data to be received
      if (RxData('e',2))
      {// two bytes -> i int
        ErrorCode = Int16toint32(((RxBuff[HeadLen] << 8) + (RxBuff[HeadLen+1])));
      }
    }
    BtnSendError.display();
     
    BtnSendCfgLoad.update();
    if (BtnSendCfgLoad.released)
    {
      LoadCfg();
    }
    BtnSendCfgLoad.display();
    
    BtnSendCfgSave.update();
    if (BtnSendCfgSave.released)
    {
      SaveCfg();
    }
    BtnSendCfgSave.display();
    
    BtnSendMainGrid.update();
    if (BtnSendMainGrid.released)
    {
      MainGridMinX =  Integer.parseInt(InputMGXmin.getValue());
      MainGridMaxX =  Integer.parseInt(InputMGXmax.getValue());
      MainGridMinY =  Integer.parseInt(InputMGYmin.getValue());
      MainGridMaxY =  Integer.parseInt(InputMGYmax.getValue());
      MainGridXstep =  Integer.parseInt(InputMGXstep.getValue());
      MainGridYstep =  Integer.parseInt(InputMGYstep.getValue());
      MainGridXstepSmall =  Integer.parseInt(InputMGXSteps.getValue());
      MainGridYstepSmall =  Integer.parseInt(InputMGYSteps.getValue());
    }
    BtnSendMainGrid.display();
    
    BtnSendMainSet.update();
    if (BtnSendMainSet.released)
    {
      MainGridSet =  RangeCheckInt(InputMGset.getValue(), 1, 8);
      InputMGset.setValue(nf(MainGridSet,0));
      switch (MainGridSet)
      {
        case 1:
          MainGridMinX =  -5000;
          MainGridMaxX =  5000;
          MainGridMinY =  -5000;
          MainGridMaxY =  5000;
          MainGridXstep =  10;
          MainGridYstep =  10;
          MainGridXstepSmall =  50;
          MainGridYstepSmall =  50;
        break;
        
        case 2:
          MainGridMinX =  -10000;
          MainGridMaxX =  10000;
          MainGridMinY =  -10000;
          MainGridMaxY =  10000;
          MainGridXstep =  10;
          MainGridYstep =  10;
          MainGridXstepSmall =  50;
          MainGridYstepSmall =  50;
        break;
        
        case 3:
          MainGridMinX =  -15000;
          MainGridMaxX =  15000;
          MainGridMinY =  -15000;
          MainGridMaxY =  15000;
          MainGridXstep =  10;
          MainGridYstep =  10;
          MainGridXstepSmall =  50;
          MainGridYstepSmall =  50;
        break;
        
        case 4:
          MainGridMinX =  -20000;
          MainGridMaxX =  20000;
          MainGridMinY =  -20000;
          MainGridMaxY =  20000;
          MainGridXstep =  10;
          MainGridYstep =  10;
          MainGridXstepSmall =  50;
          MainGridYstepSmall =  50;
        break;
        
        case 5:
          MainGridMinX =  0;
          MainGridMaxX =  5000;
          MainGridMinY =  0;
          MainGridMaxY =  5000;
          MainGridXstep =  10;
          MainGridYstep =  10;
          MainGridXstepSmall =  50;
          MainGridYstepSmall =  50;
        break;
        
        case 6:
          MainGridMinX =  0;
          MainGridMaxX =  10000;
          MainGridMinY =  0;
          MainGridMaxY =  10000;
          MainGridXstep =  10;
          MainGridYstep =  10;
          MainGridXstepSmall =  50;
          MainGridYstepSmall =  50;
        break;
        
        case 7:
          MainGridMinX =  0;
          MainGridMaxX =  15000;
          MainGridMinY =  0;
          MainGridMaxY =  15000;
          MainGridXstep =  15;
          MainGridYstep =  15;
          MainGridXstepSmall =  75;
          MainGridYstepSmall =  75;
        break;
        
        case 8:
          MainGridMinX =  0;
          MainGridMaxX =  20000;
          MainGridMinY =  0;
          MainGridMaxY =  20000;
          MainGridXstep =  10;
          MainGridYstep =  10;
          MainGridXstepSmall =  50;
          MainGridYstepSmall =  50;
        break;

        default:
          MainGridMinX =  -5000;
          MainGridMaxX =  5000;
          MainGridMinY =  -5000;
          MainGridMaxY =  5000;
          MainGridXstep =  10;
          MainGridYstep =  10;
          MainGridXstepSmall =  50;
          MainGridYstepSmall =  50;
        break;
      }
       InputMGXmin.setValue(nf(MainGridMinX,0));
       InputMGXmax.setValue(nf(MainGridMaxX,0));
       InputMGYmin.setValue(nf(MainGridMinY,0));
       InputMGYmax.setValue(nf(MainGridMaxY,0));
       InputMGXstep.setValue(nf(MainGridXstep,0));
       InputMGYstep.setValue(nf(MainGridYstep,0));
       InputMGXSteps.setValue(nf(MainGridXstepSmall,0));
       InputMGYSteps.setValue(nf(MainGridYstepSmall,0));
    }
    BtnSendMainSet.display();

    BtnSendDetailGrid.update();
    if (BtnSendDetailGrid.released)
    {
      DetailGridMinX =  Integer.parseInt(InputDGXmin.getValue());
      DetailGridMaxX =  Integer.parseInt(InputDGXmax.getValue());
      DetailGridMinY =  Integer.parseInt(InputDGYmin.getValue());
      DetailGridMaxY =  Integer.parseInt(InputDGYmax.getValue());
      DetailGridXstep =  Integer.parseInt(InputDGXstep.getValue());
      DetailGridYstep =  Integer.parseInt(InputDGYstep.getValue());
      DetailGridXstepSmall =  Integer.parseInt(InputDGXSteps.getValue());
      DetailGridYstepSmall =  Integer.parseInt(InputDGYSteps.getValue());
    }
    BtnSendDetailGrid.display();

    BtnSendDetailSet.update();
    if (BtnSendDetailSet.released)
    {
      DetailGridSet =  RangeCheckInt(InputDGset.getValue(), 1, 6);
      InputDGset.setValue(nf(DetailGridSet,0));
      switch (DetailGridSet)
      {
        case 1:
          DetailGridMinX =  -150;
          DetailGridMaxX =  0;
          DetailGridMinY =  -500;
          DetailGridMaxY =  500;
          DetailGridXstep =  15;
          DetailGridYstep =  20;
          DetailGridXstepSmall =  75;
          DetailGridYstepSmall =  100;
        break;
        
        case 2:
          DetailGridMinX =  -200;
          DetailGridMaxX =  0;
          DetailGridMinY =  -500;
          DetailGridMaxY =  500;
          DetailGridXstep =  10;
          DetailGridYstep =  20;
          DetailGridXstepSmall =  50;
          DetailGridYstepSmall =  100;
        break;
        
        case 3:
          DetailGridMinX =  -300;
          DetailGridMaxX =  0;
          DetailGridMinY =  -500;
          DetailGridMaxY =  500;
          DetailGridXstep =  10;
          DetailGridYstep =  20;
          DetailGridXstepSmall =  75;
          DetailGridYstepSmall =  100;
        break;
        
        case 4:
          DetailGridMinX =  -150;
          DetailGridMaxX =  0;
          DetailGridMinY =  -300;
          DetailGridMaxY =  300;
          DetailGridXstep =  15;
          DetailGridYstep =  24;
          DetailGridXstepSmall =  75;
          DetailGridYstepSmall =  120;
        break;
        
        case 5:
          DetailGridMinX =  -200;
          DetailGridMaxX =  0;
          DetailGridMinY =  -300;
          DetailGridMaxY =  300;
          DetailGridXstep =  10;
          DetailGridYstep =  24;
          DetailGridXstepSmall =  50;
          DetailGridYstepSmall =  120;
        break;
        
        case 6:
          DetailGridMinX =  -300;
          DetailGridMaxX =  0;
          DetailGridMinY =  -300;
          DetailGridMaxY =  300;
          DetailGridXstep =  10;
          DetailGridYstep =  24;
          DetailGridXstepSmall =  50;
          DetailGridYstepSmall =  120;
        break;
 
        default:
          DetailGridMinX =  -150;
          DetailGridMaxX =  0;
          DetailGridMinY =  -500;
          DetailGridMaxY =  500;
          DetailGridXstep =  15;
          DetailGridYstep =  20;
          DetailGridXstepSmall =  75;
          DetailGridYstepSmall =  100;
        break;
      }
       InputDGXmin.setValue(nf(DetailGridMinX,0));
       InputDGXmax.setValue(nf(DetailGridMaxX,0));
       InputDGYmin.setValue(nf(DetailGridMinY,0));
       InputDGYmax.setValue(nf(DetailGridMaxY,0));
       InputDGXstep.setValue(nf(DetailGridXstep,0));
       InputDGYstep.setValue(nf(DetailGridYstep,0));
       InputDGXSteps.setValue(nf(DetailGridXstepSmall,0));
       InputDGYSteps.setValue(nf(DetailGridYstepSmall,0));
    }
    BtnSendDetailSet.display();
    
    BtnSendCycle.update();
    if (BtnSendCycle.released)
    {
      CyclePeriod = RangeCheckInt(InputCycle.getValue(),100,1000);
      InputCycle.setValue(nf(CyclePeriod,0));
    }
    BtnSendCycle.display();
   
      StandardFont();
      textAlign(LEFT);
      text("Available COM ports:",Z(800),Z(480));
      for(i=0;i<(SerialList.length);i++)
      {
        if (i == RS232ComPort)
        {
          fill(0,100,255);
        }
        else
        {
          fill(255,255,255);
        }
        text(i + " = " + SerialList[i],Z(810),Z(500) + (i*20));
      }
      fill(255,255,255);
      
   if (BtnRun.released)  
    {
      PanelIndx = 1;
      InputFieldsRun();
      background(bg);
      StandardFont();
      DefineMainGrid();
      Grid = get(Z(57),Z(21),Z(751),Z(751));

//      MeanValues.flush(); 
    }
    BtnRun.display();
    
    ReleasedFlag = false;

}

/*-----------------------------------------------------------------------------*/
void DetailsPanel()  // Details panel controls
{
    background(bgDetails);
    image(Grid,Z(57),Z(21));
    image(Xscale,Z(30),Z(775));
    image(Yscale,Z(10),Z(10));    
    Plot();
    
    Sms();
    ButtonSms();
 
    BtnSeqR.update();
    if (BtnSeqR.released)
    {
      PanelIndx = 4;
      InputFieldsSequencer();
      background(bgSequencer);
      StandardFont();
    }
    BtnSeqR.display();
    
 	ButtonQuit();
    ButtonSpeed();
    ButtonStartSeq();
    ButtonXY();
    ButtonDist();
    ButtonReset();
    ButtonHalt();
    ButtonDebug();
    ButtonStop();
    ButtonVersion();
    
    Knob(1162, 333, 0, 360, 0, 360, 12, "Des.Angle=", "°" ); 
 //   GaugeAngle();
    GaugeCurrentL();
    GaugeCurrentR();
    ReleasedFlag = false;
    MainPanelText();
}

/*-----------------------------------------------------------------------------*/
void SequencerPanel()  // Sequencer panel controls
{
    background(bgSequencer);
    
    textFont(CharFont, Z(8)); 
    SequencerPanelText();
    ButtonConfig();
    
    BtnDet.update();
    if (BtnDet.released)
    {
      PanelIndx = 3;
      InputFieldsDetails();
      background(bgDetails);
      StandardFont();
      DefineDetailsGrid();
      Grid = get(Z(57),Z(21),Z(751),Z(751));
    }
    BtnDet.display();
    
     
    BtnSendCfgLoad.update();
    if (BtnSendCfgLoad.released)
    {
      LoadCfg();
    }
    BtnSendCfgLoad.display();
    
    BtnSendCfgSave.update();
    if (BtnSendCfgSave.released)
    {
      SaveCfg();
    }
    BtnSendCfgSave.display();

//????????????????????????????????????????????????????????????????????????????????    
    BtnSendSeq.update();
    int SeqI;
    int SeqJ;
    int SeqK;
    if (BtnSendSeq.released)
    {      
      Seq[0][0]=RangeCheckInt(Input01Code.getValue(), 0, 6);
      Input01Code.setValue(nf(Seq[0][0],0));
      Seq[0][1]=RangeCheckInt(Input01A.getValue(), 0, 500);
      Input01A.setValue(nf(Seq[0][1],0));
      Seq[0][2]=RangeCheckInt(Input01B.getValue(), 0, 32000);
      Input01B.setValue(nf(Seq[0][2],0));
      Seq[0][3]=RangeCheckInt(Input01C.getValue(), 0, 32000);
      Input01C.setValue(nf(Seq[0][3],0));
     
      Seq[1][0]=RangeCheckInt(Input02Code.getValue(), 0, 6);
      Input02Code.setValue(nf(Seq[1][0],0));
      Seq[1][1]=RangeCheckInt(Input02A.getValue(), 0, 500);
      Input02A.setValue(nf(Seq[1][1],0));
      Seq[1][2]=RangeCheckInt(Input02B.getValue(), 0, 32000);
      Input02B.setValue(nf(Seq[1][2],0));
      Seq[1][3]=RangeCheckInt(Input02C.getValue(), 0, 32000);
      Input02C.setValue(nf(Seq[1][3],0));

      Seq[2][0]=RangeCheckInt(Input03Code.getValue(), 0, 6);
      Input03Code.setValue(nf(Seq[2][0],0));
      Seq[2][1]=RangeCheckInt(Input03A.getValue(), 0, 500);
      Input03A.setValue(nf(Seq[2][1],0));
      Seq[2][2]=RangeCheckInt(Input03B.getValue(), 0, 32000);
      Input03B.setValue(nf(Seq[2][2],0));
      Seq[2][3]=RangeCheckInt(Input03C.getValue(), 0, 32000);
      Input03C.setValue(nf(Seq[2][3],0));

      Seq[3][0]=RangeCheckInt(Input04Code.getValue(), 0, 6);
      Input04Code.setValue(nf(Seq[3][0],0));
      Seq[3][1]=RangeCheckInt(Input04A.getValue(), 0, 500);
      Input04A.setValue(nf(Seq[3][1],0));
      Seq[3][2]=RangeCheckInt(Input04B.getValue(), 0, 32000);
      Input04B.setValue(nf(Seq[3][2],0));
      Seq[3][3]=RangeCheckInt(Input04C.getValue(), 0, 32000);
      Input04C.setValue(nf(Seq[3][3],0));

      Seq[4][0]=RangeCheckInt(Input05Code.getValue(), 0, 6);
      Input05Code.setValue(nf(Seq[4][0],0));
      Seq[4][1]=RangeCheckInt(Input05A.getValue(), 0, 500);
      Input05A.setValue(nf(Seq[4][1],0));
      Seq[4][2]=RangeCheckInt(Input05B.getValue(), 0, 32000);
      Input05B.setValue(nf(Seq[4][2],0));
      Seq[4][3]=RangeCheckInt(Input05C.getValue(), 0, 32000);
      Input05C.setValue(nf(Seq[4][3],0));

      Seq[5][0]=RangeCheckInt(Input06Code.getValue(), 0, 6);
      Input06Code.setValue(nf(Seq[5][0],0));
      Seq[5][1]=RangeCheckInt(Input06A.getValue(), 0, 500);
      Input06A.setValue(nf(Seq[5][1],0));
      Seq[5][2]=RangeCheckInt(Input06B.getValue(), 0, 32000);
      Input06B.setValue(nf(Seq[5][2],0));
      Seq[5][3]=RangeCheckInt(Input06C.getValue(), 0, 32000);
      Input06C.setValue(nf(Seq[5][3],0));

      Seq[6][0]=RangeCheckInt(Input07Code.getValue(), 0, 6);
      Input07Code.setValue(nf(Seq[6][0],0));
      Seq[6][1]=RangeCheckInt(Input07A.getValue(), 0, 500);
      Input07A.setValue(nf(Seq[6][1],0));
      Seq[6][2]=RangeCheckInt(Input07B.getValue(), 0, 32000);
      Input07B.setValue(nf(Seq[6][2],0));
      Seq[6][3]=RangeCheckInt(Input07C.getValue(), 0, 32000);
      Input07C.setValue(nf(Seq[6][3],0));

      Seq[7][0]=RangeCheckInt(Input08Code.getValue(), 0, 6);
      Input08Code.setValue(nf(Seq[7][0],0));
      Seq[7][1]=RangeCheckInt(Input08A.getValue(), 0, 500);
      Input08A.setValue(nf(Seq[7][1],0));
      Seq[7][2]=RangeCheckInt(Input08B.getValue(), 0, 32000);
      Input08B.setValue(nf(Seq[7][2],0));
      Seq[7][3]=RangeCheckInt(Input08C.getValue(), 0, 32000);
      Input08C.setValue(nf(Seq[7][3],0));

      Seq[8][0]=RangeCheckInt(Input09Code.getValue(), 0, 6);
      Input09Code.setValue(nf(Seq[8][0],0));
      Seq[8][1]=RangeCheckInt(Input09A.getValue(), 0, 500);
      Input09A.setValue(nf(Seq[8][1],0));
      Seq[8][2]=RangeCheckInt(Input09B.getValue(), 0, 32000);
      Input09B.setValue(nf(Seq[8][2],0));
      Seq[8][3]=RangeCheckInt(Input09C.getValue(), 0, 32000);
      Input09C.setValue(nf(Seq[8][3],0));

      Seq[9][0]=RangeCheckInt(Input10Code.getValue(), 0, 6);
      Input10Code.setValue(nf(Seq[9][0],0));
      Seq[9][1]=RangeCheckInt(Input10A.getValue(), 0, 500);
      Input10A.setValue(nf(Seq[9][1],0));
      Seq[9][2]=RangeCheckInt(Input10B.getValue(), 0, 32000);
      Input10B.setValue(nf(Seq[9][2],0));
      Seq[9][3]=RangeCheckInt(Input10C.getValue(), 0, 32000);
      Input10C.setValue(nf(Seq[9][3],0));

      Seq[10][0]=RangeCheckInt(Input11Code.getValue(), 0, 6);
      Input11Code.setValue(nf(Seq[10][0],0));
      Seq[10][1]=RangeCheckInt(Input11A.getValue(), 0, 500);
      Input11A.setValue(nf(Seq[10][1],0));
      Seq[10][2]=RangeCheckInt(Input11B.getValue(), 0, 32000);
      Input11B.setValue(nf(Seq[10][2],0));
      Seq[10][3]=RangeCheckInt(Input11C.getValue(), 0, 32000);
      Input11C.setValue(nf(Seq[10][3],0));

      Seq[11][0]=RangeCheckInt(Input12Code.getValue(), 0, 6);
      Input12Code.setValue(nf(Seq[11][0],0));
      Seq[11][1]=RangeCheckInt(Input12A.getValue(), 0, 500);
      Input12A.setValue(nf(Seq[11][1],0));
      Seq[11][2]=RangeCheckInt(Input12B.getValue(), 0, 32000);
      Input12B.setValue(nf(Seq[11][2],0));
      Seq[11][3]=RangeCheckInt(Input12C.getValue(), 0, 32000);
      Input12C.setValue(nf(Seq[11][3],0));

      Seq[12][0]=RangeCheckInt(Input13Code.getValue(), 0, 6);
      Input13Code.setValue(nf(Seq[12][0],0));
      Seq[12][1]=RangeCheckInt(Input13A.getValue(), 0, 500);
      Input13A.setValue(nf(Seq[12][1],0));
      Seq[12][2]=RangeCheckInt(Input13B.getValue(), 0, 32000);
      Input13B.setValue(nf(Seq[12][2],0));
      Seq[12][3]=RangeCheckInt(Input13C.getValue(), 0, 32000);
      Input13C.setValue(nf(Seq[12][3],0));

      Seq[13][0]=RangeCheckInt(Input14Code.getValue(), 0, 6);
      Input14Code.setValue(nf(Seq[13][0],0));
      Seq[13][1]=RangeCheckInt(Input14A.getValue(), 0, 500);
      Input14A.setValue(nf(Seq[13][1],0));
      Seq[13][2]=RangeCheckInt(Input14B.getValue(), 0, 32000);
      Input14B.setValue(nf(Seq[13][2],0));
      Seq[13][3]=RangeCheckInt(Input14C.getValue(), 0, 32000);
      Input14C.setValue(nf(Seq[13][3],0));

      Seq[14][0]=RangeCheckInt(Input15Code.getValue(), 0, 6);
      Input15Code.setValue(nf(Seq[14][0],0));
      Seq[14][1]=RangeCheckInt(Input15A.getValue(), 0, 500);
      Input15A.setValue(nf(Seq[14][1],0));
      Seq[14][2]=RangeCheckInt(Input15B.getValue(), 0, 32000);
      Input15B.setValue(nf(Seq[14][2],0));
      Seq[14][3]=RangeCheckInt(Input15C.getValue(), 0, 32000);
      Input15C.setValue(nf(Seq[14][3],0));

      Seq[15][0]=RangeCheckInt(Input16Code.getValue(), 0, 6);
      Input16Code.setValue(nf(Seq[15][0],0));
      Seq[15][1]=RangeCheckInt(Input16A.getValue(), 0, 500);
      Input16A.setValue(nf(Seq[15][1],0));
      Seq[15][2]=RangeCheckInt(Input16B.getValue(), 0, 32000);
      Input16B.setValue(nf(Seq[15][2],0));
      Seq[15][3]=RangeCheckInt(Input16C.getValue(), 0, 32000);
      Input16C.setValue(nf(Seq[15][3],0));

      SeqK=0;
      for (SeqI=0; SeqI<16; SeqI++)
      {
        for (SeqJ=0; SeqJ<4; SeqJ++)
        {
          TxIntValue[SeqK] = Seq[SeqI][SeqJ];
          SeqK++;
        }
      }
      TxData(0, 's', 64, 1);
    }
    BtnSendSeq.display();
//????????????????????????????????????????????????????????????????????????????????    
 
textFont(FixFont, Z(15)); 
textAlign(LEFT);
int TextX = Z(700);
int TextY = Z(480);
int TextS = Z(15);
// text("Sequencer code description",TextX,TextY+TextS*0);
text("Code Meaning Description                         A   B   C",TextX,TextY+TextS*1);
text("0    stop    end of sequence                            ",TextX,TextY+TextS*2);
text("1    Vel     keep angle-set speed                V      ",TextX,TextY+TextS*3);
text("2    Dist    keep angle and speed-set distance   V   D   ",TextX,TextY+TextS*4);
text("3    Angle   keep speed-set angle                V   Phi ",TextX,TextY+TextS*5);
text("4    Angle   keep speed-set angle toward X, Y    V   X   Y",TextX,TextY+TextS*6);
text("5    Speed   keep speed-walk toward X, Y         V   X   Y",TextX,TextY+TextS*7);
text("6    Delay   wait n x 50ms                       Time     ",TextX,TextY+TextS*8);

text("Units",TextX,TextY+TextS*10);
text("  Angle=deg, Speed=mm/s, X-Y=mm, Delay=n x 50ms",TextX,TextY+TextS*11);

      StandardFont();

      fill(255,255,255);
      
/*   if (BtnRun.released)  
    {
      PanelIndx = 1;
      InputFieldsRun();
      background(bg);
      StandardFont();
      DefineMainGrid();
      Grid = get(Z(57),Z(21),Z(751),Z(751));
    }
    BtnRun.display();
*/
    
    ReleasedFlag = false;
}

