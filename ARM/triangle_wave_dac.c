/***********************************************************************
* Program to Generate Triangle Waveform at DAC Output									  
* DAC Ouput = (VALUE / 1024) * Vref     => DAC Resolution = 10 Bits
* Vref = 2.2V fixed in trainer kit
************************************************************************/
#include "lpc213x.h"

//PLL Register Values
#define MSEL 4     //M-1 since M=5
#define PSEL 1<<5  //P-1 since P=2

#define AOUT 1<<19  // PINSEL1 value for AOUT config.

//Delay in Micro Sec.
void delay(int n)
{
int i,j;
for(i=0;i<n;i++)
 {for(j=0;j<5;j++)
    {;}
 }
}
/*-------------------------------------------------------*/
/*-------------------------------------------------------*/
/* Function Sets PLL0 So CPU Clock=60Mhz PCLK=15Mhz      */
/*-------------------------------------------------------*/
void clock_select(void)
{
//Fosc = 12Mhz
//Select CCLK = 60Mhz & Fcco = 240Mhz
PLLCFG = PSEL | MSEL;
//PLL FEED
PLLFEED=0xAA;
PLLFEED=0x55;

PLLCON = 3; //Enable PLL0
//PLL FEED
PLLFEED=0xAA;
PLLFEED=0x55;
VPBDIV  = 0; //PCLK = CCLK/4 So PCLK = 15Mhz
}
/*-------------------------------------------------------*/

int main(void)
{
 unsigned short val;  //16bit variable

 clock_select();  //CPU Clock Configuration

PINSEL0 = 0;      //Configure Port0.0 to P0.15 as General Purose IO
PINSEL1 = AOUT;   //Configure Port0.25 as Analog Output PIN

while(1)
  {

//Rising Edge
  for(val=0; val<1024; val++)
   {  DACR = val<<6;             //Send value to DAC
      delay(3);               //3 micro sec Delay
   }
//Falling Edge
  for(val=1023; val!=0; val--)
   {  DACR = val<<6;             //Send value to DAC
      delay(3);               //3 micro sec Delay
   }
  }
 }
/*-------------------------------------------------------*/
