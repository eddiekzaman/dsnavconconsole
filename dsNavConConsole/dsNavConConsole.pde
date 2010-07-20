/* ////////////////////////////////////////////////////////////////////////////
** File:      dsNavConConsole.pde					    */
 String VerCon = new String ("dsNavConsole 1.5.0 - 05-2010"); //---
/* Author:    Guido Ottaviani-->g.ottaviani@mediaprogetti.it<--
** Description: navigation control board remote console
-------------------------------------------------------------------------------
** Compatible with dsPid33 version 2.2.3 
-------------------------------------------------------------------------------
Copyright 2010 Guido Ottaviani
g.ottaviani@mediaprogetti.it

    dsNavConConsole is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    dsNavConConsole is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with dsNavConConsole.  If not, see <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------------------    
/////////////////////////////////////////////////////////////////////////////*/
import processing.serial.*;
import interfascia.*;
import controlP5.*;
// import sms.*; //Sudden Motion Sensor

// ************************** input text fields
GUIController GuiRun;
IFTextField InputSpeed;
IFTextField InputDist;
IFTextField InputCoordX;
IFTextField InputCoordY;

GUIController GuiConfig;
IFTextField InputSpeed1Kp;
IFTextField InputSpeed1Ki;
IFTextField InputSpeed1Kd;
IFTextField InputSpeed2Kp;
IFTextField InputSpeed2Ki;
IFTextField InputSpeed2Kd;
IFTextField InputAngleKp;
IFTextField InputAngleKi;
IFTextField InputAngleKd;
IFTextField InputDistKp;
IFTextField InputDistKi;
IFTextField InputDistKd;
IFTextField InputAxle;
IFTextField InputWheel1;
IFTextField InputWheel2;
IFTextField InputCpr;
IFTextField InputGear;
IFTextField InputRS232bps;
IFTextField InputRS232Com;

GUIController GuiConfig2;
IFTextField InputMGXmin;
IFTextField InputMGXmax;
IFTextField InputMGYmin;
IFTextField InputMGYmax;
IFTextField InputMGXstep;
IFTextField InputMGYstep;
IFTextField InputMGXSteps;
IFTextField InputMGYSteps;
IFTextField InputMGset;

IFTextField InputDGXmin;
IFTextField InputDGXmax;
IFTextField InputDGYmin;
IFTextField InputDGYmax;
IFTextField InputDGXstep;
IFTextField InputDGYstep;
IFTextField InputDGXSteps;
IFTextField InputDGYSteps;
IFTextField InputDGset;
IFTextField InputCycle;

GUIController GuiSequencer1;
IFTextField Input01Code;
IFTextField Input01A;
IFTextField Input01B;
IFTextField Input01C;
IFTextField Input02Code;
IFTextField Input02A;
IFTextField Input02B;
IFTextField Input02C;
IFTextField Input03Code;
IFTextField Input03A;
IFTextField Input03B;
IFTextField Input03C;
IFTextField Input04Code;
IFTextField Input04A;
IFTextField Input04B;
IFTextField Input04C;

GUIController GuiSequencer2;
IFTextField Input05Code;
IFTextField Input05A;
IFTextField Input05B;
IFTextField Input05C;
IFTextField Input06Code;
IFTextField Input06A;
IFTextField Input06B;
IFTextField Input06C;
IFTextField Input07Code;
IFTextField Input07A;
IFTextField Input07B;
IFTextField Input07C;
IFTextField Input08Code;
IFTextField Input08A;
IFTextField Input08B;
IFTextField Input08C;

GUIController GuiSequencer3;
IFTextField Input09Code;
IFTextField Input09A;
IFTextField Input09B;
IFTextField Input09C;
IFTextField Input10Code;
IFTextField Input10A;
IFTextField Input10B;
IFTextField Input10C;
IFTextField Input11Code;
IFTextField Input11A;
IFTextField Input11B;
IFTextField Input11C;
IFTextField Input12Code;
IFTextField Input12A;
IFTextField Input12B;
IFTextField Input12C;

GUIController GuiSequencer4;
IFTextField Input13Code;
IFTextField Input13A;
IFTextField Input13B;
IFTextField Input13C;
IFTextField Input14Code;
IFTextField Input14A;
IFTextField Input14B;
IFTextField Input14C;
IFTextField Input15Code;
IFTextField Input15A;
IFTextField Input15B;
IFTextField Input15C;
IFTextField Input16Code;
IFTextField Input16A;
IFTextField Input16B;
IFTextField Input16C;

// coordinates and width of input fields
int[][] M = new int[4][4];
int[][] C = new int[38][38];
int[][] Sx = new int[16][4];
int[][] Sy = new int[16][4];
int W = 73;

// ************************** buttons
ImageButtons BtnQuit;
ImageButtons BtnRS232;
ImageButtons BtnConfig;
ImageButtons BtnRun;
ImageButtons BtnDet;
ImageButtons BtnSeqL;
ImageButtons BtnSeqR;
ImageButtons BtnSendSpeed;
ImageButtons BtnSendXY;
ImageButtons BtnSendDist;
ImageButtons BtnSendHalt;
ImageButtons BtnSendReset;
ImageButtons BtnSendVersion;
ImageButtons BtnSms;
ImageButtons BtnSim;
ImageButtons BtnMap;

ImageButtons BtnSendCfgKSpeed1;
ImageButtons BtnSendCfgKSpeed2;
ImageButtons BtnSendCfgKAngle;
ImageButtons BtnSendCfgKDist;
ImageButtons BtnSendCfgWheels;
ImageButtons BtnSendCfgKvel;
ImageButtons BtnSendCfgRS232;
ImageButtons BtnSendCfgSave;
ImageButtons BtnSendCfgLoad;
ImageButtons BtnDebugOff;
ImageButtons BtnDebugOn;
ImageButtons BtnStopOff;
ImageButtons BtnStopOn;
ImageButtons BtnSendError;
ImageButtons BtnStartSeq;

ImageButtons BtnSendMainGrid;
ImageButtons BtnSendMainSet;
ImageButtons BtnSendDetailGrid;
ImageButtons BtnSendDetailSet;
ImageButtons BtnSendCycle;

ImageButtons BtnSendSeq;

// PrintWriter MeanValues;
// PrintWriter DetailValues;

// ************************** other images
PImage bg;            // main panel backgraound
PImage bgConfig;      // config panel backgraound
PImage bgDetails;     // detail panel backgraound
PImage bgSequencer;   // sequencer panel backgraound
PImage Grid;
PImage BlankGrid;
PImage LedRedOn;
PImage LedRedOff;
PImage LedGreenOn;
PImage LedGreenOff;
PImage LedYellowOn;
PImage LedYellowOff;
PImage Xscale;
PImage Yscale;
PImage Gauge; 
PImage GaugeTextField; 
PImage InputField;
PImage Knob;
// button images set
PImage bN;
PImage bO;
PImage bP;
PImage bNr;
PImage bOr;
PImage bPr;

// ************************** gauges
float KnobAngle = -PI/2;
float KnobAngle1 = -PI/2;
int DesSpeed = 0;
int MesSpeed = 0;
float Current = 0;
float CurrentR = 0;
float CurrentL = 0;
float DesAngle = 0;
float DesAnglePrev = 0;
float MesAngle = 0;
float CompassAngle = 0;

// ************************** Definitions
int PanelIndx = 1;
boolean ReleasedFlag = false;

int Cycle = 100;
int CyclePeriod;

int RelX = 432;
int RelY = 397;
int RelX0 = 57;
int Ysize = 750;
int Xsize = 750;
int RelY0 = 21 + Ysize;

int i = 0;
float PrevX = 0;
float PrevY = 0;
float DeltaX = 0;
float DeltaY = 0;
float Xpos = 0;
float Ypos = 0;
float Distance = 0;
float DeltaDist = 0;
float PrevXtmp = 0;      // just for simulation
float PrevYtmp = 0;      // just for simulation

int DesDist = 0;
int DesCoordX = 0;
int DesCoordY = 0;

int TxPeriod = 500;
int TxTimer;
boolean BlinkFlag;
boolean TxFlag = false;

Serial RS232Port;
int RS232ComPort = 99;
int RS232Bps;

String[] StrCfg = new String[128];  // config string
String[] SerialList = new String[0];  // declare an empty string for serial ports list 
byte[] TxBuff = new byte[144];  // Transmission buffer
int TxHeadLen = 4;             // TX header lenght
int[] TxIntValue = new int[128]; // int value buffer

int IdleCount = 0;
int IdleTime = 0;
int IdleTimeP = 0;

float CharTime = (0.2); // time period in ms for a char sent on RS232

int[] RxBuff = new int[128];

int Err = 0;
int HeadLen = 4;    // RX-TX header length

char Ver[] = new char[32];

String Sim = new String("  ");  // simulation text string

PFont CharFont;
PFont FixFont;
PFont CharFontLight;

boolean DebugFlag = false;
int ErrorCode = 0;
int IdlePerc;

int MaxSpeedData = 750;
int Max = 750;
int MaxYvalue = 500;
int Yoffset = Ysize/4;
int[] Speed1 = new int[MaxSpeedData+10]; // Y axis graph data for first value
int[] Speed2 = new int[MaxSpeedData+10]; // Y axis graph data for second value
int[] Speed0 = new int[MaxSpeedData+10]; // Y axis graph data for mean value
int SpeedDataPtr = 1;                 // array index pointer
int SpeedDataStep = 1;                // X axis step
float Xk;                             // X costant multiplier to draw graph
float Yk;                             // Y costant multiplier to draw graph
float Xkofst;                         // X offset to draw graph
float Ykofst;                         // Y offset to draw graph

int MainGridMinX;
int MainGridMaxX;
int MainGridMinY;
int MainGridMaxY;
int MainGridXstep;
int MainGridYstep;
int MainGridXstepSmall;
int MainGridYstepSmall;
int MainGridFlag;
int MainGridSet;

int DetailGridMinX;
int DetailGridMaxX;
int DetailGridMinY;
int DetailGridMaxY;
int DetailGridXstep;
int DetailGridYstep;
int DetailGridXstepSmall;
int DetailGridYstepSmall;
int DetailGridFlag;
int DetailGridSet;
float Step;

int[][] Seq = new int[16][4];
  
// it will be set false after RS232 configuration to start real communication
boolean PreInitRS232Flag = true;  
boolean StopFlag = true;

/* in order to allow usage of the applet in a browser as a demo simulation,
   some functions that access to HW resources must me disabled, otherwise a
   security violation error occurs.
*/
boolean SimulationDrawFlag = false;
boolean SimulationCfgFlag = false;
boolean SimulationRS232Flag = false;
boolean RS232FirstInit = true;

ControlP5 controlP5;
int sliderValue = 0;

boolean SmsFlag=false;
int[] vals = new int[3]; 

float Fcy = 40; // with 10MHz quartz on dsNav

/* ATTENTION when updating matrix size values, update as well the 
	equivalent values on dsPID33 software code*/

int MapYsize = 150;
int MapXsize = 150;
int VarPerByte = 2;
int MapXsizeR = MapXsize / VarPerByte;
float MinMapX = -7500;
float MinMapY = -7500;
float MaxMapX = 7500;
float MaxMapY = 7500;
int CellSize = 100;

/*/////////////////////////////////////////////////////////////////////////////*/

void setup()
{
  int ii = 0;
  size(1295, 815);
  smooth();

  CharFont = loadFont("HelveticaNeue-Bold-48.vlw"); 
  CharFontLight = loadFont("HelveticaNeue-UltraLight-48.vlw"); 
  StandardFont();
  
  FixFont = loadFont("Courier-Bold-48.vlw"); 
  
  bg = loadImage("Panel.gif");
  bgConfig = loadImage("EmptyPanel.png");
  bgDetails = loadImage("Panel.gif");
  bgSequencer = loadImage("EmptyPanel.png");
  background(bg); 
  
//  MeanValues = createWriter("Mean.txt"); 
//  MeanValues.print("*****************"+day()+"-"+month()+"-"+year()+"*****************"); 
//  MeanValues.println();
//  MeanValues.flush();
  
//  DetailValues = createWriter("Detail.txt"); 
//  DetailValues.print("*****************"+day()+"-"+month()+"-"+year()+"*****************"); 
//  DetailValues.println();
//  DetailValues.flush();
  
 //  BlankGrid = get(57,21,751,751);
  LedRedOn = loadImage("LedRedOn.gif");
  LedRedOff = loadImage("LedRedOff.gif");
  LedGreenOn = loadImage("LedGreenOn.gif");
  LedGreenOff = loadImage("LedGreenOff.gif");
  LedYellowOn = loadImage("LedYellowOn.gif");
  LedYellowOff = loadImage("LedYellowOff.gif");
  bN = loadImage("ReferenceButtonNormal.gif");
  bO = loadImage("ReferenceButtonOver.gif");
  bP = loadImage("ReferenceButtonPressed.gif");
  bNr = loadImage("ReferenceButtonNormalRed.gif");
  bOr = loadImage("ReferenceButtonOverRed.gif");
  bPr = loadImage("ReferenceButtonPressedRed.gif");  
  Gauge = loadImage("Gauge.png"); 
  GaugeTextField = loadImage("GaugeTextField.png"); 
  Knob = loadImage("Knob.png"); 
  InputField = loadImage("InputField.png");

  InputFieldsDefinition();
  LoadCfg();
  DefineButtons();
  DefineMainGrid();
  
  strokeWeight(3.0);
  stroke(255,0,0);
  
  if (! SimulationRS232Flag)
  {
    i=0;
    while(i< Serial.list().length)
    {
      SerialList = (append(SerialList, Serial.list()[i]));
      i++;
    }
  }
  else
  {
    i=1;
    while(i < 5)
    {
      SerialList = (append(SerialList, "COM"+i));
      i++;
    }
    SerialList = (append(SerialList, "All COM ports are simulated"));
  }
  
  controlP5 = new ControlP5(this);
  Slider s = controlP5.addSlider("bar",-500,500,0,1260,500,10,180);
  controlP5.controller("bar").setLabel("");
  controlP5.controller("bar").setValueLabel("");
//  controlP5.controller("bar").setColorForeground(255);

  SetInputFieldsRun();   // input fields for Main panel 
  SetInputFieldsConfig();    // input fields for Config panel 
  SetInputFieldsSequencer();    // input fields for Sequencer panel 
  SetInputFieldsDetails();   // input fields for Details panel 
  InputFieldsConfig();
  InputFieldsSequencer();
  InputFieldsDetails();
  InputFieldsRun();
}

// main loop --------------------------------------------------------------------
void draw()
{ 
  switch (PanelIndx)
  {
    case 1:
      controlP5.show();
      fill(255,255,255);
      MainPanel();
    break;
    
    case 2:
      controlP5.hide();
      ConfigPanel();
    break;
    
    case 3:
      controlP5.show();
      fill(255,255,255);
      DetailsPanel();
    break;
    
    case 4:
      controlP5.hide();
      SequencerPanel();
    break;
    
    default:
      MainPanel(); 
    break;
  }

  image(LedYellowOff,1169,700);
  IdleCount++;     // count idle period in ms
  if(IdleCount > 100)
  {
    IdleCount = 0;
    IdleTimeP = millis()-IdleTime;
    IdleTime=millis();
  }
  textAlign(CENTER);
  text(IdlePerc,1177,760);
  text("RX",1177,740);
  
  text(IdleTimeP/100, 1210, 760);
  text("Cycle",1210,740);
  
  text(Err, 1240, 760);
  text("TX",1240,740);
  
  if ((millis()-Cycle) > CyclePeriod)  // slow loop start------------------------
  {
    DisableSms();
   
    Cycle = millis();
    if (SimulationDrawFlag)          // simulation
    {
      Current = abs(DesSpeed*2);               // just for simulation
      MesSpeed = DesSpeed;                     // just for simulation 
      MesAngle = KnobAngle;                   // just for simulation     
      SimulationDrawing();
    }
    else
    {
        switch (PanelIndx)
        {
          case 1:  // main panel displays on graph and gauges the mean values and the position
            if (!PreInitRS232Flag && !StopFlag)
            {
              TxData(0, 'A', 0, 3);  // ask for all parameters
              Delay(3);              // wait for data to be received
              if (RxData('A',13))
              {// two bytes -> i int
                MesSpeed = Int16toint32(((RxBuff[HeadLen] << 8) + (RxBuff[HeadLen+1])));
                Current = (float)((RxBuff[HeadLen+2] << 8) + (RxBuff[HeadLen+3]));
                Xpos = Int16toint32((RxBuff[HeadLen+4] << 8) + (RxBuff[HeadLen+5]));
                Ypos = Int16toint32((RxBuff[HeadLen+6] << 8) + (RxBuff[HeadLen+7]));
                MesAngle = Int16toint32((RxBuff[HeadLen+8] << 8) + (RxBuff[HeadLen+9]));
                CompassAngle = (Int16toint32((RxBuff[HeadLen+10] << 8) + (RxBuff[HeadLen+11]))) / 10;
                IdlePerc = RxBuff[HeadLen+10];
 //               MeanValues.print(hour()+":"+minute()+":"+second()+"    "+MesSpeed+" "+Current+" "+Xpos+" "+Ypos+" "+MesAngle+" "+IdlePerc); 
 //               MeanValues.println();
               }
            }
            Graph(Xpos,Ypos);
          break;
    
          case 2:

          break;
    
          case 3:  // details panel displays on graph and gauges detailed valued
            if (!PreInitRS232Flag && !StopFlag)
            {
              TxData(0, 'a', 0, 3);  // ask for all parameters
              Delay(3);              // wait for data to be received
              if (RxData('a',12))
              {// two bytes -> i int
                Speed1[SpeedDataPtr] = Int16toint32(((RxBuff[HeadLen] << 8) + (RxBuff[HeadLen+1])));
                Speed2[SpeedDataPtr] = Int16toint32(((RxBuff[HeadLen+2] << 8) + (RxBuff[HeadLen+3])));
//                println(RxBuff[HeadLen]+" "+RxBuff[HeadLen+1]+" "+RxBuff[HeadLen+2]+" "+RxBuff[HeadLen+3]);
               
                Speed1[SpeedDataPtr] = (int)(Speed1[SpeedDataPtr] * Yk);
                Speed2[SpeedDataPtr] = (int)(Speed2[SpeedDataPtr] * Yk);
 //               Speed0[SpeedDataPtr] = (Speed1[SpeedDataPtr] + Speed2[SpeedDataPtr])/2;
                CurrentR = (float)((RxBuff[HeadLen+4] << 8) + (RxBuff[HeadLen+5]));     
                CurrentL = (float)((RxBuff[HeadLen+6] << 8) + (RxBuff[HeadLen+7])); 
 //               DetailValues.print(hour()+":"+minute()+":"+second()+"    "+Speed1[SpeedDataPtr]+" "+Speed2[SpeedDataPtr]+" "+CurrentR+" "+CurrentL); 
//                DetailValues.println();
              }
            }
            if (!StopFlag)  SpeedDataPtr+=SpeedDataStep;
          break;
          
          case 4:

          break;
    
          default:
            Graph(Xpos,Ypos);
          break;
        }
    }
    
    if (DesAnglePrev != DesAngle)
    {
      DesAnglePrev = DesAngle;
      TxIntValue[0] = (int)(DesAngle);
      TxData(0, 'O', 1, 1);
    }
    
    if (BlinkFlag)
    {
      BlinkFlag = false;
    }
    else 
    {
      BlinkFlag = true;
    }
  }                                    // slow loop end--------------------------
  
  LedBlink();
}
/*/////////////////////////////////////////////////////////////////////////////*/


