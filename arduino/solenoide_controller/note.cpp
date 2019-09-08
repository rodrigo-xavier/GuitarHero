#include "note.h"

// Método construtor de objeto
Note::Note(int pin, unsigned long offtime)
{
    this->pin = pin;
    this->open = true;
    this->hold = false;
    this->drop = false;
    this->trail = false;
    this->wait_offtime = false;
    this->offtime = offtime;
    this->previous_time = micro();
}

void Note::update(void)
{
    this->current_time = micro();

    if (this->open)
    {
        // Se não tem que soltar, então deve apertar
        // após o tempo de offtime (tempo entre nota passar)
        // e o momento de apertar
        if (!(this->drop) && (this->current_time - this->previous_time) >= this->offtime)
        {
            digitalWrite(this->pin, HIGH); // aperta
            this->drop = true;             // agora deve soltar após o tempo mínimo
            this->previous_time = micro(); // reinicia deltatime
        }

        // Se tiver que soltar, verifica se já se passou o tempo mínimo
        else if (this->drop && (this->current_time - this->previous_time) >= PRESS_MIN_TIME)
        {
            digitalWrite(this->pin, LOW); // solta
            this->open = false;           // estado finalizado
        }

        // Verifica se é um rastro e
        // Aperta se já não estiver pressionado (não é uma
        // checagem obrigatória, mas por segurança)
        // e se o tempo esperado se passou
        else if (this->trail && !(this->hold) && (this->current_time - this->previous_time) >= this->offtime)
        {
            digitalWrite(this->pin, HIGH);
            this->hold = true;
        }

        // Reinicia o deltatime para soltar o rastro
        // depois de passado o tempo do offtime
        // É necessário para o arduíno não soltar o rastro
        // antes do final do rastro
        else if (this->trail && this->hold && this->drop && !(this->wait_offtime))
        {
            this->previous_time = micro(); // reinicia deltatime
            this->wait_offtime = true;
        }

        // Verifica se deve soltar, se está pressionado
        // (caso contrário não faz sentido soltar,
        // mas não é uma checagem obrigatória)
        // e se se passou o offtime entre momento de
        // detecção e ação
        else if (this->trail && this->wait_offtime && (this->current_time - this->previous_time) >= this->offtime)
        {
            digitalWrite(this->pin, LOW);
            this->hold = false;
            this->open = false;
        }
    }
}

// Recebe o tempo de offtime do MATLAB
// para nota simples
void Note::set_time(void)
{
    if (Serial.available() > 0)
    {
        if (offtime != 0)
        {
            break;
        }
        incomingByte = Serial.read();
        if (incomingByte == 'a')
        {
            String str = Serial.readStringUntil('b');
            offtime = str.toInt();
            Serial.print(offtime);
            incomingByte = '\0';
        }
    }
}