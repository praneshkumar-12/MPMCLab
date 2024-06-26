/***********************************************************************
* Program to Generate Square Wave at DAC Output									  
* Square wave Frequency fixed to 500Hz
* DAC Ouput = (VALUE / 1024) * Vref     => DAC Resolution = 10 Bits
* Vref = 2.2V fixed in trainer kit
************************************************************************/
#include "lpc214x.h"

//PLL Register Values
#define MSEL 4     //M-1 since M=5
#define PSEL 1<<5  //P-1 since P=2

#define AOUT 1<<19  // PINSEL1 value for AOUT config.

void delayms(int n)
{
int i,j;
for(i=0;i<n;i++)
 {for(j=0;j<5035;j++)   //5035 for 60Mhz ** 1007 for 12Mhz
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
PLL0CFG = PSEL | MSEL;
//PLL FEED
PLL0FEED=0xAA;
PLL0FEED=0x55;

PLL0CON = 3; //Enable PLL0
//PLL FEED
PLL0FEED=0xAA;
PLL0FEED=0x55;
VPBDIV  = 0; //PCLK = CCLK/4 So PCLK = 15Mhz
}
/*-------------------------------------------------------*/

int main(void)
{

 clock_select();  //CPU Clock Configuration

PINSEL0 = 0;      //Configure Port0.0 to P0.15 as General Purose IO
PINSEL1 = AOUT;   //Configure Port0.25 as Analog Output PIN

while(1)
  {
    DACR = 0;               //DAC ouput = 0V
    delayms(1);             //1 msec Delay
    DACR = 0x3FF << 6;      //DAC ouput = 2.2V
    delayms(1);             //1 mSec Delay
   }
}
/*-------------------------------------------------------*/
