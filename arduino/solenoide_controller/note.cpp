#include "note.h"

// Método construtor de objeto
Note::Note(int pin, unsigned long offtime)
{
    this->pin = pin;
    this->open = false;
    this->pressed = false;
    this->drop = false;
    this->offtime = offtime;
    this->previous_time = micro();
    // this->current_time = micro();
}

// Método destrutor
// Note::~Note()
// {
// }

void Note::press(void)
{
    this->current_time = micro();

    if (!(this->open))
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
            this->open = true;            // estado finalizado
            this->drop = false;           // não era necessário desabilitar o soltar, mas só por segurança
        }
    }
}

void Note::press_and_hold()
{
    this->current_time = micro();

    if (!(this->open))
    {
        // Aperta se já não estiver pressionado (não é uma
        // checagem obrigatória, mas por segurança)
        // e se o tempo esperado se passou
        if (!(this->pressed) && (this->current_time - this->previous_time) >= this->offtime)
        {
            digitalWrite(this->pin, HIGH);
            this->pressed = true;
        }

        // Verifica se deve soltar, se está pressionado
        // (caso contrário não faz sentido soltar,
        // mas não é uma checagem obrigatória)
        // e se se passou o offtime entre momento de
        // detecção e ação
        else if (this->drop && this->pressed && (this->current_time - this->previous_time) >= this->offtime)
        {
            digitalWrite(this->pin, LOW);
            this->pressed = false;
            this->open = true;
        }
    }
}

void Note::drop(int offtime)
{
    // Seta soltar como true, e reinicia o deltatime
    this->drop = true;
    this->previous_time = micro();
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