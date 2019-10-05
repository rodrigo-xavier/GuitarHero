#include "note.h"
#include "queue.h"

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

byte COMMAND;
volatile unsigned short OFFTIME = 65000; // Definir um valor grande até que o valor verdadeiro seja setado
const unsigned short PRESS_MIN_TIME = 50;
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
  Serial.begin(115200);

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
  if (Serial.available())
  {
    /****************************************************************************************
  Descrição Detalhada: Como é possível ler 1 byte por vez utilizando Serial.read(), utilizamos 
  duas variáveis de 8 bits que são concatenados para 16 bits, para formar um comando que possa 
  ser lido por bitRead()
*********************************************************************************************/

    COMMAND = Serial.read() - '0'; // Least Significant byte
    // Serial.read();                 // Least Significant byte

    if (COMMAND == 0)
      add_note_queue(GREEN, L2_PIN);

    else if (COMMAND == 1)
      add_note_queue(RED, L1_PIN);

    else if (COMMAND == 2)
      add_note_queue(YELLOW, R1_PIN);

    else if (COMMAND == 3)
      add_note_queue(BLUE, R2_PIN);

    else if (COMMAND == 4)
      add_note_queue(ORANGE, X_PIN);

    else if (COMMAND == 5)
      add_trail_queue(GREEN, L2_PIN);

    else if (COMMAND == 6)
      add_trail_queue(RED, L1_PIN);

    else if (COMMAND == 7)
      add_trail_queue(YELLOW, R1_PIN);

    else if (COMMAND == 8)
      add_trail_queue(BLUE, R2_PIN);

    else if (COMMAND == 9)
      add_trail_queue(ORANGE, X_PIN);

    else if (COMMAND == 10)
      remove_trail_queue(GREEN);

    else if (COMMAND == 11)
      remove_trail_queue(RED);

    else if (COMMAND == 12)
      remove_trail_queue(YELLOW);

    else if (COMMAND == 13)
      remove_trail_queue(BLUE);

    else if (COMMAND == 14)
      remove_trail_queue(ORANGE);

    else if (COMMAND == 15)
      while (!Serial.available())
        OFFTIME = Serial.read();
    // Serial.read();
  }

  noInterrupts();
  update_states();
  interrupts();
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