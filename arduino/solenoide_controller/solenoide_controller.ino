#include "global.h"
#include "note.h"
#include "queue.h"

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

  int i;

  // delay(1000);
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
      note_green.push(new Note(L2_PIN, false));

    // Red (L1_PIN)
    if (bitRead(command, 1))
      note_red.push(new Note(L1_PIN, false));

    // Yellow (R1_PIN)
    if (bitRead(command, 2))
      note_yellow.push(new Note(R1_PIN, false));

    // Blue (R1_PIN)
    if (bitRead(command, 3))
      note_blue.push(new Note(R2_PIN, false));

    // Orange (X_PIN)
    if (bitRead(command, 4))
      note_orange.push(new Note(X_PIN, false));

    // ----------------------------------------------------- //
    // Comandos relacionados com o rastro

    // Estado de rastro: Aperta sem soltar

    // Green (L2_PIN)
    if (bitRead(command, 5))
      trail_green.push(new Note(L2_PIN, true));

    // Red (L1_PIN)
    if (bitRead(command, 6))
      trail_red.push(new Note(L1_PIN, true));

    // Yellow (R1_PIN)
    if (bitRead(command, 7))
      trail_yellow.push(new Note(R1_PIN, true));

    // Blue (R2_PIN)
    if (bitRead(command, 8))
      trail_blue.push(new Note(R2_PIN, true));

    // Orange (X_PIN)
    if (bitRead(command, 9))
      trail_orange.push(new Note(X_PIN, true));

    // ----------------------------------------------------- //
    // Estado de rastro: Solta

    // Um rastro pequeno, precedido de outro rastro
    // pode ativar a flag drop enquanto o algoritmo espera
    // para soltar o primeiro rastro, por isso é necessário
    // verificar até achar uma flag drop==false

    // Green (R1_PIN)
    if (bitRead(command, 10))
    {
      i = 0;
      while (!(trail_green[i]->drop))
        trail_green[i++]->drop = true;
    }

    // Red (L1_PIN)
    if (bitRead(command, 11))
    {
      i = 0;
      while (!(trail_red[i]->drop))
        trail_red[i++]->drop = true;
    }

    // Yellow (R1_PIN)
    if (bitRead(command, 12))
    {
      i = 0;
      while (!(trail_yellow[i]->drop))
        trail_yellow[i++]->drop = true;
    }

    // Blue (R2_PIN)
    if (bitRead(command, 13))
    {
      i = 0;
      while (!(trail_blue[i]->drop))
        trail_blue[i++]->drop = true;
    }

    // Orange (X_PIN)
    if (bitRead(command, 14))
    {
      i = 0;
      while (!(trail_orange[i]->drop))
        trail_orange[i++]->drop = true;
    }

    // Configuração de tempo
    // TODO REVER CONFIGURAÇÃO DO TEMPO, CONDIÇÕES ADICIONAIS DEVEM SER APLICADAS
    if (bitRead(command, 15))
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
  for (int i = 0; i < N_STATES; i++)
  {
    if (note_green[i]->open)
    {
      note_green[i]->update();
      if (!note_green[i]->open && !(note_green[i]->trail))
        note_green.pop();
    }
    if (note_red[i]->open)
    {
      note_red[i]->update();
      if (!note_red[i]->open && !(note_red[i]->trail))
        note_red.pop();
    }
    if (note_yellow[i]->open)
    {
      note_yellow[i]->update();
      if (!note_yellow[i]->open && !(note_yellow[i]->trail))
        note_yellow.pop();
    }
    if (note_blue[i]->open)
    {
      note_blue[i]->update();
      if (!note_blue[i]->open && !(note_blue[i]->trail))
        note_blue.pop();
    }
    if (note_orange[i]->open)
    {
      note_orange[i]->update();
      if (!note_orange[i]->open && !(note_orange[i]->trail))
        note_orange.pop();
    }

    if (trail_green[i]->open)
    {
      trail_green[i]->update();
      if (!trail_green[i]->open && !(trail_green[i]->trail))
        trail_green.pop();
    }
    if (trail_red[i]->open)
    {
      trail_red[i]->update();
      if (!trail_red[i]->open && !(trail_red[i]->trail))
        trail_red.pop();
    }
    if (trail_yellow[i]->open)
    {
      trail_yellow[i]->update();
      if (!trail_yellow[i]->open && !(trail_yellow[i]->trail))
        trail_yellow.pop();
    }
    if (trail_blue[i]->open)
    {
      trail_blue[i]->update();
      if (!trail_blue[i]->open && !(trail_blue[i]->trail))
        trail_blue.pop();
    }
    if (trail_orange[i]->open)
    {
      trail_orange[i]->update();
      if (!trail_orange[i]->open && !(trail_orange[i]->trail))
        trail_orange.pop();
    }
  }

}
