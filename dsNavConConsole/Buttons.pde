/*
In order to create a new button using the common image already loaded:
- define a new button in global definitions area
      ImageButtons YourButtonName;
- Create the button in DefineButtons() function
      YourButtonName = new ImageButtons(YourButtonXposition, YourButtonYposition, "YourButtonLabel", YourButtonColor);
- Use your button
       YourButtonName.update();
        if (YourButtonName.released)
        {
              put here the code to be executed when 
              the button is pressed and released
        }
        BtnSendSpeed.display();

*/
/*-----------------------------------------------------------------------------*/
void DefineButtons()
{  
 // Define and create image button for Main panel *************************
  BtnConfig = new ImageButtons(Z(845), Z(772), "Config", 1);
  BtnQuit = new ImageButtons(Z(945), Z(772), "Quit", 1);
  BtnRun = new ImageButtons(Z(845), Z(772), "Main", 1);
  BtnSendSpeed = new ImageButtons(Z(1170), Z(500), "Send", 1);
  BtnSendDist = new ImageButtons(Z(1170), Z(550), "Send", 1);
  BtnSendXY = new ImageButtons(Z(1170), Z(600), "Send", 1);
  BtnSendVersion = new ImageButtons(Z(1170), Z(650), "Version", 1);
  BtnSendHalt = new ImageButtons(Z(845), Z(500), "Halt", 1);
  BtnCamOn = new ImageButtons(Z(845), Z(650), "Cam Off", 0);
  BtnCamOff = new ImageButtons(Z(845), Z(650), "Cam On", 1);
  BtnSendReset = new ImageButtons(Z(945), Z(685), "Reset", 1);
  BtnStartSeq = new ImageButtons(Z(845), Z(685), "Start Seq", 1);
  BtnDebugOff = new ImageButtons(Z(845), Z(738), "Debug On", 1);
  BtnDebugOn = new ImageButtons(Z(845), Z(738), "Debug Off", 0);
  BtnSim = new ImageButtons(Z(845), Z(738), "Sim", 2);  
  BtnStopOff = new ImageButtons(Z(945), Z(738), "Rx Stop", 1);
  BtnStopOn = new ImageButtons(Z(945), Z(738), "Rx Go", 0);
  BtnSensors = new ImageButtons(Z(945), Z(738), "Sensors", 2);
  BtnSms = new ImageButtons(Z(0), Z(0), "SMS", 1);  
  BtnMap = new ImageButtons(Z(845), Z(550), "Map", 1);  
    
  // Define and create image button for Config panel *************************
  BtnDet = new ImageButtons(Z(945), Z(772), "Details", 1);
  BtnSendCfgKSpeed1 = new ImageButtons(Z(1190), Z(59), "Send", 1);
  BtnSendCfgKSpeed2 = new ImageButtons(Z(1190), Z(69), "Send", 1);
  BtnSendCfgKAngle = new ImageButtons(Z(1190), Z(172), "Send", 1);
  BtnSendCfgKDist = new ImageButtons(Z(1190), Z(229), "Send", 1);
  BtnSendCfgWheels = new ImageButtons(Z(1190), Z(285), "Send", 1);
  BtnSendCfgKvel = new ImageButtons(Z(1190), Z(340), "Send", 1);
  BtnSendCfgRS232 = new ImageButtons(Z(1190), Z(400), "Send", 1);
  BtnSendError = new ImageButtons(Z(1190), Z(456), "Error", 1);
  BtnSendCfgLoad = new ImageButtons(Z(845), Z(738), "Load", 1);
  BtnSendCfgSave = new ImageButtons(Z(945), Z(738), "Save", 1);
  BtnSendMainGrid = new ImageButtons(Z(35), Z(59), "Send", 1);
  BtnSendMainSet = new ImageButtons(Z(35), Z(172), "Send", 1);
  BtnSendDetailGrid = new ImageButtons(Z(35), Z(229), "Send", 1);
  BtnSendDetailSet = new ImageButtons(Z(35), Z(342), "Send", 1);
  BtnSendCycle = new ImageButtons(Z(35), Z(399), "Send", 1);
  BtnSendCam = new ImageButtons(Z(35), Z(456), "Send", 1);
    
  // Define and create image button for Sequencer panel **********************  
  BtnSeqL = new ImageButtons(Z(945), Z(772), "Sequencer", 1);
  BtnSeqR = new ImageButtons(Z(845), Z(772), "Sequencer", 1);
  BtnSendSeq = new ImageButtons(Z(35), Z(59), "Send", 1);
}

/*-----------------------------------------------------------------------------*/
void mouseReleased()
{      
  ReleasedFlag = true;
}

/*-----------------------------------------------------------------------------*/
class Button 
{
  int x, y;
  int w, h;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean over = false;
  boolean pressed = false;   
  boolean released = false;   
    
  void pressed() {
    if(over && mousePressed) {
      pressed = true;
    } else {
      pressed = false;
    }    
  }
    
  void released() {
    if(over && ReleasedFlag) {
      released = true;
      ReleasedFlag = false;
    } else {
      released = false;
    }    
  }

  boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
}

class ImageButtons extends Button 
{
  /* three sets of images are defined for buttons, the main and an 2 alternativs
     sometime used to show a toggle button.
     Three images are needed for each set:
     Normal viewing
     Mouse over viewing
     Pressed viewing
     Each button will be customized with text passed to this function
  */
  
  PImage currentimage;
  PImage Nimage;
  PImage Oimage;
  PImage Pimage;
    
  int w = bN.width;
  int h = bN.height;
  String bLabel;
  int Color;

  ImageButtons(int ix, int iy, String ibLabel, int iColor) 
  {
    x = ix;
    y = iy;
    bLabel = ibLabel;
    Color = iColor;
    if (Color == 1)
    {
      Nimage = bN;
      Oimage = bO;
      Pimage = bP;
    }
    else if (Color == 0)
    {
      Nimage = bNr;
      Oimage = bOr;
      Pimage = bPr;
    }
   else if (Color == 2)
    {
      Nimage = bNg;
      Oimage = bOg;
      Pimage = bPg;
    }
    currentimage = Nimage;
  }
  
  void update() 
  {
    over();
    pressed();
    released();
      if(pressed) 
      {
        currentimage = Pimage;
      } 
      else if (over)
      {
        currentimage = Oimage;
      } 
      else 
      {
        currentimage = Nimage;
      }
  }
  
  void over() 
  {
    if( overRect(x, y, w, h) ) {
      over = true;
    } else {
      over = false;
    }
  }
  
  void display() 
  {
    image(currentimage, x, y);
    textFont(CharFont, Z(14)); 
    textAlign(CENTER,CENTER);
    // customization label for the specific button written at the center of the image
    text(bLabel,x+w/2,y+h/2);
    StandardFont();
  }
}


