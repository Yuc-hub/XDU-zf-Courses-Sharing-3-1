#include <reg52.h>

// ?? 74HC138 ????
sbit ADDR0 = P1^0; // 74HC138:A0
sbit ADDR1 = P1^1; // 74HC138:A1
sbit ADDR2 = P1^2; // 74HC138:A2
sbit ADDR3 = P1^3; // 74HC138:E3 ?????
sbit EN = P1^4;    // 74HC138:E1, E2 ?????

// ?? LED ??
sbit LED0 = P0^0;  // LED ?????

void main() {
    // ??? 74HC138
    ADDR3 = 1; // E3 ?????
    EN = 0;    // E1, E2 ?????

    // ?? 74HC138
    ADDR0 = 0;
    ADDR1 = 1;
    ADDR2 = 1; // 74HC138: Y6 = 0,Y0-Y5,Y7 = 1

    while (1) {
        LED0 = 0; // ?? LED
    }
}
