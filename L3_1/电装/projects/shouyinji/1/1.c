/**************************************************************************
 * ??:TEA5767+LCD1602 ??
 * ??:TEA5767+LCD1602 ???
 ***************************************************************************/

#include <reg52.h>
#include "delay.h"
#include "iic.h"
#include "tea5767.h"
#include "lcd1602.h"
#include "ds18b20.h"
#include "ds1302.h"

// ??????
sbit s0 = P2^0;
sbit s1 = P2^4;  // ?????
sbit s2 = P2^5;  // ?????
sbit s3 = P2^6;  // ?????
sbit s4 = P2^7;  // ?????

extern unsigned long frequency; // tea5767 ??????,? tea5767.c ???
extern unsigned char second, minute, hour, week, day, month, year; // DS1302 ?????

unsigned char code table[] = { '.', 'C' };
unsigned char code table1[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

/**************************************************************************
 * ????:shouyin_display(unsigned long sy)
 * ????:??????
 * ????:sy
 * ????:?
 ***************************************************************************/
void shouyin_display(unsigned long sy) {
    write_com(0x80 + 0x40 + 2); 
    write_data('F');
    delayms(1);
    write_com(0x80 + 0x40 + 3); 
    write_data('M');
    delayms(1);
    write_com(0x80 + 0x40 + 4); 
    write_data(':');
    delayms(1);
    write_com(0x80 + 0x40 + 5); 
    write_data(table1[sy / 100000]);
    delayms(1);
    write_com(0x80 + 0x40 + 6); 
    write_data(table1[sy % 100000 / 10000]);
    delayms(1);
    write_com(0x80 + 0x40 + 7); 
    write_data(table1[sy % 100000 % 10000 / 1000]);
    delayms(1);
    write_com(0x80 + 0x40 + 8); 
    write_data('.');
    delayms(1);
    write_com(0x80 + 0x40 + 9); 
    write_data(table1[sy % 100000 % 10000 % 1000 / 100]);
    delayms(1);
    write_com(0x80 + 0x40 + 10); 
    write_data('M');
    delayms(1);
    write_com(0x80 + 0x40 + 11); 
    write_data('H');
    delayms(1);
    write_com(0x80 + 0x40 + 12); 
    write_data('z');
    delayms(1);
}

/**************************************************************************
 * ????:shoukey()
 * ????:??????
 * ????:?
 * ????:?
 ***************************************************************************/
void shoukey() {
    if (s1 == 0) {
        delayms(1);
        if (s4 == 0) {
            search(0);
            while (!s4);
        }
    }
    if (s2 == 0) {
        delayms(1);
        if (s3 == 0) {
            search(1);
            while (!s3);
        }
    }
    if (s3 == 0) {
        delayms(1);
        if (s2 == 0) {
            auto_search(0);
            while (!s2);
        }
    }
    if (s4 == 0) {
        delayms(1);
        if (s1 == 0) {
            auto_search(1);
            while (!s1);
        }
    }
}

/**************************************************************************
 * ????:Display_18b20(uint t)
 * ????:??????
 * ????:?
 * ????:?
 ***************************************************************************/
void Display_18b20(uint t) {
    uchar A1, A2, A3;
    uchar i;

    A1 = t / 100;        // ??
    A2 = t % 100 / 10;   // ??
    A3 = t % 10;         // ??

    write_com(0x80 + 0x0A);
    write_data(table1[A1]);
    delayms(5);
    write_com(0x80 + 0x0B);
    write_data(table1[A2]);
    delayms(5);
    i = 0;
    write_com(0x80 + 0x0C);
    write_data(table[0]);
    delayms(5);
    write_com(0x80 + 0x0D);
    write_data(table1[A3]);
    delayms(5);
    write_com(0x80 + 0x0E);
    write_data('^');
    delayms(5);
    i = 1;
    write_com(0x80 + 0x0F);
    write_data(table[1]);
    delayms(5);
}

/**************************************************************************
 * ????:Display_1302()
 * ????:ds1302 ????
 * ????:?
 * ????:?
 ***************************************************************************/
void Display_1302() {
    write_com(0x80 + 0x00);
    write_data(table1[hour / 10 % 10]);
    delayms(1);
    write_com(0x80 + 0x01);
    write_data(table1[hour % 10]);
    delayms(1);
    write_com(0x80 + 0x02);
    write_data(':');
    delayms(1);
    write_com(0x80 + 0x03);
    write_data(table1[minute / 10 % 10]);
    delayms(1);
    write_com(0x80 + 0x04);
    write_data(table1[minute % 10]);
    delayms(1);
    write_com(0x80 + 0x05);
    write_data(':');
    delayms(1);
    write_com(0x80 + 0x06);
    write_data(table1[second / 10 % 10]);
    delayms(1);
    write_com(0x80 + 0x07);
    write_data(table1[second % 10]);
    delayms(1);
}

void main() {
    s0 = 0;
    InitDS1302();
    lcd1602_init();
    iic_init();
    init_tea5767();

    while (1) {
        DS1302ReadTime();
        Display_1302();            // ????
        Display_18b20(Get_Tmp()); // ????
        shouyin_display(frequency); // ????
        shoukey();                 // ??????
    }
}
