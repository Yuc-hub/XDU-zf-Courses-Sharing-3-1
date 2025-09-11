/***************************************************************************
 * ??:????????? 0-F
 * ??:?????????,?????,??????? 0-F
 ****************************************************************************/

#include <reg52.h>

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

unsigned int num = 0;
unsigned char i = 0; // ????????
unsigned char key_value = 0; // ?????

#define KeyPort P2

/***************************************************************************
 * ????:delayms()
 * ????:???????? 1ms
 * ????:t:0~65535
 * ????:?
 ****************************************************************************/
void delayms(unsigned int t) {
    unsigned char i; // ????????
    unsigned int j;
    for (i = t; i > 0; i--)
        for (j = 110; j > 0; j--);
}

/***************************************************************************
 * ????:display()
 * ????:???????
 * ????:?
 * ????:?
 ****************************************************************************/
void display() {
    switch (i) {
        case 0: // ??????
            ADDR0 = 0; ADDR1 = 0; ADDR2 = 0; // 74HC138: Y0 = 0,Y1-Y7 = 1
            i = 0;
            P0 = display_code[key_value];
            break;
    }
    delayms(1);
    P0 = 0xFF; // ???????,?????;????????,????,??????????
}

/***************************************************************************
 * ????:keyscan()
 * ????:??????????
 * ????:?
 * ????:?
 ****************************************************************************/
void keyscan() {
    unsigned char temp;

    // ???????
    KeyPort = 0xFE;
    temp = KeyPort & 0xF0;
    if (temp != 0xF0) { // ????
        delayms(10); // ?????
        temp = KeyPort; // ????
        if (temp != 0xF0) { // ????????
            temp = KeyPort; // ????????? temp
            switch (temp) { // ?? temp ??
                case 0xEE: key_value = 1; break;
                case 0xDE: key_value = 2; break;
                case 0xBE: key_value = 3; break;
                case 0x7E: key_value = 15; break;
            }
        }
    }
    // ?????
    KeyPort = 0xFD;
    temp = KeyPort & 0xF0;
    if (temp != 0xF0) { // ????
        delayms(10); // ?????
        temp = KeyPort; // ????
        if (temp != 0xF0) { // ????????
            temp = KeyPort; // ????????? temp
            switch (temp) { // ?? temp ??
                case 0xED: key_value = 4; break;
                case 0xDD: key_value = 5; break;
                case 0xBD: key_value = 6; break;
                case 0x7D: key_value = 14; break;
            }
        }
    }
    // ?????
    KeyPort = 0xFB;
    temp = KeyPort & 0xF0;
    if (temp != 0xF0) { // ????
        delayms(10); // ?????
        temp = KeyPort; // ????
        if (temp != 0xF0) { // ????????
            temp = KeyPort; // ????????? temp
            switch (temp) { // ?? temp ??
                case 0xEB: key_value = 7; break;
                case 0xDB: key_value = 8; break;
                case 0xBB: key_value = 9; break;
                case 0x7B: key_value = 13; break;
            }
        }
    }
    // ?????
    KeyPort = 0xF7;
    temp = KeyPort & 0xF0;
    if (temp != 0xF0) { // ????
        delayms(10); // ?????
        temp = KeyPort; // ????
        if (temp != 0xF0) { // ????????
            temp = KeyPort; // ????????? temp
            switch (temp) { // ?? temp ??
                case 0xE7: key_value = 10; break;
                case 0xD7: key_value = 11; break;
                case 0xB7: key_value = 12; break;
                case 0x77: key_value = 0; break;
            }
        }
    }
}

void main() {
    // ??? 74HC138
    ADDR3 = 1; // E3 ?????
    EN = 0;    // E1, E2 ?????

    ADDR0 = 0;
    ADDR1 = 1;
    ADDR2 = 1; // 74HC138: Y6 = 0; Y1~Y5, Y7 = 1

    P0 = 0xFF; // ?????,???????

    while (1) {
        keyscan(); // ????
        display(); // ????????
    }
}
