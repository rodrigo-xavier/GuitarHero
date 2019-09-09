#ifndef global_h
#define global_h

/****************************************/
/*INCLUDES*/

#include <Arduino.h>
#include "queue.h"
#include "note.h"

/****************************************/
/*DEFINES*/

// Number of states
#define N_STATES 5

// Digital Pins
#define L1_PIN 3
#define L2_PIN 2
#define R1_PIN 4
#define R2_PIN 5
#define X_PIN 6

/****************************************/
// COMMANDS

// #define B0 0000000000000000 // B0 - APERTO SIMPLES VERDE
// #define B1 0000000000000001 // B1 - APERTO SIMPLES VERMELHO
// #define B2 0000000000000010 // B2 - APERTO SIMPLES AMARELO
// #define B3 0000000000000100 // B3 - APERTO SIMPLES AZUL
// #define B4 0000000000001000 // B4 - APERTO SIMPLES LARANJADO
// #define B5 0000000000010000 // B5 - APERTO SEM SOLTAR VERDE
// #define B6 0000000000100000 // B6 - APERTO SEM SOLTAR VERMELHO
// #define B7 0000000001000000 // B7 - APERTO SEM SOLTAR AMARELO
// #define B8 0000000010000000 // B8 - APERTO SEM SOLTAR AZUL
// #define B9 0000000100000000 // B9 - APERTO SEM SOLTAR LARANJADO
// #define B10 0000010000000000 // B10 - SOLTA VERDE
// #define B11 0000100000000000 // B11 - SOLTA VERMELHO
// #define B12 0001000000000000 // B12 - SOLTA AMARELO
// #define B13 0010000000000000 // B13 - SOLTA AZUL
// #define B14 0100000000000000 // B14 - SOLTA LARANJADO
// #define B15 1000000000000000 // B15 - 0 (será utilizado para configurações)

/****************************************/
/*VARIÁVEIS GLOBAIS*/

// Definir um valor grande até que o valor verdadeiro seja setado
volatile unsigned long OFFTIME = 9999999999;

uint8_t input_byte[] = {0, 0};
uint16_t command = 0;

class Note;
// class Queue;

// Inicializa a fila de estados das Notas
Queue<Note> note_green = Queue<Note>(N_STATES);
Queue<Note> note_red = Queue<Note>(N_STATES);
Queue<Note> note_yellow = Queue<Note>(N_STATES);
Queue<Note> note_blue = Queue<Note>(N_STATES);
Queue<Note> note_orange = Queue<Note>(N_STATES);

Queue<Note> trail_green = Queue<Note>(N_STATES);
Queue<Note> trail_red = Queue<Note>(N_STATES);
Queue<Note> trail_yellow = Queue<Note>(N_STATES);
Queue<Note> trail_blue = Queue<Note>(N_STATES);
Queue<Note> trail_orange = Queue<Note>(N_STATES);

#endif