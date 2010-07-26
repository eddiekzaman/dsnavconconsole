/*-----------------------------------------------------------------------------*/
void RxError(int ErrCode, char Cmd, int Len, int ChkSum)
{
  RS232Port.clear();
  RxErrorDispTime = 100;
  
  switch (ErrCode)
  {
    case 1: // Timeout
      RxErrorText= "TMO - No RX";
      RxErrorExpected = ' ';
      RxErrorFound = ' ';
    break;
    
    case 2: // no header found
      RxErrorText= "No Header";
      RxErrorExpected = '@';
      RxErrorFound =(char)(RxBuff[0]);
    break;
    
    case 3: // the command received doesn't match what expected
      RxErrorText= "Wrong CMD";
      RxErrorExpected = Cmd;
      RxErrorFound = (char)(RxBuff[2]);
    break;
      
    case 4:
      RxErrorText= "Wrong LEN";
      RxErrorExpected = (char)(Len);
      RxErrorFound = (char)(RxBuff[3]-1);
    break;

    case 5:
      RxErrorText= "ChkSum err";
      RxErrorExpected = (char)(+RxBuff[i]);
      RxErrorFound = (char)(ChkSum);
    break;

    default:
      RxErrorText= "--RX OK--";
      RxErrorExpected = ' ';
      RxErrorFound =  ' ';
    break;
  
  }
  
  Err++;
} 
/*-----------------------------------------------------------------------------*/
boolean RxData(char Cmd,int Len)
{
  int ChkSum = 0;
  
  Delay(Len);              // wait for data to be received
  
  if (! PreInitRS232Flag)  // RS232 initialized
  {
        if (RS232Port.available() <= 0)
        {
          RxError(1, Cmd, Len, ChkSum);
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
        RxError(2, Cmd, Len, ChkSum);
        return false;
      }
      else if (RxBuff[2] != Cmd)
      {
        RxError(3, Cmd, Len, ChkSum);
        return false;
      }
      else if (RxBuff[3] != (Len+1))
      {
        RxError(4, Cmd, Len, ChkSum);
        return false;
      }
      
      for (i=0; i < Len+HeadLen; i++)  //  ChkSum excluded
      {
        ChkSum += (char)(RxBuff[i]);
      }
      ChkSum = ChkSum % 256;
      if (RxBuff[i] != ChkSum)
      {
        RxError(5, Cmd, Len, ChkSum);
        return false;
      }
      image(LedYellowOn,Z(1169),Z(700));
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
  
  Delay(ValueLen);              // wait for data to be transmitted
}

/*-----------------------------------------------------------------------------
void serialEvent(Serial p) 
{ 
    RxBuff[RxBuffCount] = (byte)(RS232Port.read());
        println(RxBuffCount+ " " +(char)(RxBuff[RxBuffCount]));
    RxBuffCount++;
}
*/

