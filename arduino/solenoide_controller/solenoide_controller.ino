#include <QueueArray.h>
#include "global.h"

void setup()
{
  Serial.begin(115200);

  // Inicializa os pinos como saída
  pinMode(L1_PIN, OUTPUT);
  pinMode(L2_PIN, OUTPUT);
  pinMode(R1_PIN, OUTPUT);
  pinMode(R2_PIN, OUTPUT);
  pinMode(X_PIN, OUTPUT);

  // Inicializa os estados simples
  for (int i = 0; i < N_SIMPLE_STATES; i++)
  {
    redSimpleStates[i] = new SimpleState(L1_PIN, offtime_simple);
    redSimpleStates[i]->finished = true;

    greenSimpleStates[i] = new SimpleState(L2_PIN, offtime_simple);
    greenSimpleStates[i]->finished = true;

    yellowSimpleStates[i] = new SimpleState(R1_PIN, offtime_simple);
    yellowSimpleStates[i]->finished = true;

    blueSimpleStates[i] = new SimpleState(R2_PIN, offtime_simple);
    blueSimpleStates[i]->finished = true;

    orangeSimpleStates[i] = new SimpleState(X_PIN, offtime_simple);
    orangeSimpleStates[i]->finished = true;
  }

  delay(1000);
}

void loop()
{
  // São lidos 2 bytes de uma vez, já que através do MATLAB
  // está sendo enviado um bit para cada ação no formato
  // indicado no arquivo envia_comando.m
  // Ler a documentação dessa função para entender melhor
  if (Serial.available() >= 2)
  {
    incBytes[0] = Serial.read();                   // Least Significant byte
    incBytes[1] = Serial.read();                   // Most significante byte
    commands = ((incBytes[1] << 8) | incBytes[0]); // 16 bytes contatenando os 2 bytes acima

    // Os bits que estiverem como 1 indicam ações que
    // devem ser realizadas.

    // Estado simples: aperta e solta automaticamente
    // o mais rápido possível

    // Green (L2_PIN)
    if (bitRead(commands, 0))
    {
      ind = get_simpleStates_index('G');
      greenSimpleStates[ind] = new SimpleState(L2_PIN, offtime_simple);
    }

    // Red (L1_PIN)
    if (bitRead(commands, 1))
    {
      ind = get_simpleStates_index('R');
      redSimpleStates[ind] = new SimpleState(L1_PIN, offtime_simple);
    }

    // Yellow (R1_PIN)
    if (bitRead(commands, 2))
    {
      ind = get_simpleStates_index('Y');
      yellowSimpleStates[ind] = new SimpleState(R1_PIN, offtime_simple);
    }

    // Blue (R1_PIN)
    if (bitRead(commands, 3))
    {
      ind = get_simpleStates_index('B');
      blueSimpleStates[ind] = new SimpleState(R2_PIN, offtime_simple);
    }

    // Orange (X_PIN)
    if (bitRead(commands, 4))
    {
      ind = get_simpleStates_index('O');
      orangeSimpleStates[ind] = new SimpleState(X_PIN, offtime_simple);
    }

    // ----------------------------------------------------- //
    // Comandos relacionados com o rastro

    // Estado de rastro: Aperta sem soltar

    // Green (L2_PIN)
    if (bitRead(commands, 5))
    {
      ind = get_traceStates_index('G');
      greenTraceStates[ind] = new TraceState(L2_PIN, offtime_rastro);
      greenTraceQueue.push(ind);
    }

    // Red (L1_PIN)
    if (bitRead(commands, 6))
    {
      ind = get_traceStates_index('R');
      redTraceStates[ind] = new TraceState(L1_PIN, offtime_rastro);
      redTraceQueue.push(ind);
    }

    // Yellow (R1_PIN)
    if (bitRead(commands, 7))
    {
      ind = get_traceStates_index('Y');
      yellowTraceStates[ind] = new TraceState(R1_PIN, offtime_rastro);
      yellowTraceQueue.push(ind);
    }

    // Blue (R2_PIN)
    if (bitRead(commands, 8))
    {
      ind = get_traceStates_index('B');
      blueTraceStates[ind] = new TraceState(R2_PIN, offtime_rastro);
      blueTraceQueue.push(ind);
    }

    // Orange (X_PIN)
    if (bitRead(commands, 9))
    {
      ind = get_traceStates_index('O');
      orangeTraceStates[ind] = new TraceState(X_PIN, offtime_rastro);
      orangeTraceQueue.push(ind);
    }

    // ------ //

    // Estado de rastro: Solta

    // Green (R1_PIN)
    if (bitRead(commands, 10) && !greenTraceQueue.isEmpty())
    {
      first_item = greenTraceQueue.front();
      if (!greenTraceStates[first_item]->finished)
      {
        ind = greenTraceQueue.pop();
        greenTraceStates[ind]->Soltar(offtime_simple);
      }
    }

    // Red (L1_PIN)
    if (bitRead(commands, 11) && !redTraceQueue.isEmpty())
    {
      first_item = redTraceQueue.front();
      if (!redTraceStates[first_item]->finished)
      {
        ind = redTraceQueue.pop();
        redTraceStates[ind]->Soltar(offtime_simple);
      }
    }

    if (bitRead(commands, 12) && !yellowTraceQueue.isEmpty())
    {
      first_item = yellowTraceQueue.front();
      if (!yellowTraceStates[first_item]->finished)
      {
        ind = yellowTraceQueue.pop();
        yellowTraceStates[ind]->Soltar(offtime_simple);
      }
    }

    // Blue (R2_PIN)
    if (bitRead(commands, 13) && !blueTraceQueue.isEmpty())
    {
      first_item = blueTraceQueue.front();
      if (!blueTraceStates[first_item]->finished)
      {
        ind = blueTraceQueue.pop();
        blueTraceStates[ind]->Soltar(offtime_simple);
      }
    }

    // Orange (X_PIN)
    if (bitRead(commands, 14) && !orangeTraceQueue.isEmpty())
    {
      first_item = orangeTraceQueue.front();
      if (!orangeTraceStates[first_item]->finished)
      {
        ind = orangeTraceQueue.pop();
        orangeTraceStates[ind]->Soltar(offtime_simple);
      }
    }

    // Configuração de tempo
    if (bitRead(commands, 15))
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

    incBytes[0] = 0;
    incBytes[1] = 0;
    commands = 0;
  }

  checkAllOnStates();
}

int get_simpleStates_index(char color)
{
  // Função que retorna o índice do array
  // a ser utilizado para alocar o estado Simple
  // dando sempre prioridade para o menor índice
  // (simplesmente por simplicidade de implementação)

  if (color == 'R')
  {
    for (int i = 0; i < N_SIMPLE_STATES; i++)
    {
      if (redSimpleStates[i]->finished)
        return i;
    }
  }
  else if (color == 'G')
  {
    for (int i = 0; i < N_SIMPLE_STATES; i++)
    {
      if (greenSimpleStates[i]->finished)
        return i;
    }
  }
  else if (color == 'Y')
  {
    for (int i = 0; i < N_SIMPLE_STATES; i++)
    {
      if (yellowSimpleStates[i]->finished)
        return i;
    }
  }
  else if (color == 'B')
  {
    for (int i = 0; i < N_SIMPLE_STATES; i++)
    {
      if (blueSimpleStates[i]->finished)
        return i;
    }
  }
  else if (color == 'O')
  {
    for (int i = 0; i < N_SIMPLE_STATES; i++)
    {
      if (orangeSimpleStates[i]->finished)
        return i;
    }
  }

  return -1;
}

int get_traceStates_index(char color)
{
  // Função que retorna o índice do array
  // a ser utilizado para alocar o estado traceState
  // dando sempre prioridade para o menor índice
  // (simplesmente por simplicidade de implementação)

  if (color == 'R')
  {
    for (int i = 0; i < N_TRACE_STATES; i++)
    {
      if (redTraceStates[i]->finished)
        return i;
    }
  }
  else if (color == 'G')
  {
    for (int i = 0; i < N_TRACE_STATES; i++)
    {
      if (greenTraceStates[i]->finished)
        return i;
    }
  }
  else if (color == 'Y')
  {
    for (int i = 0; i < N_TRACE_STATES; i++)
    {
      if (yellowTraceStates[i]->finished)
        return i;
    }
  }
  else if (color == 'B')
  {
    for (int i = 0; i < N_TRACE_STATES; i++)
    {
      if (blueTraceStates[i]->finished)
        return i;
    }
  }
  else if (color == 'O')
  {
    for (int i = 0; i < N_TRACE_STATES; i++)
    {
      if (orangeTraceStates[i]->finished)
        return i;
    }
  }

  return -1;
}

void checkAllOnStates()
{
  // Verifica todos os estados que estão ativos

  for (int i = 0; i < N_SIMPLE_STATES; i++)
  {
    if (!redSimpleStates[i]->finished) // se não foi finalizada ainda
      redSimpleStates[i]->Update();
    if (!greenSimpleStates[i]->finished)
      greenSimpleStates[i]->Update();
    if (!yellowSimpleStates[i]->finished)
      yellowSimpleStates[i]->Update();
    if (!blueSimpleStates[i]->finished)
      blueSimpleStates[i]->Update();
    if (!orangeSimpleStates[i]->finished)
      orangeSimpleStates[i]->Update();

    if (i < N_TRACE_STATES)
    {
      if (!redTraceStates[i]->finished)
        redTraceStates[i]->Update();
      if (!greenTraceStates[i]->finished)
        greenTraceStates[i]->Update();
      if (!yellowTraceStates[i]->finished)
        yellowTraceStates[i]->Update();
      if (!blueTraceStates[i]->finished)
        blueTraceStates[i]->Update();
      if (!orangeTraceStates[i]->finished)
        orangeTraceStates[i]->Update();
    }
  }
}

void getSimpleTime()
{
  // Recebe o tempo de offtime do MATLAB
  // para nota simples
  offtime_simple = 0;
  while (true)
  {
    if (Serial.available() > 0)
    {
      if (offtime_simple != 0)
      {
        break;
      }
      incomingByte = Serial.read();
      if (incomingByte == 'a')
      {
        String str = Serial.readStringUntil('b');
        offtime_simple = str.toInt();
        Serial.print(offtime_simple);
        incomingByte = '\0';
      }
    }
  }
}
