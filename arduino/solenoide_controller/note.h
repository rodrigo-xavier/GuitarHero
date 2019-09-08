#ifndef note_h
#define note_h

#include <QueueArray.h>

class Note
{
private:
    int pin;                          // pino do botão
    bool pressed;                     // botão está pressionado?
    bool finished;                    // estado foi finalizado?
    bool soltar;                      // deve soltar?
    unsigned long offTime;            // offtime entre detectar a nota e o momento de apertar
    unsigned long previousMillis;     // utilizado para contar o tempo
    unsigned long previousMillisFree; // utilizado para contar o tempo para soltar

public:
    Note(int pin, unsigned long off);
    void press(void);
    void press_and_hold(void);
    void drop(int off);
    // ~Note()
};

#endif