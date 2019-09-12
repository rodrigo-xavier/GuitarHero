#ifndef NOTE_H
#define NOTE_H

#include <Arduino.h>
// using namespace std;

class Note
{
private:
    bool hold;                   // botão está pressionado?
    bool wait_offtime;           // Flag que faz update() esperar o offtime do rastro para soltar,
    unsigned long previous_time; // utilizado para contar o tempo
    unsigned long current_time;  // utilizado para contar o tempo para soltar

public:
    int pin;   // pino do botão
    bool drop; // deve soltar?
    bool open; // estado foi finalizado?

    Note();
    void update_note(void);
    void update_trail(void);
};

#endif
