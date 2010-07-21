/*
In order to create a new knob using the common image already loaded:
just use the Knob() function with the parameters explained in function itself
*/

/*-----------------------------------------------------------------------------*/
void Knob(float KnobX, float KnobY, float KnobMin, float KnobMax, 
float AngleMin, float AngleMax, int KnobTick, String KnobDescr, String KnobUnit)  
{
  /* 
  KnobX     =  X Position of the center for the Knob
  KnobY     =  Y Position of the center for the Knob
  KnobMin   =  smallest value of the scale (positive or negative)
  KnobMax   =  greatest value of the scale
  AngleMin  =  position of the needle in the scale for Knobmin (degrees)
  AngleMax  =  position of the needle in the scale for KnobMax (degrees)
  KnobTick  =  number of the tick of the scale
  KnobDescr =  Description text for the value displayed
  KnobUnit =  Measurement unit 
  
  The Knob will be placed at KnobX, KnobY coordiantes in the screen.
  A scale will be drawn starting from AngleMin angle with KnobMin scale value 
    ending at AngleMax with KnobMax value. Any value in 0-360 range can be assigned
  A KnobTick number of reference signs will be displayed in the Knob. Of course
    it need to be choosen the right KnobTick value in order to display only integer
    numbers on the scale.
  Description field and measurement unit are displayed close to text field
  */

  int TextYshift = Z(112);  // text field distance from the center of the gauge
  int TextXshift = Z(28);
  int i;
  float TickX;
  float TickY;
  float TickX1;
  float TickY1;
  float TickX2;
  float TickY2;

  
  float KnobRadius;
  // the range is divided in KnobTick number of sectors
  // these values should be choosen properly to have a nice viewing
  float AngleStep = (AngleMax-AngleMin) / KnobTick; 
  float ScaleStep = (KnobMax - KnobMin) / KnobTick;

  /* The size of the knob is proportional to the background image "Knob"
      so the knob is resizable (in a certain range) simply choosing
      a different image.
  */
  KnobRadius = Knob.width*0.40;
  
  imageMode(CENTER);
  image(Knob, Z(KnobX), Z(KnobY));
  image(GaugeTextField, Z(KnobX), Z(KnobY+(Knob.width*0.675)));
  imageMode(CORNERS);
   // text field
//  text(nf(GaugeAngle,0,1), GaugeX,GaugeY+TextYshift);
  textAlign(RIGHT);
  text(KnobDescr, Z(KnobX-TextXshift),Z(KnobY+TextYshift));
  textAlign(LEFT);
  text(KnobUnit, Z(KnobX+TextXshift),Z(KnobY+TextYshift));
   textFont(CharFontLight, 11);   
   fill(0,0,0);
   textAlign(CENTER, CENTER);
   strokeWeight(1);
   stroke(0,0,0);
   float TempX;
   float TempY;
   float TempAngle;
   // scale drawing
   for (i=0; i<=KnobTick; i++)
    {
      TempAngle = AngleStep*i + AngleMin - 90;
      if (TempAngle != 360-90)
      {   
        TempX = cos(radians(TempAngle));
        TempY = sin(radians(TempAngle));
        TickX = KnobRadius * 1.37 * TempX + KnobX;
        TickY = KnobRadius * 1.37 * TempY + KnobY;
        TickX1 = KnobRadius * 1.2 * TempX + KnobX;
        TickY1 = KnobRadius * 1.2 * TempY + KnobY;
        TickX2 = KnobRadius * 1.1 * TempX + KnobX;
        TickY2 = KnobRadius * 1.1 * TempY + KnobY;
    
        text(nf(i*ScaleStep+KnobMin,0,0), Z(TickX), Z(TickY));
        line(TickX1, TickY1, TickX2, TickY2);
      }
    }
  StandardFont(); // restore standard font
 
  float KnobDx = mouseX - KnobX;
  float KnobDy = mouseY - KnobY;
  int Base = 3;
  pushMatrix();
  translate(Z(KnobX), Z(KnobY));
  if (mouseX >= Z(KnobX-KnobRadius) && mouseX <= Z(KnobX+KnobRadius) && 
      mouseY >= Z(KnobY-KnobRadius) && mouseY <= Z(KnobY+KnobRadius) &&
      mousePressed)
    {
      KnobAngle = atan2(KnobDy, KnobDx);  
    }
    
    if (SmsFlag)
    {//Sudden Motion Sensor
     KnobAngle = -radians(vals[0]+90);
    }

   rotate(KnobAngle);
   strokeWeight(7.0);
   stroke(67,85,100);
   triangle(Z(0),Z(-Base),Z(0),Z(Base),KnobRadius*0.78,0);
   popMatrix();
   KnobAngle1=degrees(KnobAngle+(PI/2));
   textAlign(CENTER);
   text(nf(KnobAngle1,0,1), KnobX,KnobY+115);
   DesAngle = KnobAngle1;
}

