#include "note.h"
#include "queue.h"

/********************************************************************************************/
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

/********************************************************************************************/
/*VARIÁVEIS GLOBAIS*/

uint8_t BYTE[] = {0, 0};
uint16_t COMMAND = 0;
volatile unsigned long OFFTIME = 99999999;  // Definir um valor grande até que o valor verdadeiro seja setado
volatile unsigned long PRESS_MIN_TIME = 30; // Tempo mínimo para pressionar nota

// Inicializa um vetor de filas para notas e rastros
Queue<Note> note[5] = Queue<Note>(NOTE_STATES);
Queue<Note> trail[5] = Queue<Note>(TRACE_STATES);

// Gambiarra para inicializar nota
Note initializer;

/********************************************************************************************
COMMANDS

00000000 00000000 - 0 - APERTO SIMPLES VERDE
00000000 00000001 - 1 - APERTO SIMPLES VERMELHO
00000000 00000010 - 2 - APERTO SIMPLES AMARELO
00000000 00000100 - 3 - APERTO SIMPLES AZUL
00000000 00001000 - 4 - APERTO SIMPLES LARANJADO
00000000 00010000 - 5 - APERTO SEM SOLTAR VERDE
00000000 00100000 - 6 - APERTO SEM SOLTAR VERMELHO
00000000 01000000 - 7 - APERTO SEM SOLTAR AMARELO
00000000 10000000 - 8 - APERTO SEM SOLTAR AZUL
00000001 00000000 - 9 - APERTO SEM SOLTAR LARANJADO
00000100 00000000 - 10 - SOLTA VERDE
00001000 00000000 - 11 - SOLTA VERMELHO
00010000 00000000 - 12 - SOLTA AMARELO
00100000 00000000 - 13 - SOLTA AZUL
01000000 00000000 - 14 - SOLTA LARANJADO
10000000 00000000 - 15 - CONFIGURAÇÃO DO TEMPO OFFTIME
********************************************************************************************/

void setup()
{
  Serial.begin(115200);

  pinMode(L1_PIN, OUTPUT);
  pinMode(L2_PIN, OUTPUT);
  pinMode(R1_PIN, OUTPUT);
  pinMode(R2_PIN, OUTPUT);
  pinMode(X_PIN, OUTPUT);

  initializer.open = true;
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

    BYTE[0] = Serial.read(); // Least Significant byte
    BYTE[1] = Serial.read(); // Most significante byte

    COMMAND = ((BYTE[1] << 8) | BYTE[0]); // 16 bits concatenados

    if (bitRead(COMMAND, 0))
      add_note_queue(GREEN, L2_PIN);

    else if (bitRead(COMMAND, 1))
      add_note_queue(RED, L1_PIN);

    else if (bitRead(COMMAND, 2))
      add_note_queue(YELLOW, R1_PIN);

    else if (bitRead(COMMAND, 3))
      add_note_queue(BLUE, R2_PIN);

    else if (bitRead(COMMAND, 4))
      add_note_queue(ORANGE, X_PIN);

    else if (bitRead(COMMAND, 5))
      add_trail_queue(GREEN, L2_PIN);

    else if (bitRead(COMMAND, 6))
      add_trail_queue(RED, L1_PIN);

    else if (bitRead(COMMAND, 7))
      add_trail_queue(YELLOW, R1_PIN);

    else if (bitRead(COMMAND, 8))
      add_trail_queue(BLUE, R2_PIN);

    else if (bitRead(COMMAND, 9))
      add_trail_queue(ORANGE, X_PIN);

    else if (bitRead(COMMAND, 10))
      remove_trail_queue(GREEN);

    else if (bitRead(COMMAND, 11))
      remove_trail_queue(RED);

    else if (bitRead(COMMAND, 12))
      remove_trail_queue(YELLOW);

    else if (bitRead(COMMAND, 13))
      remove_trail_queue(BLUE);

    else if (bitRead(COMMAND, 14))
      remove_trail_queue(ORANGE);

    else if (bitRead(COMMAND, 15)) // Configuração do tempo
    {
      while (true)
      {
        if (Serial.available() > 0)
        {
          String str = Serial.readStringUntil('z');
          str[str.length()] = '\0';
          OFFTIME = str.toInt();
          Serial.print(OFFTIME);
          break;
        }
      }
      while (Serial.available())
        Serial.read();
    }
  }

  update_states();
}

/********************************************************************************************  
  Descrição Breve: Função para adicionar uma Nota à fila de notas

  Descrição da Entrada:
  (initializer)
  (note_color) - 
  (pin) - 

  Descrição Detalhada: 
*********************************************************************************************/
void add_note_queue(int note_color, int pin)
{
  initializer.previous_time = millis();
  initializer.pin = pin;
  note[note_color].push(initializer);
}

/********************************************************************************************  
  Descrição Breve: Função para adicionar um rastro à fila de rastros

  Descrição da Entrada:
  (initializer)
  (note_color) - 
  (pin) - 

  Descrição Detalhada: 
*********************************************************************************************/
void add_trail_queue(int note_color, int pin)
{
  initializer.pin = pin;
  initializer.previous_time = millis();
  trail[note_color].push(initializer);
}

/********************************************************************************************  
  Descrição Breve: Função para adicionar um rastro à fila de rastros

  Descrição da Entrada:
  (note_color) - 

  Descrição Detalhada: Se uma nota está sendo pressionada, então é acionado
  o comando para soltar a nota. É necessário usar while para esta
  verificação, por causa do offtime. Podem aparecer dois rastros pequenos
  na mesma trilha e serem acionados duas flags de drop antes que o 
  arduino tenha soltado a primeira nota.
*********************************************************************************************/
void remove_trail_queue(int note_color)
{
  int i = 0;

  while (!(trail[note_color][i].drop))
    trail[note_color][i++].drop = true;
}

/********************************************************************************************  
  Descrição Breve: 

  Descrição Detalhada: 
*********************************************************************************************/
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