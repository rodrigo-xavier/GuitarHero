#include "note.h"

Note::Note()
{
    this->pin = 0;
    this->open = true;
    this->hold = false;
    this->drop = false;
    this->wait_offtime = false;
    this->previous_time = millis();
}

void Note::update_note(void)
{
    this->current_time = millis();

    /*
        Se não tem que soltar, então deve apertar
        após o tempo de OFFTIME (tempo entre nota passar)
        e o momento de apertar
        */
    if (!(this->drop) && (this->current_time - this->previous_time) >= OFFTIME)
    {
        digitalWrite(this->pin, HIGH);  // aperta
        this->drop = true;              // agora deve soltar após o tempo mínimo
        this->previous_time = millis(); // reinicia deltatime
    }

    /*
        Se tiver que soltar, verifica se já se passou o tempo mínimo
        */
    else if (this->drop && (this->current_time - this->previous_time) >= PRESS_MIN_TIME)
    {
        digitalWrite(this->pin, LOW); // solta
        this->open = false;           // estado finalizado
    }
}

void Note::update_trail(void)
{
    this->current_time = millis();

    /*
        Verifica se é um rastro e
        e se o tempo esperado se passou
        */
    if (!(this->hold) && (this->current_time - this->previous_time) >= OFFTIME)
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
    else if (this->hold && this->drop && !(this->wait_offtime))
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
    else if (this->wait_offtime && (this->current_time - this->previous_time) >= OFFTIME)
    {
        digitalWrite(this->pin, LOW);
        this->hold = false;
        this->open = false;
    }
}