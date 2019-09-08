#ifndef global_h
#define global_h

#include "note.h"


/****************************************/
/*
  DEFINES
*/

// Number of states
#define N 10

// Min time in milli seconds
#define PRESS_MIN_TIME 50

// Digital Pins
#define L1_PIN 3
#define L2_PIN 2
#define R1_PIN 4
#define R2_PIN 5
#define  X_PIN 6


/****************************************/
/*
  VARIÁVEIS GLOBAIS
*/

volatile unsigned long offtime_simple = 0;

uint8_t incBytes[] = {0, 0};
unsigned char incomingByte = '\0';
uint16_t commands = 0;

Note *red[N];
Note *green[N];
Note *yellow[N];
Note *blue[N];
Note *orange[N];

// Temporary variables
int ind=0, first_item=0;

#endif