#ifndef NOTE_H
#define NOTE_H

#include <Arduino.h>

class Note
{
private:
    bool hold;                   // Flag de nota pressionada
    bool wait_offtime;           // Flag que faz update_states() esperar o offtime do rastro para soltar,
    unsigned long previous_time; // Variável que pega o tempo anterior
    unsigned long current_time;  // Variável que pega o tempo atual

public:
    int pin;   // Pino digital relacionado com a nota
    bool drop; // Flag que aciona o comando de soltar nota
    bool open; // Flag que verifica se o estado está aberto

    /* (Método Construtor de Nota)
        Inicializa as flags e variáveis da nota. Não foi possível definir no .h
    */
    Note()
    {
        this->pin = 0;
        this->open = true;
        this->hold = false;
        this->drop = false;
        this->wait_offtime = false;
        this->previous_time = millis();
    }
    void update_note(unsigned long, unsigned int);
    void update_trail(unsigned long);
};

#endif
