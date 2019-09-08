#include "note.h"

Note::Note(int pin, unsigned long off)
{
    // Método construtor de objeto
    this->pin = pin;
    this->offTime = off;
    this->finished = false;
    this->previousMillis = millis();
    this->previousMillisFree = millis();
    this->soltar = false;
    this->pressed = false;
}

// Método destrutor
// Note::~Note()
// {
// }

// void Note::update(void)
// {
// }

void Note::press(void)
{
    unsigned long currentMillis = millis();
    // Se ainda não terminou
    if (!(this->finished))
    {
        // Se não tem que soltar, então deve apertar
        // após o tempo de offtime (tempo entre nota passar)
        // e o momento de apertar
        if (!(this->soltar) && (currentMillis - this->previousMillis) >= this->offTime)
        {
            digitalWrite(this->pin, HIGH);   // aperta
            this->soltar = true;             // agora deve soltar após o tempo mínimo
            this->previousMillis = millis(); // reinicia deltatime
        }
        // Se tiver que soltar, verifica se já se passou o tempo mínimo
        if (this->soltar && (currentMillis - this->previousMillis) >= PRESS_MIN_TIME)
        {
            digitalWrite(this->pin, LOW); // solta
            this->finished = true;        // estado finalizado
            this->soltar = false;         // não era necessário desabilitar o soltar, mas só por segurança
        }
    }
}

void Note::press_and_hold()
{
    // Aperta após passado o offtime
    unsigned long currentMillis = millis();
    // Verifica se já não é um estado finalizado
    if (!(this->finished))
    {
        // Verifica se deve soltar, se está pressionado
        // (caso contrário não faz sentido soltar,
        // mas não é uma checagem obrigatória)
        // e se se passou o offtime entre momento de
        // detecção e ação
        if (this->soltar && this->pressed && (currentMillis - this->previousMillisFree) >= this->offTime)
        {
            digitalWrite(this->pin, LOW);
            this->pressed = false;
            this->finished = true;
        }
        // Aperta se já não estiver pressionado (não é uma
        // checagem obrigatória, mas por segurança)
        // e se o tempo esperado se passou
        else if (!(this->pressed) && (currentMillis - this->previousMillis) >= this->offTime)
        {
            digitalWrite(this->pin, HIGH);
            this->pressed = true;
        }
    }
}

void Note::drop(int off)
{
    // Seta soltar como true, alterando o offtime
    // já que o offtime de soltar é diferente do offtime
    // de segurar, para o rastro
    this->soltar = true;
    this->previousMillisFree = millis(); //reinicia o deltatime
    this->offTime = off;
}