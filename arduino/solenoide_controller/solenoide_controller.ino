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
    red[i] = new SimpleState(L1_PIN, offtime);
    red[i]->open = true;

    green[i] = new SimpleState(L2_PIN, offtime);
    green[i]->open = true;

    yellow[i] = new SimpleState(R1_PIN, offtime);
    yellow[i]->open = true;

    blue[i] = new SimpleState(R2_PIN, offtime);
    blue[i]->open = true;

    orange[i] = new SimpleState(X_PIN, offtime);
    orange[i]->open = true;
  }

  delay(1000);
}

void loop()
{
  // São lidos 1 byte por vez, já que através do MATLAB
  // está sendo enviado um bit para cada ação no formato
  // indicado no arquivo envia_comando.m
  // Ler a documentação dessa função para entender melhor
  if (Serial.available() > 0)
  {
    input_byte[0] = Serial.read();                    // Least Significant byte
    input_byte[1] = Serial.read();                    // Most significante byte
    command = ((input_byte[1] << 8) | input_byte[0]); // 16 bytes contatenando os 2 bytes acima

    // Os bits que estiverem como 1 indicam ações que
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
      ind = get_new_states('G');
      green[ind] = new Note(L2_PIN, offtime);
    }

    // Red (L1_PIN)
    if (bitRead(command, 1))
    {
      ind = get_new_states('R');
      red[ind] = new Note(L1_PIN, offtime);
    }

    // Yellow (R1_PIN)
    if (bitRead(command, 2))
    {
      ind = get_new_states('Y');
      yellow[ind] = new Note(R1_PIN, offtime);
    }

    // Blue (R1_PIN)
    if (bitRead(command, 3))
    {
      ind = get_new_states('B');
      blue[ind] = new Note(R2_PIN, offtime);
    }

    // Orange (X_PIN)
    if (bitRead(command, 4))
    {
      ind = get_new_states('O');
      orange[ind] = new Note(X_PIN, offtime);
    }

    // ----------------------------------------------------- //
    // Comandos relacionados com o rastro

    // Estado de rastro: Aperta sem soltar

    // Green (L2_PIN)
    if (bitRead(command, 5))
    {
      ind = get_traceStates_index('G');
      greenTraceStates[ind] = new Note(L2_PIN, offtime);
      greenTraceQueue.push(ind);
    }

    // Red (L1_PIN)
    if (bitRead(command, 6))
    {
      ind = get_traceStates_index('R');
      redTraceStates[ind] = new Note(L1_PIN, offtime);
      redTraceQueue.push(ind);
    }

    // Yellow (R1_PIN)
    if (bitRead(command, 7))
    {
      ind = get_traceStates_index('Y');
      yellowTraceStates[ind] = new Note(R1_PIN, offtime);
      yellowTraceQueue.push(ind);
    }

    // Blue (R2_PIN)
    if (bitRead(command, 8))
    {
      ind = get_traceStates_index('B');
      blueTraceStates[ind] = new Note(R2_PIN, offtime);
      blueTraceQueue.push(ind);
    }

    // Orange (X_PIN)
    if (bitRead(command, 9))
    {
      ind = get_traceStates_index('O');
      orangeTraceStates[ind] = new Note(X_PIN, offtime);
      orangeTraceQueue.push(ind);
    }

    // ----------------------------------------------------- //

    // Estado de rastro: Solta

    // Green (R1_PIN)
    if (bitRead(command, 10))
    {
      first_item = greenTraceQueue.front();
      if (!greenTraceStates[first_item]->open)
      {
        ind = greenTraceQueue.pop();
        greenTraceStates[ind]->Soltar(offtime);
      }
    }

    // Red (L1_PIN)
    if (bitRead(command, 11))
    {
      first_item = redTraceQueue.front();
      if (!redTraceStates[first_item]->open)
      {
        ind = redTraceQueue.pop();
        redTraceStates[ind]->Soltar(offtime);
      }
    }

    if (bitRead(command, 12))
    {
      first_item = yellowTraceQueue.front();
      if (!yellowTraceStates[first_item]->open)
      {
        ind = yellowTraceQueue.pop();
        yellowTraceStates[ind]->Soltar(offtime);
      }
    }

    // Blue (R2_PIN)
    if (bitRead(command, 13))
    {
      first_item = blueTraceQueue.front();
      if (!blueTraceStates[first_item]->open)
      {
        ind = blueTraceQueue.pop();
        blueTraceStates[ind]->Soltar(offtime);
      }
    }

    // Orange (X_PIN)
    if (bitRead(command, 14))
    {
      first_item = orangeTraceQueue.front();
      if (!orangeTraceStates[first_item]->open)
      {
        ind = orangeTraceQueue.pop();
        orangeTraceStates[ind]->Soltar(offtime);
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

  checkAllOnStates();
}

void checkAllOnStates()
{
  // Verifica todos os estados que estão ativos

  for (int i = 0; i < N_STATES; i++)
  {
    if (!red[i]->open) // se não foi finalizada ainda
      red[i]->press();
    if (!green[i]->open)
      green[i]->press();
    if (!yellow[i]->open)
      yellow[i]->press();
    if (!blue[i]->open)
      blue[i]->press();
    if (!orange[i]->open)
      orange[i]->press();

    if (i < N_STATES)
    {
      if (!redTraceStates[i]->open)
        redTraceStates[i]->press_and_hold();
      if (!greenTraceStates[i]->open)
        greenTraceStates[i]->press_and_hold();
      if (!yellowTraceStates[i]->open)
        yellowTraceStates[i]->press_and_hold();
      if (!blueTraceStates[i]->open)
        blueTraceStates[i]->press_and_hold();
      if (!orangeTraceStates[i]->open)
        orangeTraceStates[i]->press_and_hold();
    }
  }
}
