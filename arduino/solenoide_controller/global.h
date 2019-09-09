#ifndef global_h
#define global_h

#include "queue.h"
#include "note.h"
/****************************************/
/*
  DEFINES
*/

// Number of states
#define N_STATES 5

// Digital Pins
#define L1_PIN 3
#define L2_PIN 2
#define R1_PIN 4
#define R2_PIN 5
#define X_PIN 6

// Commands

// B0 - APERTO SIMPLES VERDE
// B1 - APERTO SIMPLES VERMELHO
// B2 - APERTO SIMPLES AMARELO
// B3 - APERTO SIMPLES AZUL
// B4 - APERTO SIMPLES LARANJADO
// B5 - APERTO SEM SOLTAR VERDE
// B6 - APERTO SEM SOLTAR VERMELHO
// B7 - APERTO SEM SOLTAR AMARELO
// B8 - APERTO SEM SOLTAR AZUL
// B9 - APERTO SEM SOLTAR LARANJADO
// B10 - SOLTA VERDE
// B11 - SOLTA VERMELHO
// B12 - SOLTA AMARELO
// B13 - SOLTA AZUL
// B14 - SOLTA LARANJADO
// B15 - 0 (será utilizado para configurações)

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

volatile unsigned long OFFTIME = 0;

uint8_t input_byte = {0, 0};
uint16_t command = 0;

// Inicializa a fila de estados das Notas
Queue<Note> note_green = new Queue<Note>(N_STATES);
Queue<Note> note_red = new Queue<Note>(N_STATES);
Queue<Note> note_yellow = new Queue<Note>(N_STATES);
Queue<Note> note_blue = new Queue<Note>(N_STATES);
Queue<Note> note_orange = new Queue<Note>(N_STATES);

Queue<Note> trail_green = new Queue<Note>(N_STATES);
Queue<Note> trail_red = new Queue<Note>(N_STATES);
Queue<Note> trail_yellow = new Queue<Note>(N_STATES);
Queue<Note> trail_blue = new Queue<Note>(N_STATES);
Queue<Note> trail_orange = new Queue<Note>(N_STATES);

#endif