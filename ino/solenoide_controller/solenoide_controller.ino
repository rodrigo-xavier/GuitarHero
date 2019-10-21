#include "note.h"
#include "queue.h"
#include <Arduino.h>

/********************************************************************************************/
/*DEFINES*/

// Number of states
#define TRACE_STATES 6
#define NOTE_STATES 10

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
/*VARIÁVEIS GLOBAIS*/ /*

  Descrição das variáveis globais:
  (BYTE[]) - 
  (COMMAND) - 
  (OFFTIME) - Tempo que a nota leva para ser pressionada à partir da detecção da mesma.
  (PRESS_MIN_TIME) - Tempo mínimo para pressionar nota
  (note[5]) - Inicializa um vetor de filas para 5 notas
  (trail[5]) - Inicializa um vetor de filas para 5 rastros
  (initializer) - Gambiarra para inicializar nota
*********************************************************************************************/

bool flag = false;
uint8_t BYTES[] = {0, 0};
uint16_t COMMAND = 0;
uint16_t OFFTIME = 65535; // Definir um valor grande até que o valor verdadeiro seja setado
const unsigned short PRESS_MIN_TIME = 50;
unsigned long PREVIOUSTIME = 0, CURRENTTIME = 0, TIMEOUT = 99999999;
Queue<Note> note[N_COLORS] = Queue<Note>(NOTE_STATES);
Queue<Note> trail[N_COLORS] = Queue<Note>(TRACE_STATES);
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
  // Serial.begin(115200);
  Serial.begin(9600);

  pinMode(L1_PIN, OUTPUT);
  pinMode(L2_PIN, OUTPUT);
  pinMode(R1_PIN, OUTPUT);
  pinMode(R2_PIN, OUTPUT);
  pinMode(X_PIN, OUTPUT);

  // Abre uma única vez o estado da nota inicializadora, para que não seja gasto processamento
  initializer.open = true;
}

void loop()
{
  if (flag && Serial.available() > 0)
  {
    /****************************************************************************************
  Descrição Detalhada: Como é possível ler 1 byte por vez utilizando Serial.read(), utilizamos 
  duas variáveis de 8 bits que são concatenados para 16 bits, para formar um comando que possa 
  ser lido por bitRead()
*********************************************************************************************/

    COMMAND = ((Serial.read() << 8) | Serial.read());

    if (bitRead(COMMAND, 0))
      add_note_queue(GREEN, L2_PIN);

    if (bitRead(COMMAND, 1))
      add_note_queue(RED, L1_PIN);

    if (bitRead(COMMAND, 2))
      add_note_queue(YELLOW, R1_PIN);

    if (bitRead(COMMAND, 3))
      add_note_queue(BLUE, R2_PIN);

    if (bitRead(COMMAND, 4))
      add_note_queue(ORANGE, X_PIN);

    if (bitRead(COMMAND, 5))
      add_trail_queue(GREEN, L2_PIN);

    if (bitRead(COMMAND, 6))
      add_trail_queue(RED, L1_PIN);

    if (bitRead(COMMAND, 7))
      add_trail_queue(YELLOW, R1_PIN);

    if (bitRead(COMMAND, 8))
      add_trail_queue(BLUE, R2_PIN);

    if (bitRead(COMMAND, 9))
      add_trail_queue(ORANGE, X_PIN);

    if (bitRead(COMMAND, 10))
      remove_trail_queue(GREEN);

    if (bitRead(COMMAND, 11))
      remove_trail_queue(RED);

    if (bitRead(COMMAND, 12))
      remove_trail_queue(YELLOW);

    if (bitRead(COMMAND, 13))
      remove_trail_queue(BLUE);

    if (bitRead(COMMAND, 14))
      remove_trail_queue(ORANGE);

    // if (bitRead(COMMAND, 15))
    //   reset_flag();
  }
  else if (!flag && Serial.available() >= 2)
  {
    OFFTIME = ((Serial.read() << 8) | Serial.read());
    flag = true;

    Serial.println(OFFTIME);
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
  noInterrupts();

  // Serial.println("addnotequeue");
  // Serial.println(pin);
  initializer.previous_time = millis();
  initializer.pin = pin;
  note[note_color].push(initializer);

  interrupts();
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
  noInterrupts();

  // Serial.println("addtrailqueue");
  initializer.previous_time = millis();
  initializer.pin = pin;
  trail[note_color].push(initializer);

  interrupts();
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
  // Serial.println("removetrailqueue");
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