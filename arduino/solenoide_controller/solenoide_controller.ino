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
const static unsigned int PRESS_MIN_TIME = 50; // Min time to press note in milli seconds

// Inicializa um vetor de filas para notas e rastros
Queue<Note> note[4] = Queue<Note>(NOTE_STATES);
Queue<Note> trail[4] = Queue<Note>(TRACE_STATES);

// Gambiarra para inicializar nota
Note initializer;

/**************************************************************************/
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

/**************************************************************************/

void setup()
{
  // Configura quantidade de bits por segundo que o arduino deve receber
  Serial.begin(115200);

  // Inicializa os pinos como saída
  pinMode(L1_PIN, OUTPUT);
  pinMode(L2_PIN, OUTPUT);
  pinMode(R1_PIN, OUTPUT);
  pinMode(R2_PIN, OUTPUT);
  pinMode(X_PIN, OUTPUT);

  delay(1000);
}

void loop()
{
  // São lidos 1 byte por vez, já que através do MATLAB
  // está sendo enviado um bit para cada ação no formato
  // indexicado no arquivo envia_comando.m
  // Ler a documentação dessa função para entender melhor
  if (Serial.available() >= 2)
  {
    input_byte[0] = Serial.read();                    // Least Significant byte
    input_byte[1] = Serial.read();                    // Most significante byte
    command = ((input_byte[1] << 8) | input_byte[0]); // 16 bytes contatenando os 2 bytes acima

    // Os bits que estiverem como 1 indexicam ações que
    // devem ser realizadas.

    // Estado simples: aperta e solta automaticamente
    // o mais rápido possível

    // ----------------------------------------------------- //
    // Comandos relacionados com aperto simples das notas

    // Green (L2_PIN)
    if (bitRead(command, 0))
      add_note_queue(GREEN, L2_PIN);

    // Red (L1_PIN)
    else if (bitRead(command, 1))
      add_note_queue(RED, L1_PIN);

    // Yellow (R1_PIN)
    else if (bitRead(command, 2))
      add_note_queue(YELLOW, R1_PIN);

    // Blue (R2_PIN)
    else if (bitRead(command, 3))
      add_note_queue(BLUE, R2_PIN);

    // Orange (X_PIN)
    else if (bitRead(command, 4))
      add_note_queue(ORANGE, X_PIN);

    // ----------------------------------------------------- //
    // Comandos relacionados com o rastro

    // Green (L2_PIN)
    else if (bitRead(command, 5))
      add_trail_queue(GREEN, L2_PIN);

    // Red (L1_PIN)
    else if (bitRead(command, 6))
      add_trail_queue(RED, L1_PIN);

    // Yellow (R1_PIN)
    else if (bitRead(command, 7))
      add_trail_queue(YELLOW, R1_PIN);

    // Blue (R2_PIN)
    else if (bitRead(command, 8))
      add_trail_queue(BLUE, R2_PIN);

    // Orange (X_PIN)
    else if (bitRead(command, 9))
      add_trail_queue(ORANGE, X_PIN);

    // ----------------------------------------------------- //
    // Estado de rastro: Solta

    // Um rastro pequeno, precedido de outro rastro
    // pode ativar a flag drop enquanto o algoritmo espera
    // para soltar o primeiro rastro, por isso é necessário
    // verificar até achar uma flag drop==false

    // Green (R1_PIN)
    else if (bitRead(command, 10))
      remove_trail_queue(GREEN);

    // Red (L1_PIN)
    else if (bitRead(command, 11))
      remove_trail_queue(RED);

    // Yellow (R1_PIN)
    else if (bitRead(command, 12))
      remove_trail_queue(YELLOW);

    // Blue (R2_PIN)
    else if (bitRead(command, 13))
      remove_trail_queue(BLUE);

    // Orange (X_PIN)
    else if (bitRead(command, 14))
      remove_trail_queue(ORANGE);

    // Configuração de tempo
    else if (bitRead(command, 15))
    {
      while (true)
      {
        if (Serial.available() > 0)
        {
          String str = Serial.readStringUntil('b');
          OFFTIME = str.toInt();
          Serial.print(OFFTIME);
          // incomingByte = '\0';
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

void remove_trail_queue(int note_color)
{
  int i = 0;

  while (!(trail[note_color][i].drop))
    trail[note_color][i++].drop = true;
}

// Atualiza todos os estados que estão ativos
// E decrementa o índice se o estado for encerrado
// durante a atualização. O algoritmo verifica se
// é nota ou rastro para decrementar o índice corretamente

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