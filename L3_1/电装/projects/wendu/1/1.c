/***************************************************************************
 * ??:???????
 * ??:?? DS18B20 ????
 ****************************************************************************/

#include <reg52.h>
#include "ds18b20.h"

// ?? 74HC138 ????
sbit ADDR0 = P1^0; // 74HC138:A0
sbit ADDR1 = P1^1; // 74HC138:A1
sbit ADDR2 = P1^2; // 74HC138:A2
sbit ADDR3 = P1^3; // 74HC138:E3 ?????
sbit EN = P1^4;    // 74HC138:E1, E2 ?????

// ????? code ??????? Flash ?,????? RAM
unsigned char code display_code[] = {
    /* 0    1    2    3    4    5    6    7    8    9    A    b    c    d    E    F */
    0xc0, 0xf9, 0xa4, 0xb0, 0x99, 0x92, 0x82, 0xf8, 0x80, 0x90, 0x88, 0x83, 0xa7, 0xa1, 0x86, 0x8e
};

void delayms(unsigned int t) {
    unsigned char i; // ????????
    unsigned int j;
    for (i = t; i > 0; i--)
        for (j = 110; j > 0; j--);
}

void main() {
    unsigned char bai, shi, ge;
    unsigned char i = 0; // ????????
    unsigned int temp;   // ????

    // ??? 74HC138
    ADDR3 = 1; // E3 ?????
    EN = 0;    // E1, E2 ?????

    P0 = 0xFF; // ????????

    while (1) {
        temp = Get_Tmp(); // ????
        
        // ?????????????
        bai = temp / 100;       // ??
        shi = (temp % 100) / 10; // ??
        ge = temp % 10;         // ??

        // ?????
        switch (i) {
            case 0: // ??????
                ADDR0 = 0; ADDR1 = 0; ADDR2 = 0; // 74HC138: Y0 = 0,Y1-Y7 = 1
                i++;
                P0 = display_code[ge];
                break;
            case 1: // ??????
                ADDR0 = 1; ADDR1 = 0; ADDR2 = 0; // 74HC138: Y1 = 0,Y0,Y2-Y7 = 1
                i++;
                P0 = display_code[shi];
                break;
            case 2: // ??????
                ADDR0 = 0; ADDR1 = 1; ADDR2 = 0; // 74HC138: Y2 = 0,Y0,Y1,Y3-Y7 = 1
                i = 0;
                P0 = display_code[bai];
                break;
        }

        delayms(1);
        P0 = 0xFF; // ???????,??,??????
    }
}
