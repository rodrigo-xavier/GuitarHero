#ifndef NOTE_H
#define NOTE_H

#include <Arduino.h>

/********************************************************************************************  
  Descrição Breve: Classe de Nota

  Descrição da Entrada:
  (pin) - Pino digital do arduino relacionado com a nota
  (hold) - Flag que define se a nota está sendo pressionada ou não
  (drop) - Flag que aciona o comando de soltar nota
  (open) - Flag que verifica se o estado da nota está aberto
  (wait_offtime) - Flag que faz update_trail() esperar o offtime do rastro para soltar a nota
  (current_time) - Variável que pega o tempo atual
  (previous_time) - Variável que pega o tempo anterior

  Descrição Detalhada: Define a estrutura Nota, que contém o estado de aberto/fechado,
  o pino do arduino equivalente à nota, e algumas flags utilizadas pelos métodos
  da estrutura. A função principal desta estrutura é atualizar os pinos do arduino
  de acordo com os comandos recebidos pelo matlab.
*********************************************************************************************/
class Note
{
private:
    bool hold;
    bool wait_offtime;
    unsigned long current_time;

public:
    int pin;
    bool drop;
    bool open;
    unsigned long previous_time;

    Note(void);
    ~Note(void);
    void update_note(unsigned long, unsigned long);
    void update_trail(unsigned long);
};

/********************************************************************************************  
  Descrição Breve: Construtor de Nota

  Descrição Detalhada: Seta os valores iniciais da nota. É importante que a nota seja criada
  com open==false, para que não ocorram bugs.
*********************************************************************************************/
Note::Note(void)
{
    pin = 0;
    open = false;
    hold = false;
    drop = false;
    wait_offtime = false;
}

/********************************************************************************************  
  Descrição Breve: Destrutor de Nota

  Descrição Detalhada: Seta o estado da nota para fechado/encerrado. Em teoria deve ser
  utilizado pelo método pop() da fila. Porém não é realmente utilizado, pois ocorrem bugs
  inesplicáveis. Provável que o compilador não lide bem com o método destrutor.
*********************************************************************************************/
Note::~Note(void)
{
    open = false;
}

/********************************************************************************************  
  Descrição Breve: Método atualizador de nota

  Descrição da Entrada:
  (offtime) - Setado no ínicio da execução, define o tempo que a nota leva para passar do
  momento em que foi detectada até o momento de pressionar a nota.
  (press_min_time) - Define o tempo mínimo que a nota deve ser pressionada no aperto simples.

  Descrição Detalhada: Este método fica à todo momento capturando o tempo atual e comparando
  com o tempo em que a nota foi inserida na fila, para que, desta forma seja possível realizar
  o "processamento paralelo do código" em relação às outras notas, grosseiramente falando.
  A primeira condiçao verifica se a nota não foi pressionada e se passou o OFFTIME, e então
  ela pressiona a nota. 
  A segunda condição, verifica se a nota está sendo pressionada e se passou o PRESS_MIN_TIME, 
  e então ela solta a nota e fecha/encerra o estado da nota.
*********************************************************************************************/
void Note::update_note(unsigned long offtime, unsigned long press_min_time)
{
    noInterrupts();

    current_time = millis();

    if (!(drop) && (current_time - previous_time) >= offtime)
    {
        digitalWrite(pin, HIGH); // Aperta a nota
        drop = true;
        previous_time = millis(); // Reinicia o deltatime (Para calcular o press_min_time corretamente)
    }

    else if (drop && (current_time - previous_time) >= press_min_time)
    {
        digitalWrite(pin, LOW); // Solta a nota
        open = false;
    }

    interrupts();
}

/********************************************************************************************  
  Descrição Breve: Método atualizador de nota

  Descrição da Entrada:
  (offtime) - Setado no ínicio da execução, define o tempo que o rastro leva para passar do
  momento em que foi detectada até o momento de pressionar o rastro.

  Descrição Detalhada: Este método fica à todo momento capturando o tempo atual e comparando
  com o tempo em que o rastro foi inserido na fila, para que, desta forma seja possível realizar
  o "processamento paralelo do código" em relação os outros rastros, grosseiramente falando.
  A primeira condiçao verifica se o rastro não foi pressionado e se passou o OFFTIME, e então
  ela pressiona o rastro. 
  A segunda condição, verifica se o rastro está sendo pressionado e se foi lançado o comando
  para soltar o rastro, e então é lançada uma flag para que o arduino espere o offtime para 
  soltar o rastro.
  A terceira e última condição, verifica se a flag para soltar o rastro foi ativada, e se 
  passou o OFFTIME, e então ela solta o rastro e fecha/encerra o estado do rastro.
*********************************************************************************************/
void Note::update_trail(unsigned long offtime)
{
    // Serial.print("d");
    noInterrupts();

    current_time = millis();

    if (!(hold) && (current_time - previous_time) >= offtime)
    {
        // Serial.print("e");
        digitalWrite(pin, HIGH);
        hold = true;
    }
    else if (hold && drop && !(wait_offtime))
    {
        // Serial.print("f");
        previous_time = millis(); // reinicia deltatime
        wait_offtime = true;
    }
    else if (wait_offtime && (current_time - previous_time) >= offtime)
    {
        digitalWrite(pin, LOW);
        hold = false;
        open = false;
    }

    interrupts();
}

#endif
