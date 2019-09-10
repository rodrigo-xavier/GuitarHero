#include <Arduino.h>
#include "note.h"

Note::Note(int pin, bool is_trace)
{
    this->pin = pin;
    this->open = true;
    this->hold = false;
    this->drop = false;
    this->trail = is_trace;
    this->wait_offtime = false;
    this->previous_time = millis();
}

void Note::update(void)
{
    this->current_time = millis();

    if (this->open)
    {
        /*
        Se não tem que soltar, então deve apertar
        após o tempo de OFFTIME (tempo entre nota passar)
        e o momento de apertar
        */
        if (!(this->trail) && !(this->drop) && (this->current_time - this->previous_time) >= OFFTIME)
        {
            digitalWrite(this->pin, HIGH);  // aperta
            this->drop = true;              // agora deve soltar após o tempo mínimo
            this->previous_time = millis(); // reinicia deltatime
        }

        /*
        Se tiver que soltar, verifica se já se passou o tempo mínimo
        */
        else if (!(this->trail) && this->drop && (this->current_time - this->previous_time) >= PRESS_MIN_TIME)
        {
            digitalWrite(this->pin, LOW); // solta
            this->open = false;           // estado finalizado
        }

        /*
        Verifica se é um rastro e
        e se o tempo esperado se passou
        */
        else if (this->trail && !(this->hold) && (this->current_time - this->previous_time) >= OFFTIME)
        {
            digitalWrite(this->pin, HIGH);
            this->hold = true;
        }

        /*
        Reinicia o deltatime para soltar o rastro
        depois de passado o tempo do OFFTIME
        É necessário para o arduíno não soltar o rastro
        antes do final do rastro
        */
        else if (this->trail && this->hold && this->drop && !(this->wait_offtime))
        {
            this->previous_time = millis(); // reinicia deltatime
            this->wait_offtime = true;
        }

        /*
        Verifica se deve soltar, se está pressionado
        (caso contrário não faz sentido soltar,
        mas não é uma checagem obrigatória)
        e se se passou o OFFTIME entre momento de
        detecção e ação
        */
        else if (this->trail && this->wait_offtime && (this->current_time - this->previous_time) >= OFFTIME)
        {
            digitalWrite(this->pin, LOW);
            this->hold = false;
            this->open = false;
        }
    }
}