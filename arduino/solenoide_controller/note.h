#ifndef note_h
#define note_h

#include "global.h"

// Min time in micro seconds
#define PRESS_MIN_TIME 50000

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
    Note(int pin, unsigned long offtime);
    void update(void);
};

#endif