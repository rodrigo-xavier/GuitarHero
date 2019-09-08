#include <QueueArray.h>
#include "global.h"

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

  // Inicializa os estados das Notas
  for (int i = 0; i < N_STATES; i++)
  {
    green[i] = new Note(L2_PIN, offtime);
    red[i] = new Note(L1_PIN, offtime);
    yellow[i] = new Note(R1_PIN, offtime);
    blue[i] = new Note(R2_PIN, offtime);
    orange[i] = new Note(X_PIN, offtime);
  }

  // Define counters
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

  // delay(1000);
}

void loop()
{
  // São lidos 1 byte por vez, já que através do MATLAB
  // está sendo enviado um bit para cada ação no formato
  // indexicado no arquivo envia_comando.m
  // Ler a documentação dessa função para entender melhor
  if (Serial.available() > 0)
  {
    input_byte[0] = Serial.read();                    // Least Significant byte
    input_byte[1] = Serial.read();                    // Most significante byte
    command = ((input_byte[1] << 8) | input_byte[0]); // 16 bytes contatenando os 2 bytes acima

    // Os bits que estiverem como 1 indexicam ações que
    // devem ser realizadas.

    // Estado simples: aperta e solta automaticamente
    // o mais rápido possível

    // ----------------------------------------------------- //

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

    // ----------------------------------------------------- //
    // Comandos relacionados com aperto simples das notas

    // Green (L2_PIN)
    if (bitRead(command, 0))
    {
      green[index_note_green] = new Note(L2_PIN, offtime);
      index_note_green++;
    }

    // Red (L1_PIN)
    if (bitRead(command, 1))
    {
      red[index_note_red] = new Note(L1_PIN, offtime);
      index_note_red++;
    }

    // Yellow (R1_PIN)
    if (bitRead(command, 2))
    {
      yellow[index_note_yellow] = new Note(R1_PIN, offtime);
      index_note_yellow++;
    }

    // Blue (R1_PIN)
    if (bitRead(command, 3))
    {
      blue[index_note_blue] = new Note(R2_PIN, offtime);
      index_note_blue++;
    }

    // Orange (X_PIN)
    if (bitRead(command, 4))
    {
      orange[index_note_orange] = new Note(X_PIN, offtime);
      index_note_orange++;
    }

    // ----------------------------------------------------- //
    // Comandos relacionados com o rastro

    // Estado de rastro: Aperta sem soltar

    // Green (L2_PIN)
    if (bitRead(command, 5))
    {
      index = get_traceStates_indexex('G');
      green[index] = new Note(L2_PIN, offtime);
      green[index]->trail = true;
      greenTraceQueue.push(index);
    }

    // Red (L1_PIN)
    if (bitRead(command, 6))
    {
      index = get_traceStates_indexex('R');
      red[index] = new Note(L1_PIN, offtime);
      red[index]->trail = true;
      redTraceQueue.push(index);
    }

    // Yellow (R1_PIN)
    if (bitRead(command, 7))
    {
      index = get_traceStates_indexex('Y');
      yellow[index] = new Note(R1_PIN, offtime);
      yellow[index]->trail = true;
      yellowTraceQueue.push(index);
    }

    // Blue (R2_PIN)
    if (bitRead(command, 8))
    {
      index = get_traceStates_indexex('B');
      blue[index] = new Note(R2_PIN, offtime);
      blue[index]->trail = true;
      blueTraceQueue.push(index);
    }

    // Orange (X_PIN)
    if (bitRead(command, 9))
    {
      index = get_traceStates_indexex('O');
      orange[index] = new Note(X_PIN, offtime);
      orange[index]->trail = true;
      orangeTraceQueue.push(index);
    }

    // ----------------------------------------------------- //

    // Estado de rastro: Solta

    // Green (R1_PIN)
    if (bitRead(command, 10))
    {
      first_item = greenTraceQueue.front();
      if (!green[first_item]->open)
      {
        index = greenTraceQueue.pop();
        green[index]->Soltar(offtime);
      }
    }

    // Red (L1_PIN)
    if (bitRead(command, 11))
    {
      first_item = redTraceQueue.front();
      if (!red[first_item]->open)
      {
        index = redTraceQueue.pop();
        red[index]->Soltar(offtime);
      }
    }

    if (bitRead(command, 12))
    {
      first_item = yellowTraceQueue.front();
      if (!yellow[first_item]->open)
      {
        index = yellowTraceQueue.pop();
        yellow[index]->Soltar(offtime);
      }
    }

    // Blue (R2_PIN)
    if (bitRead(command, 13))
    {
      first_item = blueTraceQueue.front();
      if (!blue[first_item]->open)
      {
        index = blueTraceQueue.pop();
        blue[index]->drop = true;
        blue[index]->previous_time = micro();
      }
    }

    // Orange (X_PIN)
    if (bitRead(command, 14))
    {
      first_item = orangeTraceQueue.front();
      if (!orange[first_item]->open)
      {
        index = orangeTraceQueue.pop();
        orange[index]->Soltar(offtime);
      }
    }

    // Configuração de tempo (DEVE SEMPRE SER A ÚLTIMA CONDIÇÃO, por questão de eficiência)
    if (bitRead(command, 15))
    {
      while (true)
      {
        if (Serial.available() > 0)
        {
          incomingByte = Serial.read();
          // Obtem o tempo de offtime de nota simples
          if (incomingByte == char(90))
          {
            Serial.print("OK");
            getSimpleTime();
            break;
          }
        }
      }
      incomingByte == '\0';
    }

    input_byte[0] = 0;
    input_byte[1] = 0;
    command = 0;
  }

  update_states();
}

void update_states(void)
{
  // Atualiza todos os estados que estão ativos
  // E decrementa o índice se o estado for encerrado
  // durante a atualização

  for (int i = 0; i < N_STATES; i++)
  {
    if (green[i]->open)
    {
      green[i]->update();
      if (!green[i]->open)
        index_note_green--;
    }
    if (red[i]->open)
    {
      red[i]->update();
      if (!red[i]->open)
        index_note_red--;
    }
    if (yellow[i]->open)
    {
      yellow[i]->update();
      if (!yellow[i]->open)
        index_note_yellow--;
    }
    if (blue[i]->open)
    {
      blue[i]->update();
      if (!blue[i]->open)
        index_note_blue--;
    }
    if (!orange[i]->open)
    {
      orange[i]->update();
      if (!orange[i]->open)
        index_note_orange--;
    }
  }
}
