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
    void update_note(unsigned long, unsigned long);
    void update_trail(unsigned long);
};

/********************************************************************************************  
  Descrição Breve: Construtor do Nota

  Descrição Detalhada: 
*********************************************************************************************/
Note::Note(void)
{
    this->pin = 0;
    this->open = true;
    this->hold = false;
    this->drop = false;
    this->wait_offtime = false;
}

/********************************************************************************************  
  Descrição Breve: Método atualizador de nota

  Descrição da Entrada:
  (offtime) - Setado no ínicio da execução, define o tempo que a nota leva para passar do
  momento em que foi detectada até o momento de pressionar a nota.
  (press_min_time) - Define o tempo mínimo que a nota deve ser pressionada no aperto simples.

  Descrição Detalhada: 
*********************************************************************************************/
void Note::update_note(unsigned long offtime, unsigned long press_min_time)
{
    this->current_time = millis();

    /*  (Neste momento arduino espera o offtime para pressionar a nota)
        Verifica se a flag drop (soltar) está inativa e se já passou o offtime
        desde a detecção da nota. Se essas condições forem satisfeitas, então
        o arduino manda um pulso para pressionar a nota, reinicia o deltatime
        e ativa a flag drop.
    */
    if (!(this->drop) && (this->current_time - this->previous_time) >= offtime)
    {
        digitalWrite(this->pin, HIGH); // Aperta a nota
        this->drop = true;
        this->previous_time = millis(); // Reinicia deltatime
    }

    /*  (Neste momento arduino está pressionando a nota e espera press_min_time para soltar)
        Verifica se a flag drop (soltar) está ativa e se já passou o tempo mínimo
        para pressionar a nota. Se essas condições forem satisfeitas, então
        o arduino manda um pulso para soltar a nota e finaliza o estado.
    */
    else if (this->drop && (this->current_time - this->previous_time) >= press_min_time)
    {
        digitalWrite(this->pin, LOW); // Solta a nota
        this->open = false;           // Finaliza o estado
    }
}

/********************************************************************************************  
  Descrição Breve: Método atualizador de rastro

  Descrição da Entrada:
  (offtime) - Setado no ínicio da execução, define o tempo que a nota leva para passar do
  momento em que foi detectada até o momento de pressionar a nota.

  Descrição Detalhada: 
*********************************************************************************************/
void Note::update_trail(unsigned long offtime)
{
    this->current_time = millis();

    // TODO: REFAZER COMENTÁRIO
    /*
        Verifica se é um rastro e
        e se o tempo esperado se passou
    */
    if (!(this->hold) && (this->current_time - this->previous_time) >= offtime)
    {
        digitalWrite(this->pin, HIGH);
        this->hold = true;
    }

    // TODO: REFAZER COMENTÁRIO
    /*
        Reinicia o deltatime para soltar o rastro
        depois de passado o tempo do offtime
        É necessário para o arduíno não soltar o rastro
        antes do final do rastro
    */
    else if (this->hold && this->drop && !(this->wait_offtime))
    {
        // this->previous_time = millis(); // reinicia deltatime
        this->wait_offtime = true;
    }

    // TODO: REFAZER COMENTÁRIO
    /*
        Verifica se deve soltar, se está pressionado
        (caso contrário não faz sentido soltar,
        mas não é uma checagem obrigatória)
        e se se passou o offtime entre momento de
        detecção e ação
    */
    else if (this->wait_offtime && (this->current_time - this->previous_time) >= offtime)
    {
        digitalWrite(this->pin, LOW);
        this->hold = false;
        this->open = false;
    }
}

#endif
