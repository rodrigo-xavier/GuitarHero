#ifndef note_h
#define note_h

#include <QueueArray.h>

class Note
{
private:
    int pin;                     // pino do botão
    bool open;                   // estado foi finalizado?
    bool pressed;                // botão está pressionado?
    bool drop;                   // deve soltar?
    unsigned long offtime;       // offtime entre detectar a nota e o momento de apertar
    unsigned long previous_time; // utilizado para contar o tempo
    unsigned long current_time;  // utilizado para contar o tempo para soltar

public:
    Note(int pin, unsigned long offtime);
    void press(void);
    void press_and_hold(void);
    void drop(int offtime);
    void set_time(void);
    // ~Note()
};

#endif