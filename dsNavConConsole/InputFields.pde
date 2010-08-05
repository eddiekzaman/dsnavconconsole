/*
  The Interfascia library is used to program input fields:
  http://www.superstable.net/interfascia/
  the procedure to initialize and use these fields can be found at that URL
  Due to the complexity of some panels, some arrays are used to make it easier 
  and more flexible to apply some descripting labels close to text fields.
*/

/*-----------------------------------------------------------------------------*/
void InputFieldsDefinition()
{
  // Define and create input fields for Main panel  *************************
  GuiRun = new GUIController(this);
  
  M[0][0] = Z(1043);
  M[0][1] = Z(503);
  InputSpeed = new IFTextField("", M[0][0], M[0][1], W);
  InputSpeed.addActionListener(this);
  InputSpeed.setHeight(Z(Fheight));

  
  M[1][0] = Z(1043);
  M[1][1] = Z(553);
  InputDist = new IFTextField("", M[1][0], M[1][1], W);
  InputDist.addActionListener(this);
  InputDist.setHeight(Z(Fheight));
  

  M[2][0] = Z(923);
  M[2][1] = Z(603);
  InputCoordX = new IFTextField("", M[2][0], M[2][1], W);
  InputCoordX.addActionListener(this);
  InputCoordX.setHeight(Z(Fheight));
  

  M[3][0] = Z(1043);
  M[3][1] = Z(603);
  InputCoordY = new IFTextField("", M[3][0], M[3][1], W);
  InputCoordY.addActionListener(this);
  InputCoordY.setHeight(Z(Fheight));
  
  
  // Define and create input fields for Config panel  *************************
  GuiConfig = new GUIController(this);
  
  C[0][0] = Z(856);
  C[0][1] = Z(63);
  InputSpeed1Kp = new IFTextField("", C[0][0], C[0][1], W);
  InputSpeed1Kp.addActionListener(this);
  InputSpeed1Kp.setHeight(Z(Fheight));
  
  C[1][0] = Z(969);
  C[1][1] = Z(63);
  InputSpeed1Ki = new IFTextField("", C[1][0], C[1][1], W);
  InputSpeed1Ki.addActionListener(this);
  InputSpeed1Ki.setHeight(Z(Fheight));

  C[2][0] = Z(1083);
  C[2][1] = Z(63);
  InputSpeed1Kd = new IFTextField("", C[2][0], C[2][1], W);
  InputSpeed1Kd.addActionListener(this);
  InputSpeed1Kd.setHeight(Z(Fheight));

  C[3][0] = Z(856);
  C[3][1] = Z(119);
  InputSpeed2Kp = new IFTextField("", C[3][0], C[3][1], W);
  InputSpeed2Kp.addActionListener(this);
  InputSpeed2Kp.setHeight(Z(Fheight));
  
  C[4][0] = Z(969);
  C[4][1] = Z(119);
  InputSpeed2Ki = new IFTextField("", C[4][0], C[4][1], W);
  InputSpeed2Ki.addActionListener(this);
  InputSpeed2Ki.setHeight(Z(Fheight));

  C[5][0] = Z(1083);
  C[5][1] = Z(119);
  InputSpeed2Kd = new IFTextField("", C[5][0], C[5][1], W);
  InputSpeed2Kd.addActionListener(this);
  InputSpeed2Kd.setHeight(Z(Fheight));

  C[6][0] = Z(856);
  C[6][1] = Z(176);
  InputAngleKp = new IFTextField("", C[6][0], C[6][1], W);
  InputAngleKp.addActionListener(this);
  InputAngleKp.setHeight(Z(Fheight));

  C[7][0] = Z(969);
  C[7][1] = Z(176);
  InputAngleKi = new IFTextField("", C[7][0], C[7][1], W);
  InputAngleKi.addActionListener(this);
  InputAngleKi.setHeight(Z(Fheight));

  C[8][0] = Z(1083);
  C[8][1] = Z(176);
  InputAngleKd = new IFTextField("", C[8][0], C[8][1], W);
  InputAngleKd.addActionListener(this);
  InputAngleKd.setHeight(Z(Fheight));

  C[9][0] = Z(856);
  C[9][1] = Z(232);
  InputDistKp = new IFTextField("", C[9][0], C[9][1], W);
  InputDistKp.addActionListener(this);
  InputDistKp.setHeight(Z(Fheight));

  C[10][0] = Z(969);
  C[10][1] = Z(232);
  InputDistKi = new IFTextField("", C[10][0], C[10][1], W);
  InputDistKi.addActionListener(this);
  InputDistKi.setHeight(Z(Fheight));

  C[11][0] = Z(1083);
  C[11][1] = Z(232);
  InputDistKd = new IFTextField("", C[11][0], C[11][1], W);
  InputDistKd.addActionListener(this);
  InputDistKd.setHeight(Z(Fheight));

  C[12][0] = Z(856);
  C[12][1] = Z(289);
  InputAxle = new IFTextField("", C[12][0], C[12][1], W);
  InputAxle.addActionListener(this);
  InputAxle.setHeight(Z(Fheight));

  C[13][0] = Z(969);
  C[13][1] = Z(289);
  InputWheel1 = new IFTextField("", C[13][0], C[13][1], W);
  InputWheel1.addActionListener(this);
  InputWheel1.setHeight(Z(Fheight));

  C[14][0] = Z(1083);
  C[14][1] = Z(289);
  InputWheel2 = new IFTextField("", C[14][0], C[14][1], W);
  InputWheel2.addActionListener(this);
  InputWheel2.setHeight(Z(Fheight));

  C[15][0] = Z(969);
  C[15][1] = Z(346);
  InputCpr = new IFTextField("", C[15][0], C[15][1], W);
  InputCpr.addActionListener(this);
  InputCpr.setHeight(Z(Fheight));

  C[16][0] = Z(1083);
  C[16][1] = Z(346);
  InputGear = new IFTextField("", C[16][0], C[16][1], W);
  InputGear.addActionListener(this);
  InputGear.setHeight(Z(Fheight));

  C[17][0] = Z(969);
  C[17][1] = Z(403);  
  InputRS232bps = new IFTextField("", C[17][0], C[17][1], W);
  InputRS232bps.addActionListener(this);
  InputRS232bps.setHeight(Z(Fheight));

  C[18][0] = Z(1083);
  C[18][1] = Z(403);  
  InputRS232Com = new IFTextField("", C[18][0], C[18][1], W);
  InputRS232Com.addActionListener(this);
  InputRS232Com.setHeight(Z(Fheight));

  GuiConfig2 = new GUIController(this);  
  C[19][0] = Z(148);
  C[19][1] = Z(63);   
  InputMGXmin = new IFTextField("", C[19][0], C[19][1], W);
  InputMGXmin.addActionListener(this);
  InputMGXmin.setHeight(Z(Fheight));
  
  C[20][0] = Z(261);
  C[20][1] = Z(63);    
  InputMGXmax = new IFTextField("", C[20][0], C[20][1], W);
  InputMGXmax.addActionListener(this);
  InputMGXmax.setHeight(Z(Fheight));

  C[21][0] = Z(375);
  C[21][1] = Z(63);   
  InputMGYmin = new IFTextField("", C[21][0], C[21][1], W);
  InputMGYmin.addActionListener(this);
  InputMGYmin.setHeight(Z(Fheight));

  C[22][0] = Z(488);
  C[22][1] = Z(63);    
  InputMGYmax = new IFTextField("", C[22][0], C[22][1], W);
  InputMGYmax.addActionListener(this);
  InputMGYmax.setHeight(Z(Fheight));


  C[23][0] = Z(148);
  C[23][1] = Z(119);    
  InputMGXstep = new IFTextField("", C[23][0], C[23][1], W);
  InputMGXstep.addActionListener(this);
  InputMGXstep.setHeight(Z(Fheight));

  C[24][0] = Z(261);
  C[24][1] = Z(119);   
  InputMGYstep = new IFTextField("", C[24][0], C[24][1], W);
  InputMGYstep.addActionListener(this);
  InputMGYstep.setHeight(Z(Fheight));

  C[25][0] = Z(375);
  C[25][1] = Z(119);    
  InputMGXSteps = new IFTextField("", C[25][0], C[25][1], W);
  InputMGXSteps.addActionListener(this);
  InputMGXSteps.setHeight(Z(Fheight));

  C[26][0] = Z(488);
  C[26][1] = Z(119);      
  InputMGYSteps = new IFTextField("", C[26][0], C[26][1], W);
  InputMGYSteps.addActionListener(this);
  InputMGYSteps.setHeight(Z(Fheight));

  C[27][0] = Z(148);
  C[27][1] = Z(176);    
  InputMGset = new IFTextField("", C[27][0], C[27][1], W);
  InputMGset.addActionListener(this);
  InputMGset.setHeight(Z(Fheight));
  
  C[28][0] = Z(148);
  C[28][1] = Z(232);     
  InputDGXmin = new IFTextField("", C[28][0], C[28][1], W);
  InputDGXmin.addActionListener(this);
  InputDGXmin.setHeight(Z(Fheight));

  C[29][0] = Z(261);
  C[29][1] = Z(232);   
  InputDGXmax = new IFTextField("", C[29][0], C[29][1], W);
  InputDGXmax.addActionListener(this);
  InputDGXmax.setHeight(Z(Fheight));

  C[30][0] = Z(375);
  C[30][1] = Z(232);     
  InputDGYmin = new IFTextField("", C[30][0], C[30][1], W);
  InputDGYmin.addActionListener(this);
  InputDGYmin.setHeight(Z(Fheight));

  C[31][0] = Z(488);
  C[31][1] = Z(232);     
  InputDGYmax = new IFTextField("", C[31][0], C[31][1], W);
  InputDGYmax.addActionListener(this);
  InputDGYmax.setHeight(Z(Fheight));

  C[32][0] = Z(148);
  C[32][1] = Z(289);    
  InputDGXstep = new IFTextField("", C[32][0], C[32][1], W);
  InputDGXstep.addActionListener(this);
  InputDGXstep.setHeight(Z(Fheight));

  C[33][0] = Z(261);
  C[33][1] = Z(289);     
  InputDGYstep = new IFTextField("", C[33][0], C[33][1], W);
  InputDGYstep.addActionListener(this);
  InputDGYstep.setHeight(Z(Fheight));

  C[34][0] = Z(375);
  C[34][1] = Z(289);     
  InputDGXSteps = new IFTextField("", C[34][0], C[34][1], W);
  InputDGXSteps.addActionListener(this);
  InputDGXSteps.setHeight(Z(Fheight));

  C[35][0] = Z(488);
  C[35][1] = Z(289);     
  InputDGYSteps = new IFTextField("", C[35][0], C[35][1], W);
  InputDGYSteps.addActionListener(this);
  InputDGYSteps.setHeight(Z(Fheight));

  C[36][0] = Z(148);
  C[36][1] = Z(346);    
  InputDGset = new IFTextField("", C[36][0], C[36][1], W);
  InputDGset.addActionListener(this);
  InputDGset.setHeight(Z(Fheight));

  C[37][0] = Z(148);
  C[37][1] = Z(403);    
  InputCycle = new IFTextField("", C[37][0], C[37][1], W);
  InputCycle.addActionListener(this);
  InputCycle.setHeight(Z(Fheight));
  
  C[38][0] = Z(148);
  C[38][1] = Z(457);    
  InputCam = new IFTextField("", C[38][0], C[38][1], W);
  InputCam.addActionListener(this);
  InputCam.setHeight(Z(Fheight));
  
   // Define and create input fields for Sequencer panel  *************************
  GuiSequencer1 = new GUIController(this);
  int i;
  int j;
  int StepI = Z(115);
  int StepJ = Z(45);
  int StartI = Z(150);
  int StartJ = Z(60);
  int ii=StartI;
  int jj=StartJ;
  for (i=0; i<16; i++)
  {
    for (j=0; j<4; j++)
    {
      Sx[i][j] = ii;
      Sy[i][j] = jj;
      ii +=StepI;
    }
    ii = StartI;
    jj +=StepJ;
  }
  i=0;
  j=0;
  Input01Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input01Code.addActionListener(this);
  Input01Code.setHeight(Z(Fheight));
  Input01A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input01A.addActionListener(this);
  Input01A.setHeight(Z(Fheight));
  Input01B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input01B.addActionListener(this);
  Input01B.setHeight(Z(Fheight));
  Input01C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input01C.addActionListener(this);
  Input01C.setHeight(Z(Fheight));
  i++;
  j=0;
 
  Input02Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input02Code.addActionListener(this);
  Input02Code.setHeight(Z(Fheight));
  Input02A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input02A.addActionListener(this);
  Input02A.setHeight(Z(Fheight));
  Input02B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input02B.addActionListener(this);
  Input02B.setHeight(Z(Fheight));
  Input02C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input02C.addActionListener(this);
  Input02C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input03Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input03Code.addActionListener(this);
  Input03Code.setHeight(Z(Fheight));
  Input03A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input03A.addActionListener(this);
  Input03A.setHeight(Z(Fheight));
  Input03B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input03B.addActionListener(this);
  Input03B.setHeight(Z(Fheight));
  Input03C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input03C.addActionListener(this);  
  Input03C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input04Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input04Code.addActionListener(this);
  Input04Code.setHeight(Z(Fheight));
  Input04A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input04A.addActionListener(this);
  Input04A.setHeight(Z(Fheight));
  Input04B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input04B.addActionListener(this);
  Input04B.setHeight(Z(Fheight));
  Input04C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input04C.addActionListener(this);  
  Input04C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  GuiSequencer2 = new GUIController(this);
  Input05Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input05Code.addActionListener(this);
  Input05Code.setHeight(Z(Fheight));
  Input05A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input05A.addActionListener(this);
  Input05A.setHeight(Z(Fheight));
  Input05B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input05B.addActionListener(this);
  Input05B.setHeight(Z(Fheight));
  Input05C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input05C.addActionListener(this);  
  Input05C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input06Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input06Code.addActionListener(this);
  Input06Code.setHeight(Z(Fheight));
  Input06A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input06A.addActionListener(this);
  Input06A.setHeight(Z(Fheight));
  Input06B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input06B.addActionListener(this);
  Input06B.setHeight(Z(Fheight));
  Input06C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input06C.addActionListener(this);
  Input06C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input07Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input07Code.addActionListener(this);
  Input07Code.setHeight(Z(Fheight));
  Input07A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input07A.addActionListener(this);
  Input07A.setHeight(Z(Fheight));
  Input07B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input07B.addActionListener(this);
  Input07B.setHeight(Z(Fheight));
  Input07C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input07C.addActionListener(this);
  Input07C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input08Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input08Code.addActionListener(this);
  Input08Code.setHeight(Z(Fheight));
  Input08A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input08A.addActionListener(this);
  Input08A.setHeight(Z(Fheight));
  Input08B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input08B.addActionListener(this);
  Input08B.setHeight(Z(Fheight));
  Input08C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input08C.addActionListener(this);  
  Input08C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  GuiSequencer3 = new GUIController(this);
  Input09Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input09Code.addActionListener(this);
  Input09Code.setHeight(Z(Fheight));
  Input09A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input09A.addActionListener(this);
  Input09A.setHeight(Z(Fheight));
  Input09B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input09B.addActionListener(this);
  Input09B.setHeight(Z(Fheight));
  Input09C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input09C.addActionListener(this);  
  Input09C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input10Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input10Code.addActionListener(this);
  Input10Code.setHeight(Z(Fheight));
  Input10A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input10A.addActionListener(this);
  Input10A.setHeight(Z(Fheight));
  Input10B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input10B.addActionListener(this);
  Input10B.setHeight(Z(Fheight));
  Input10C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input10C.addActionListener(this);  
  Input10C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input11Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input11Code.addActionListener(this);
  Input11Code.setHeight(Z(Fheight));
  Input11A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input11A.addActionListener(this);
  Input11A.setHeight(Z(Fheight));
  Input11B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input11B.addActionListener(this);
  Input11B.setHeight(Z(Fheight));
  Input11C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input11C.addActionListener(this);
  Input11C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input12Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input12Code.addActionListener(this);
  Input12Code.setHeight(Z(Fheight));
  Input12A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input12A.addActionListener(this);
  Input12A.setHeight(Z(Fheight));
  Input12B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input12B.addActionListener(this);
  Input12B.setHeight(Z(Fheight));
  Input12C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input12C.addActionListener(this);
  Input12C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  GuiSequencer4 = new GUIController(this);
  Input13Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input13Code.addActionListener(this);
  Input13Code.setHeight(Z(Fheight));
  Input13A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input13A.addActionListener(this);
  Input13A.setHeight(Z(Fheight));
  Input13B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input13B.addActionListener(this);
  Input13B.setHeight(Z(Fheight));
  Input13C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input13C.addActionListener(this);  
  Input13C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input14Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input14Code.addActionListener(this);
  Input14Code.setHeight(Z(Fheight));
  Input14A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input14A.addActionListener(this);
  Input14A.setHeight(Z(Fheight));
  Input14B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input14B.addActionListener(this);
  Input14B.setHeight(Z(Fheight));
  Input14C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input14C.addActionListener(this);  
  Input14C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input15Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input15Code.addActionListener(this);
  Input15Code.setHeight(Z(Fheight));
  Input15A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input15A.addActionListener(this);
  Input15A.setHeight(Z(Fheight));
  Input15B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input15B.addActionListener(this);
  Input15B.setHeight(Z(Fheight));
  Input15C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input15C.addActionListener(this); 
  Input15C.setHeight(Z(Fheight));
  i++;
  j=0;
  
  Input16Code = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input16Code.addActionListener(this);
  Input16Code.setHeight(Z(Fheight));
  Input16A = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input16A.addActionListener(this);
  Input16A.setHeight(Z(Fheight));
  Input16B = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input16B.addActionListener(this);
  Input16B.setHeight(Z(Fheight));
  Input16C = new IFTextField("", Sx[i][j], Sy[i][j++], W);
  Input16C.addActionListener(this);  
  Input16C.setHeight(Z(Fheight));
}

/*-----------------------------------------------------------------------------*/
void InputFieldsRun()   // input fields for Main panel 
{
  GuiConfig.setVisible(false);
  GuiConfig2.setVisible(false);
  
  GuiRun.setVisible(true);
}

/*-----------------------------------------------------------------------------*/
void InputFieldsConfig()    // input fields for Config panel 
{ 
  GuiRun.setVisible(false);
  GuiSequencer1.setVisible(false);
  GuiSequencer2.setVisible(false);
  GuiSequencer3.setVisible(false);
  GuiSequencer4.setVisible(false);
 
  GuiConfig.setVisible(true);
  GuiConfig2.setVisible(true);
}

/*-----------------------------------------------------------------------------*/
void InputFieldsSequencer()    // input fields for Sequencer panel 
{
  GuiRun.setVisible(false);
  GuiConfig.setVisible(false);
  GuiConfig2.setVisible(false);
 
  GuiSequencer1.setVisible(true);
  GuiSequencer2.setVisible(true);
  GuiSequencer3.setVisible(true);
  GuiSequencer4.setVisible(true);
}

/*-----------------------------------------------------------------------------*/
void InputFieldsDetails()   // input fields for Details panel 
{
  GuiSequencer1.setVisible(false);
  GuiSequencer2.setVisible(false);
  GuiSequencer3.setVisible(false);
  GuiSequencer4.setVisible(false);

  GuiRun.setVisible(true);
}

/*-----------------------------------------------------------------------------*/
void SetInputFieldsRun()   // input fields for Main panel 
{
  GuiRun.add(InputSpeed);
  GuiRun.add(InputDist);
  GuiRun.add(InputCoordX);
  GuiRun.add(InputCoordY);
}

/*-----------------------------------------------------------------------------*/
void SetInputFieldsConfig()    // input fields for Config panel 
{
  GuiConfig.add(InputSpeed1Kp);
  GuiConfig.add(InputSpeed1Ki);
  GuiConfig.add(InputSpeed1Kd);
  
  GuiConfig.add(InputSpeed2Kp);
  GuiConfig.add(InputSpeed2Ki);
  GuiConfig.add(InputSpeed2Kd);
  
  GuiConfig.add(InputAngleKp);
  GuiConfig.add(InputAngleKi);
  GuiConfig.add(InputAngleKd);
  
  GuiConfig.add(InputDistKp);
  GuiConfig.add(InputDistKi);
  GuiConfig.add(InputDistKd);

  GuiConfig.add(InputAxle);
  GuiConfig.add(InputWheel1);
  GuiConfig.add(InputWheel2);
  
  GuiConfig.add(InputCpr);
  GuiConfig.add(InputGear);
  
  GuiConfig.add(InputRS232bps);
  GuiConfig.add(InputRS232Com);
  
  GuiConfig2.add(InputMGXmin);
  GuiConfig2.add(InputMGXmax);
  GuiConfig2.add(InputMGYmin);
  GuiConfig2.add(InputMGYmax);
  GuiConfig2.add(InputMGXstep);
  GuiConfig2.add(InputMGYstep);
  GuiConfig2.add(InputMGXSteps);
  GuiConfig2.add(InputMGYSteps);
  GuiConfig2.add(InputMGset);
  
  GuiConfig2.add(InputDGXmin);
  GuiConfig2.add(InputDGXmax);
  GuiConfig2.add(InputDGYmin);
  GuiConfig2.add(InputDGYmax);
  GuiConfig2.add(InputDGXstep);
  GuiConfig2.add(InputDGYstep);
  GuiConfig2.add(InputDGXSteps);
  GuiConfig2.add(InputDGYSteps);
  GuiConfig2.add(InputDGset);
  GuiConfig2.add(InputCycle);
  GuiConfig2.add(InputCam);
}

/*-----------------------------------------------------------------------------*/
void SetInputFieldsSequencer()    // input fields for Sequencer panel 
{
  GuiSequencer1.add(Input01Code);
  GuiSequencer1.add(Input01A);
  GuiSequencer1.add(Input01B);
  GuiSequencer1.add(Input01C);
  GuiSequencer1.add(Input02Code);
  GuiSequencer1.add(Input02A);
  GuiSequencer1.add(Input02B);
  GuiSequencer1.add(Input02C);
  GuiSequencer1.add(Input03Code);
  GuiSequencer1.add(Input03A);
  GuiSequencer1.add(Input03B);
  GuiSequencer1.add(Input03C);
  GuiSequencer1.add(Input04Code);
  GuiSequencer1.add(Input04A);
  GuiSequencer1.add(Input04B);
  GuiSequencer1.add(Input04C);
  GuiSequencer2.add(Input05Code);
  GuiSequencer2.add(Input05A);
  GuiSequencer2.add(Input05B);
  GuiSequencer2.add(Input05C);
  GuiSequencer2.add(Input06Code);
  GuiSequencer2.add(Input06A);
  GuiSequencer2.add(Input06B);
  GuiSequencer2.add(Input06C);
  GuiSequencer2.add(Input07Code);
  GuiSequencer2.add(Input07A);
  GuiSequencer2.add(Input07B);
  GuiSequencer2.add(Input07C);
  GuiSequencer2.add(Input08Code);
  GuiSequencer2.add(Input08A);
  GuiSequencer2.add(Input08B);
  GuiSequencer2.add(Input08C);
  GuiSequencer3.add(Input09Code);
  GuiSequencer3.add(Input09A);
  GuiSequencer3.add(Input09B);
  GuiSequencer3.add(Input09C);
  GuiSequencer3.add(Input10Code);
  GuiSequencer3.add(Input10A);
  GuiSequencer3.add(Input10B);
  GuiSequencer3.add(Input10C);
  GuiSequencer3.add(Input11Code);
  GuiSequencer3.add(Input11A);
  GuiSequencer3.add(Input11B);
  GuiSequencer3.add(Input11C);
  GuiSequencer3.add(Input12Code);
  GuiSequencer3.add(Input12A);
  GuiSequencer3.add(Input12B);
  GuiSequencer3.add(Input12C);
  GuiSequencer4.add(Input13Code);
  GuiSequencer4.add(Input13A);
  GuiSequencer4.add(Input13B);
  GuiSequencer4.add(Input13C);
  GuiSequencer4.add(Input14Code);
  GuiSequencer4.add(Input14A);
  GuiSequencer4.add(Input14B);
  GuiSequencer4.add(Input14C);
  GuiSequencer4.add(Input15Code);
  GuiSequencer4.add(Input15A);
  GuiSequencer4.add(Input15B);
  GuiSequencer4.add(Input15C);
  GuiSequencer4.add(Input16Code);
  GuiSequencer4.add(Input16A);
  GuiSequencer4.add(Input16B);
  GuiSequencer4.add(Input16C);
}

/*-----------------------------------------------------------------------------*/
void SetInputFieldsDetails()   // input fields for Details panel 
{
  GuiRun.add(InputSpeed);
  GuiRun.add(InputDist);
  GuiRun.add(InputCoordX);
  GuiRun.add(InputCoordY);
}

/*-----------------------------------------------------------------------------*/  
void actionPerformed(GUIEvent e)   // an event on input fields
{
  if (e.getMessage().equals("Completed"))
  {
    //SendSpeed();
  }
}

/*-----------------------------------------------------------------------------*/  
void MainPanelText()
{
  int i;
  int x = 5;
  int y = 3;
  String[][] Descr = new String[4][4];
  Descr[2][0] = "Coord. X=";
  Descr[2][1] = "";
  Descr[0][0] = "Des.Speed=";
  Descr[0][1] = "mm/s";
  Descr[1][0] = "Des.Dist=";
  Descr[1][1] = "mm";
  Descr[3][0] = "Y=";
  Descr[3][1] = "mm";
  
  for (i=0; i<4; i++)
    {
      image (InputField,M[i][0]-x, M[i][1]-y);
      textAlign(RIGHT);
      text (Descr[i][0],(M[i][0]-Z(6)), (M[i][1]+Z(15)));
      textAlign(LEFT);
      text (Descr[i][1],(M[i][0]+W+Z(6)), (M[i][1]+Z(15)));
    }
}

/*-----------------------------------------------------------------------------*/  
void ConfigPanelText()
{
  int i;
  int x = 5;
  int y = 3;
  int z = 15;
  String[] Descr = new String[40];
  Descr[0] = "Kp x 10.000";
  Descr[1] = "Ki x 10.000";
  Descr[2] = "Kd x 10.000";
  Descr[3] = "";
  Descr[4] = "";
  Descr[5] = "";
  Descr[6] = "";
  Descr[7] = "";
  Descr[8] = "";
  Descr[9] = "";
  Descr[10] = "";
  Descr[11] = "";
  Descr[12] = "Axle (nM)";
  Descr[13] = (char)216 + "1 (nM)";
  Descr[14] = (char)216 + "2 (nM)";
  Descr[15] = "CPR";
  Descr[16] = "Red.Ratio";
  Descr[17] = "";
  Descr[18] = "";
  Descr[19] = "X min (mm)";
  Descr[20] = "X max (mm)";
  Descr[21] = "Y min (mm)";
  Descr[22] = "Y max (mm)";
  Descr[23] = "X steps";
  Descr[24] = "Y steps";
  Descr[25] = "X steps s.";
  Descr[26] = "Y steps s.";
  Descr[27] = "Set #";
  Descr[28] = "X min (mm)";
  Descr[29] = "X max (mm)";
  Descr[30] = "Y min (mm)";
  Descr[31] = "Y max (mm)";
  Descr[32] = "X steps";
  Descr[33] = "Y steps";
  Descr[34] = "X steps s.";
  Descr[35] = "Y steps s.";
  Descr[36] = "Set #";
  Descr[37] = "ms";
  Descr[38] = "";

  for (i=0; i<39; i++)
    {
      image (InputField,C[i][0]-x, C[i][1]-y);
      textAlign(CENTER);
      text (Descr[i],(C[i][0]+W/2+2), (C[i][1]-Z(10)));
    }
      textAlign(LEFT);
      text ("Main Panel Grid",(C[22][0]+W+z), (C[22][1]+z));
      text ("Detail Panel Grid",(C[31][0]+W+z), (C[31][1]+z));
      text ("Cycle time",(C[37][0]+W+z), (C[37][1]+z));
      text ("Web Cam",(C[38][0]+W+z), (C[38][1]+z));
      textAlign(RIGHT);
      text ("Speed R",(C[0][0]-z), (C[0][1]+z));
      text ("Speed L",(C[3][0]-z), (C[3][1]+z));
      text ("Angle",(C[6][0]-z), (C[6][1]+z));
      text ("Dist",(C[9][0]-z), (C[9][1]+z));
      text ("Wheels",(C[12][0]-z), (C[12][1]+z));
      text ("Encoder",(C[12][0]-z), (C[15][1]+z));
      text ("RS232",(C[12][0]-z), (C[17][1]+z));
}

/*-----------------------------------------------------------------------------*/  
void SequencerPanelText()
{
  int i;
  int j;
  int x = 5;
  int y = 3;
  int z = 10;
  for (i=0; i<16; i++)
  {
    for (j=0; j<4; j++)
    {
      image (InputField,Sx[i][j]-x, Sy[i][j]-y);
    }
  }
  
  textAlign(CENTER);
  StandardFont();
  text("Code", Sx[0][0]+W/2+2, Sy[0][0]-z);
  text("A", Sx[0][1]+W/2+2, Sy[0][1]-z);
  text("B", Sx[0][2]+W/2+2, Sy[0][2]-z);
  text("C", Sx[0][3]+W/2+2, Sy[0][3]-z);
  textAlign(RIGHT);
  for (i=0; i<16; i++)
  {
      text(nf(i+1,0), Sx[i][0]-z, Sy[i][0]+15);
  }

}
