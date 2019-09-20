#include "note.h"
#include "queue.h"

/**************************************************************************/
/*DEFINES*/

// Number of states
#define TRACE_STATES 3
#define NOTE_STATES 5

// Digital Pins
#define L1_PIN 3
#define L2_PIN 2
#define R1_PIN 4
#define R2_PIN 5
#define X_PIN 6

// Note colors
#define GREEN 0
#define RED 1
#define YELLOW 2
#define BLUE 3
#define ORANGE 4
#define N_COLORS 5 // Define a quantidade de notas (verde, vermelho, amarelo, azul e laranja == 5)

/**************************************************************************/
/*VARIÁVEIS GLOBAIS*/

uint8_t input_byte[] = {0, 0};
uint16_t command = 0;
volatile unsigned long OFFTIME = 9999999999;   // Definir um valor grande até que o valor verdadeiro seja setado
const static unsigned int PRESS_MIN_TIME = 50; // Tempo mínimo para pressionar nota

// Inicializa um vetor de filas para notas e rastros
Queue<Note> note[4] = Queue<Note>(NOTE_STATES);
Queue<Note> trail[4] = Queue<Note>(TRACE_STATES);

// Gambiarra para inicializar nota
Note initializer;

/**************************************************************************/
// COMMANDS

/*
  #define B0 0000000000000000 // B0 - APERTO SIMPLES VERDE
  #define B1 0000000000000001 // B1 - APERTO SIMPLES VERMELHO
  #define B2 0000000000000010 // B2 - APERTO SIMPLES AMARELO
  #define B3 0000000000000100 // B3 - APERTO SIMPLES AZUL
  #define B4 0000000000001000 // B4 - APERTO SIMPLES LARANJADO
  #define B5 0000000000010000 // B5 - APERTO SEM SOLTAR VERDE
  #define B6 0000000000100000 // B6 - APERTO SEM SOLTAR VERMELHO
  #define B7 0000000001000000 // B7 - APERTO SEM SOLTAR AMARELO
  #define B8 0000000010000000 // B8 - APERTO SEM SOLTAR AZUL
  #define B9 0000000100000000 // B9 - APERTO SEM SOLTAR LARANJADO
  #define B10 0000010000000000 // B10 - SOLTA VERDE
  #define B11 0000100000000000 // B11 - SOLTA VERMELHO
  #define B12 0001000000000000 // B12 - SOLTA AMARELO
  #define B13 0010000000000000 // B13 - SOLTA AZUL
  #define B14 0100000000000000 // B14 - SOLTA LARANJADO
  #define B15 1000000000000000 // B15 - 0 (será utilizado para configurações)
*/

/**************************************************************************/

void setup()
{
  Serial.begin(115200);

  pinMode(L1_PIN, OUTPUT);
  pinMode(L2_PIN, OUTPUT);
  pinMode(R1_PIN, OUTPUT);
  pinMode(R2_PIN, OUTPUT);
  pinMode(X_PIN, OUTPUT);
}

void loop()
{
  if (Serial.available() >= 2)
  {
    /*
      Como é possível ler apenas 1 byte por vez utilizando Serial.read(),
      utilizamos dois vetores de 8 bits e concatenamos para 16 bits, para formar 
      um comando que possa ser lido por bitRead()
    */
    input_byte[0] = Serial.read();                    // Least Significant byte
    input_byte[1] = Serial.read();                    // Most significante byte
    command = ((input_byte[1] << 8) | input_byte[0]); // 16 bits concatenados

    
    if (bitRead(command, 0))            // Green (L2_PIN)
      add_note_queue(GREEN, L2_PIN);
    
    else if (bitRead(command, 1))       // Red (L1_PIN)
      add_note_queue(RED, L1_PIN);
    
    else if (bitRead(command, 2))       // Yellow (R1_PIN)
      add_note_queue(YELLOW, R1_PIN);
    
    else if (bitRead(command, 3))       // Blue (R2_PIN)
      add_note_queue(BLUE, R2_PIN);
    
    else if (bitRead(command, 4))       // Orange (X_PIN)
      add_note_queue(ORANGE, X_PIN);
    
    else if (bitRead(command, 5))       // Green (L2_PIN)
      add_trail_queue(GREEN, L2_PIN);
    
    else if (bitRead(command, 6))       // Red (L1_PIN)
      add_trail_queue(RED, L1_PIN);
    
    else if (bitRead(command, 7))       // Yellow (R1_PIN)
      add_trail_queue(YELLOW, R1_PIN);
    
    else if (bitRead(command, 8))       // Blue (R2_PIN)
      add_trail_queue(BLUE, R2_PIN);
    
    else if (bitRead(command, 9))       // Orange (X_PIN)
      add_trail_queue(ORANGE, X_PIN);
    
    else if (bitRead(command, 10))      // Green (R1_PIN)
      remove_trail_queue(GREEN);
    
    else if (bitRead(command, 11))      // Red (L1_PIN)
      remove_trail_queue(RED);
    
    else if (bitRead(command, 12))      // Yellow (R1_PIN)
      remove_trail_queue(YELLOW);
    
    else if (bitRead(command, 13))      // Blue (R2_PIN)
      remove_trail_queue(BLUE);
    
    else if (bitRead(command, 14))      // Orange (X_PIN)
      remove_trail_queue(ORANGE);

    else if (bitRead(command, 15))      // Configuração do tempo
    {
      while (true)
      {
        if (Serial.available() > 0)
        {
          String str = Serial.readStringUntil('z');
          OFFTIME = str.toInt();
          Serial.print(OFFTIME);
          break;
        }
      }
    }
  }

  update_states();
}

void add_note_queue(int note_color, int pin)
{
  initializer.pin = pin;
  note[note_color].push(initializer);
}

void add_trail_queue(int note_color, int pin)
{
  initializer.pin = pin;
  trail[note_color].push(initializer);
}

/* 
  Se uma nota está sendo pressionada, então é acionado
  o comando para soltar a nota. É necessário usar while para esta
  verificação, por causa do offtime. Podem aparecer dois rastros pequenos
  na mesma trilha e serem acionados duas flags de drop antes que o 
  arduino tenha soltado a primeira nota.
*/
void remove_trail_queue(int note_color)
{
  int i = 0;

  while (!(trail[note_color][i].drop))
    trail[note_color][i++].drop = true;
}

void update_states(void)
{
  for (int i = 0; i < N_COLORS; i++)
  {
    for (int j = 0; j < NOTE_STATES; j++)
    {
      if (note[i][j].open)
      {
        note[i][j].update_note(OFFTIME, PRESS_MIN_TIME);
        if (!note[i][j].open)
          note[i].pop();
      }
    }

    for (int j = 0; j < TRACE_STATES; j++)
    {
      if (trail[i][j].open)
      {
        trail[i][j].update_trail(OFFTIME);
        if (!trail[i][j].open)
          trail[i].pop();
      }
    }
  }
}