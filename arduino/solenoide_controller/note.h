#ifndef note_h
#define note_h

#include <QueueArray.h>

class Note
{
private:
    int pin;                     // pino do botão
    bool open;                   // estado foi finalizado?
    bool hold;                   // botão está pressionado?
    bool drop;                   // deve soltar?
    bool trail;                  // Define se a nota é um rastro ou não
    bool wait_offtime;           // Flag que faz update() esperar o offtime do rastro para soltar,
    unsigned long offtime;       // offtime entre detectar a nota e o momento de apertar
    unsigned long previous_time; // utilizado para contar o tempo
    unsigned long current_time;  // utilizado para contar o tempo para soltar

public:
    Note(int pin, unsigned long offtime);
    void update(void);
    void set_time(void);
};

#endif