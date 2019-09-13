#include <Arduino.h>
#include "note.h"

void Note::update_note(unsigned long offtime, unsigned int press_min_time)
{
    // this->current_time = millis();

    /*
        Se não tem que soltar, então deve apertar
        após o tempo de offtime (tempo entre nota passar)
        e o momento de apertar
        */
    if (!(this->drop) && (this->current_time - this->previous_time) >= offtime)
    {
        digitalWrite(this->pin, HIGH);  // aperta
        this->drop = true;              // agora deve soltar após o tempo mínimo
        this->previous_time = millis(); // reinicia deltatime
    }

    /*
        Se tiver que soltar, verifica se já se passou o tempo mínimo
        */
    else if (this->drop && (this->current_time - this->previous_time) >= press_min_time)
    {
        digitalWrite(this->pin, LOW); // solta
        this->open = false;           // estado finalizado
    }
}

void Note::update_trail(unsigned long offtime)
{
    // this->current_time = millis();

    /*
        Verifica se é um rastro e
        e se o tempo esperado se passou
        */
    if (!(this->hold) && (this->current_time - this->previous_time) >= offtime)
    {
        digitalWrite(this->pin, HIGH);
        this->hold = true;
    }

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