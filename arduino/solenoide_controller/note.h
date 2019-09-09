#ifndef note_h
#define note_h

#include <Arduino.h>
#include "global.h"

// Min time in milli seconds
#define PRESS_MIN_TIME 50

class Note
{
private:
    int pin;                     // pino do botão
    bool open;                   // estado foi finalizado?
    bool hold;                   // botão está pressionado?
    bool drop;                   // deve soltar?
    bool trail;                  // Define se a nota é um rastro ou não
    bool wait_offtime;           // Flag que faz update() esperar o offtime do rastro para soltar,
    unsigned long previous_time; // utilizado para contar o tempo
    unsigned long current_time;  // utilizado para contar o tempo para soltar

public:
    void update(void);

    // Método construtor de objeto
    Note(int pin, bool is_trace);
};

#endif