/*
In order to create a new gauge using the common image already loaded:
just use the Gauge() function with the parameters explained in function itself
*/

/*-----------------------------------------------------------------------------*/
void GaugeAngleCompass()
{
   Gauge(950, 333, 0, 360, 0, 360, 12, CompassAngle, 99, (""), (""));
}

/*-----------------------------------------------------------------------------*/
void GaugeAngle()
{
if (SimulationDrawFlag)          // simulation
{
 Gauge(950,333,0,360,0,360,12,degrees(MesAngle)+90,1,("Mes.Angle="),("°"));
}
else
{
 Gauge(950, 333,  0, 360, 0, 360, 12, MesAngle, 1, ("Mes.Angle="), ("°"));
}
}

/*-----------------------------------------------------------------------------*/
void GaugeSpeed()
{
  Gauge(950, 112, -500, 500, -150, 150,  10, MesSpeed, 1, ("Speed="), ("mm/s"));

}

/*-----------------------------------------------------------------------------*/
void GaugeCurrent()
{
  Gauge(1162, 112, 0, 1000, -150, 150, 10, Current, 1, ("Current="), ("mA"));
}

/*-----------------------------------------------------------------------------*/
void GaugeCurrentR()
{
  Gauge(1162, 112, 0, 1000, -150, 150, 10, CurrentR, 1, ("Current R="), ("mA"));
}

/*-----------------------------------------------------------------------------*/
void GaugeCurrentL()
{
  Gauge(950, 112, 0, 1000, -150, 150, 10, CurrentL, 1, ("Current L="), ("mA"));
}

/*-----------------------------------------------------------------------------*/
void Gauge (float GaugeX, float GaugeY, float GaugeMin, float GaugeMax, 
float AngleMin, float AngleMax, int GaugeTick, float GaugeAngle, int GaugeColor, 
String GaugeDescr, String GaugeUnit)
{
  /* 
  GaugeX    =  X Position of the center for the gauge
  GaugeY    =  Y Position of the center for the gauge
  GaugeMin  =  smallest value of the scale (positive or negative)
  GaugeMax  =  greatest value of the scale
  AngleMin  =  position of the needle in the scale for GaugeMin (degrees)
  AngleMax  =  position of the needle in the scale for GaugeMax (degrees)
  GaugeTick =  number of the tick of the scale
  GaugeAngle=  value to display with the needle and in the text field
  GaugeColor=  needle color: 1 = red, 2 = green, 3 = blu, 99 = no scale and no text 
               field. Useful to display a second needle on the the same gauge
  GaugeDescr=  Description text for the value displayed
  GaugeUnit =  Measurement unit 
  
  The instrument will be placed at GaugeX, GaugeY coordiantes in the screen.
  A scale will be drawn starting from AngleMin angle with GaugeMin scale value 
    ending at AngleMax with GaugeMax value. Any value in 0-360 range can be assigned
  A GaugeTick number of reference signs will be displayed in the instrument. Of course
    it need to be choosen the right GaugeTick value in order to display only integer
    numbers on the scale.
  Description field and measurement unit are displayed close to text field
  */
  
  int NeedleBase = 2; //the needle is a triangle with base= NeedleBase and height=GaugeRadius
  float GaugeRadius;
  int TextYshift = 112;  // text field distance from the center of the gauge
  int TextXshift = 28;
  int GaugeR;
  int GaugeG;
  int GaugeB;     
  int i;
  float TickX;
  float TickY;
  float TickX1;
  float TickY1;
  float TickX2;
  float TickY2;

  // the measurement range is divided in GaugeTick number of sectors
  // these values should be choosen properly to have a nice viewing
  float AngleStep = (AngleMax-AngleMin) / GaugeTick; 
  float ScaleStep = (GaugeMax - GaugeMin) / GaugeTick;

  /* The size of the gauge is proportional to the background image "Gauge"
      so the instrument is resizable (in a certain range) simply choosing
      a different image.
  */
  GaugeRadius = Gauge.width*0.4;

  if (GaugeColor != 99)  // if == 99 only the needle will be drawn
  {
    imageMode(CENTER);
    image(Gauge, Z(GaugeX), Z(GaugeY));
    image(GaugeTextField, Z(GaugeX), Z(GaugeY)+(Z(Gauge.width*0.66)));
    imageMode(CORNERS);
     // text field
    text(nf(GaugeAngle,0,1), Z(GaugeX),Z(GaugeY)+Z(TextYshift));
    textAlign(RIGHT);
    text(GaugeDescr, Z(GaugeX-TextXshift),Z(GaugeY+TextYshift));
    textAlign(LEFT);
    text(GaugeUnit, Z(GaugeX+TextXshift),Z(GaugeY+TextYshift));
     textFont(CharFontLight, 11);   
     fill(0,0,0);
     textAlign(CENTER, CENTER);
     strokeWeight(1);
     stroke(0,0,0);
     float TempX;
     float TempY;
     float TempAngle;
     // scale drawing
     for (i=0; i<=GaugeTick; i++)
      {
        TempAngle = AngleStep*i + AngleMin - 90;
        if (TempAngle != 360-90)
        {   
          TempX = cos(radians(TempAngle));
          TempY = sin(radians(TempAngle));
          TickX = GaugeRadius * 0.9 * TempX + GaugeX;
          TickY = GaugeRadius * 0.9 * TempY + GaugeY;
          TickX1 = GaugeRadius * 1.2 * TempX + GaugeX;
          TickY1 = GaugeRadius * 1.2 * TempY + GaugeY;
          TickX2 = GaugeRadius * 1.1 * TempX + GaugeX;
          TickY2 = GaugeRadius * 1.1 * TempY + GaugeY;
      
          text(nf(i*ScaleStep+GaugeMin,0,0), Z(TickX), Z(TickY));
          line(TickX1, TickY1, TickX2, TickY2);
        }
      } 
  StandardFont(); // restore standard font
  }
  
  switch (GaugeColor)  // color of the needle
  { 
    case 1: // red
  	GaugeR = 255;
  	GaugeG = 0;
  	GaugeB = 0;
    break;
  
    case 2: // green
        GaugeR = 0;
  	GaugeG = 255;
  	GaugeB = 0;
    break;
  
    case 3: // blue
   	GaugeR = 0;
  	GaugeG = 0;
  	GaugeB = 255;
    break;
    
    default:
   	GaugeR = 0;
  	GaugeG = 0;
  	GaugeB = 255;
    break;
  }
  
  // needle drawing
  pushMatrix();
  translate(Z(GaugeX), Z(GaugeY));
  rotate(radians((GaugeAngle-GaugeMin) * (AngleMax - AngleMin) / (GaugeMax - GaugeMin) - 90 + AngleMin));
  strokeWeight(3.0);
  stroke(GaugeR, GaugeG, GaugeB);
  triangle(Z(15),Z(-NeedleBase),Z(15),Z(NeedleBase),Z(GaugeRadius),0);
  popMatrix();
  textAlign(CENTER);
}

