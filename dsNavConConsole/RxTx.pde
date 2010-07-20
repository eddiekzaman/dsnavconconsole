/*-----------------------------------------------------------------------------*/
boolean RxData(char Cmd,int Len)
{
  int ChkSum = 0;

  if (! PreInitRS232Flag)  // RS232 initialized
  {
        if (RS232Port.available() <= 0)
        {
          RS232Port.clear();
          textAlign(LEFT);
          text("RX error:",1040,710);
          text("TMO - No RX",1040,725);;
          textAlign(CENTER);
          Err++;
          return false;
        }
        else
        {
          for (i=0; i < Len+HeadLen+1; i++)  // loop for all data expected and only for that
          {
            RxBuff[i] = (RS232Port.read());
          }
        }
      
      if (RxBuff[0] != '@')
      {
        RS232Port.clear();
        textAlign(LEFT);
        text("RX error:",1040,710);
        text("No Header",1040,725);
        text("Expected: @",1040,740);
        text("Found: " + (char)(RxBuff[0]),1040,755);
        textAlign(CENTER);
        Err++;
        return false;
      }
      else if (RxBuff[2] != Cmd)
      {
        RS232Port.clear();
        textAlign(LEFT);
        text("RX error:",1040,710);
        text("Wrong CMD",1040,725);
        text("Expected: "+Cmd,1040,740);
        text("Found: " + (char)(RxBuff[2]),1040,755);
        textAlign(CENTER);
        Err++;
        return false;
      }
      else if (RxBuff[3] != (Len+1))
      {
        RS232Port.clear();
        textAlign(LEFT);
        text("RX error:",1040,710);
        text("Wrong LEN",1040,725);
        text("Expected: "+Len,1040,740);
        text("Found: " + (RxBuff[3]-1),1040,755);
        textAlign(CENTER);
        Err++;
        return false;
      }
      
      for (i=0; i < Len+HeadLen; i++)  //  ChkSum excluded
      {
        ChkSum += (char)(RxBuff[i]);
      }
      ChkSum = ChkSum % 256;
      if (RxBuff[i] != ChkSum)
      {
        RS232Port.clear();
        textAlign(LEFT);
        text("RX error:",1040,710);
        text("ChkSum err",1040,725);
        text("Expected: "+RxBuff[i],1040,740);
        text("Found: " + ChkSum,1040,755);
        textAlign(CENTER);
        Err++;
        return false;
      }
      image(LedYellowOn,1169,700);
      return true;
  }
  return false;
}

/*-----------------------------------------------------------------------------*/  
void TxData(int Id, int Cmd, int ValueLen, int IntFlag)
{
/* Transmit a string toward dsNavCon board
   for a detailed description of protocol, see descrEng.txt in dsPID33 folder
*/
  int TxBuffCount;
  int ChkSum = 0;
  int CmdLen = 0;
  
  if (PreInitRS232Flag || SimulationRS232Flag)  // RS232 not ready or simulation
  {
    return;
  }
  
  if (IntFlag == 0)  // byte value
  {
    CmdLen = ValueLen;  
    for (TxBuffCount = 0; TxBuffCount < ValueLen; TxBuffCount++)
    {
      TxBuff[(TxBuffCount*2)+TxHeadLen] = (byte)(TxIntValue[TxBuffCount]);
    }
  }
  
  if (IntFlag == 1)  // integer value
  {
    CmdLen = ValueLen*2;          // 1 int value = 2 bytes to transmit
    for (TxBuffCount = 0; TxBuffCount < ValueLen; TxBuffCount++)
    {
      TxBuff[(TxBuffCount*2)+TxHeadLen] = (byte)(TxIntValue[TxBuffCount] >> 8);
      TxBuff[(TxBuffCount*2)+TxHeadLen+1] = (byte)(TxIntValue[TxBuffCount]);
    }
  }
  
  if (IntFlag == 2) // long value
  {
    CmdLen = ValueLen*4;        // 1 long value = 4 bytes to transmit
    for (TxBuffCount = 0; TxBuffCount < ValueLen; TxBuffCount++)
    {
      TxBuff[(TxBuffCount*4)+TxHeadLen] = (byte)(TxIntValue[TxBuffCount] >> 24);
      TxBuff[(TxBuffCount*4)+TxHeadLen+1] = (byte)(TxIntValue[TxBuffCount] >> 16);
      TxBuff[(TxBuffCount*4)+TxHeadLen+2] = (byte)(TxIntValue[TxBuffCount] >> 8);
      TxBuff[(TxBuffCount*4)+TxHeadLen+3] = (byte)(TxIntValue[TxBuffCount]);
    }
  }
  
  TxBuff[0] = (byte)('@');
  TxBuff[1] = (byte)(Id);
  TxBuff[2] = (byte)(Cmd);
  TxBuff[3] = (byte)(CmdLen+1);  // included CheckSum

  for (i=0;i<(TxHeadLen+CmdLen);i++) 
  {
   ChkSum += TxBuff[i];
  }
  TxBuff[TxHeadLen+CmdLen] = (byte)(ChkSum);
  
  for (i=0;i<(TxHeadLen+CmdLen+1);i++) 
  {
    RS232Port.write(TxBuff[i]);
//    println(TxBuff[i]);
   }
      
  if (IntFlag != 3) TxFlag = true; // avoid to blink TX led for continuos send
}

/*-----------------------------------------------------------------------------
void serialEvent(Serial p) 
{ 
    RxBuff[RxBuffCount] = (byte)(RS232Port.read());
        println(RxBuffCount+ " " +(char)(RxBuff[RxBuffCount]));
    RxBuffCount++;
}
*/

