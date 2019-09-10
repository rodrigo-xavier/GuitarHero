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

/**************************************************************************/
/*VARIÁVEIS GLOBAIS*/

uint8_t input_byte[] = {0, 0};
uint16_t command = 0;

// Inicializa a fila de estados das Notas
Queue<Note> note_green = Queue<Note>(NOTE_STATES);
Queue<Note> note_red = Queue<Note>(NOTE_STATES);
Queue<Note> note_yellow = Queue<Note>(NOTE_STATES);
Queue<Note> note_blue = Queue<Note>(NOTE_STATES);
Queue<Note> note_orange = Queue<Note>(NOTE_STATES);

Queue<Note> trail_green = Queue<Note>(TRACE_STATES);
Queue<Note> trail_red = Queue<Note>(TRACE_STATES);
Queue<Note> trail_yellow = Queue<Note>(TRACE_STATES);
Queue<Note> trail_blue = Queue<Note>(TRACE_STATES);
Queue<Note> trail_orange = Queue<Note>(TRACE_STATES);

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

  // delay(1000);
}

void loop()
{
  int i;
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
      note_green.push(Note(L2_PIN));

    // Red (L1_PIN)
    else if (bitRead(command, 1))
      note_red.push(Note(L1_PIN));

    // Yellow (R1_PIN)
    else if (bitRead(command, 2))
      note_yellow.push(Note(R1_PIN));

    // Blue (R1_PIN)
    else if (bitRead(command, 3))
      note_blue.push(Note(R2_PIN));

    // Orange (X_PIN)
    else if (bitRead(command, 4))
      note_orange.push(Note(X_PIN));

    // ----------------------------------------------------- //
    // Comandos relacionados com o rastro

    // Estado de rastro: Aperta sem soltar

    // Green (L2_PIN)
    else if (bitRead(command, 5))
      trail_green.push(Note(L2_PIN));

    // Red (L1_PIN)
    else if (bitRead(command, 6))
      trail_red.push(Note(L1_PIN));

    // Yellow (R1_PIN)
    else if (bitRead(command, 7))
      trail_yellow.push(Note(R1_PIN));

    // Blue (R2_PIN)
    else if (bitRead(command, 8))
      trail_blue.push(Note(R2_PIN));

    // Orange (X_PIN)
    else if (bitRead(command, 9))
      trail_orange.push(Note(X_PIN));

    // ----------------------------------------------------- //
    // Estado de rastro: Solta

    // Um rastro pequeno, precedido de outro rastro
    // pode ativar a flag drop enquanto o algoritmo espera
    // para soltar o primeiro rastro, por isso é necessário
    // verificar até achar uma flag drop==false

    // Green (R1_PIN)
    else if (bitRead(command, 10))
    {
      i = 0;
      while (!(trail_green[i].drop))
        trail_green[i++].drop = true;
    }

    // Red (L1_PIN)
    else if (bitRead(command, 11))
    {
      i = 0;
      while (!(trail_red[i].drop))
        trail_red[i++].drop = true;
    }

    // Yellow (R1_PIN)
    else if (bitRead(command, 12))
    {
      i = 0;
      while (!(trail_yellow[i].drop))
        trail_yellow[i++].drop = true;
    }

    // Blue (R2_PIN)
    else if (bitRead(command, 13))
    {
      i = 0;
      while (!(trail_blue[i].drop))
        trail_blue[i++].drop = true;
    }

    // Orange (X_PIN)
    else if (bitRead(command, 14))
    {
      i = 0;
      while (!(trail_orange[i].drop))
        trail_orange[i++].drop = true;
    }

    // Configuração de tempo
    // TODO REVER CONFIGURAÇÃO DO TEMPO, CONDIÇÕES ADICIONAIS DEVEM SER APLICADAS
    else if (bitRead(command, 15))
    {
      while (true)
      {
        if (Serial.available() > 0)
        {
          OFFTIME = Serial.read();
          break;
        }
      }
    }

    input_byte[0] = 0;
    input_byte[1] = 0;
    command = 0;
  }

  update_states();
}

// Atualiza todos os estados que estão ativos
// E decrementa o índice se o estado for encerrado
// durante a atualização. O algoritmo verifica se
// é nota ou rastro para decrementar o índice corretamente
void update_states(void)
{
  for (int i = 0; i < NOTE_STATES; i++)
  {
    if (note_green[i].open)
    {
      note_green[i].update_note();
      if (!note_green[i].open)
        note_green.pop();
    }
    if (note_red[i].open)
    {
      note_red[i].update_note();
      if (!note_red[i].open)
        note_red.pop();
    }
    if (note_yellow[i].open)
    {
      note_yellow[i].update_note();
      if (!note_yellow[i].open)
        note_yellow.pop();
    }
    if (note_blue[i].open)
    {
      note_blue[i].update_note();
      if (!note_blue[i].open)
        note_blue.pop();
    }
    if (note_orange[i].open)
    {
      note_orange[i].update_note();
      if (!note_orange[i].open)
        note_orange.pop();
    }
  }

  // Trails

  for (int i = 0; i < TRACE_STATES; i++)
  {
    if (trail_green[i].open)
    {
      trail_green[i].update_trail();
      if (!trail_green[i].open)
        trail_green.pop();
    }
    if (trail_red[i].open)
    {
      trail_red[i].update_trail();
      if (!trail_red[i].open)
        trail_red.pop();
    }
    if (trail_yellow[i].open)
    {
      trail_yellow[i].update_trail();
      if (!trail_yellow[i].open)
        trail_yellow.pop();
    }
    if (trail_blue[i].open)
    {
      trail_blue[i].update_trail();
      if (!trail_blue[i].open)
        trail_blue.pop();
    }
    if (trail_orange[i].open)
    {
      trail_orange[i].update_trail();
      if (!trail_orange[i].open)
        trail_orange.pop();
    }
  }
}
