#ifndef global_h
#define global_h

#include "note.h"

/****************************************/
/*
  DEFINES
*/

// Number of states
#define N_STATES 10

// Min time in micro seconds
#define PRESS_MIN_TIME 50000

// Digital Pins
#define L1_PIN 3
#define L2_PIN 2
#define R1_PIN 4
#define R2_PIN 5
#define X_PIN 6

// Commands
// #define B0 00000000
// #define B1 00000001
// #define B2 00000010
// #define B3 00000011
// #define B4 00000100
// #define B5 00000101
// #define B6 00000110
// #define B7 00000111
// #define B8 00001000
// #define B9 00001001
// #define B10 00001010
// #define B11 00001011
// #define B12 00001100
// #define B13 00001101
// #define B14 00001110
// #define B15 00001111

/****************************************/
/*
  VARIÁVEIS GLOBAIS
*/

volatile unsigned long offtime = 0;

uint8_t input_byte = {0, 0};
uint16_t command = 0;
unsigned char incomingByte = '\0';

// Temporary variables
int first_item = 0;

// Define Contadores de indíce
short index_note_green = 0;
short index_note_red = 0;
short index_note_yellow = 0;
short index_note_blue = 0;
short index_note_orange = 0;

short index_trail_green = 0;
short index_trail_red = 0;
short index_trail_yellow = 0;
short index_trail_blue = 0;
short index_trail_orange = 0;

Note *red[N_STATES];
Note *green[N_STATES];
Note *yellow[N_STATES];
Note *blue[N_STATES];
Note *orange[N_STATES];

#endif