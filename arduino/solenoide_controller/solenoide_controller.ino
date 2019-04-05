#include <QueueArray.h>

#define N_SIMPLE_STATES 10
#define N_TRACE_STATES 10

class SimpleState{
  public:
    int pin;
    unsigned long offTime; // offtime entre detectar a nota e o momento de apertar
    bool finished;
    unsigned long previousMillis;
    
  public:
    SimpleState(unsigned long prev, unsigned long off){
      pin=3;
      pinMode(pin, OUTPUT);
      offTime = off;
      finished = false;
      previousMillis = prev;
    }

    void Update(){
        unsigned long currentMillis = millis();
        if((currentMillis-previousMillis)>= offTime){
          digitalWrite(pin, HIGH);
          delay(50);
          digitalWrite(pin, LOW);
          this->finished = true;
        }
    }
};

class TraceState{
  public:
    int pin;
    bool finished;
    bool pressed;
    bool soltar;
    unsigned long offTime; // offtime entre detectar a nota e o momento de apertar
    unsigned long previousMillis;
    unsigned long previousMillisFree;

  public:
    TraceState(unsigned long prev, unsigned long off){
      pin=3;
      pinMode(pin, OUTPUT);
      finished = false;
      pressed = false;
      previousMillis = prev;
      previousMillisFree = prev;
      soltar = false;
      offTime = off;
    }

    void Update(){
      // Aperta após passado o offtime
      unsigned long currentMillis = millis();
      // Solta
      if(soltar && !finished && pressed && (currentMillis-previousMillisFree)>= offTime){
        digitalWrite(this->pin, LOW);
        this->pressed = false;
        finished = true;
      }
      // Aperta
      if(!pressed && !finished && (currentMillis-previousMillis)>= offTime){
        digitalWrite(this->pin, HIGH);
        this->pressed = true;
      }
    }
    void Soltar(unsigned long prev_free, int off){
      this->soltar = true;
      this->previousMillisFree = prev_free;
      this->offTime = off;
    }
};

int L1 = 3;
unsigned long offtime_simple = 0;
unsigned long offtime_rastro = 0;
unsigned char incomingByte = '\0';

int freeStates[N_SIMPLE_STATES]={1,1,1,1,1,1,1,1,1,1};
SimpleState *simpleStates[N_SIMPLE_STATES];
TraceState *traceStates[N_TRACE_STATES];
QueueArray <int> traceQueue;

int ind = 0, first_item;

void setup() {
  Serial.begin(115200);
  
  // Inicializa os estados
  for(int i=0; i<N_SIMPLE_STATES; i++){
    freeStates[i] = 1;
    simpleStates[i] = new SimpleState(millis(), offtime_simple);
    simpleStates[i]->finished = true;
  }

  for(int i=0; i<N_TRACE_STATES; i++){
    traceStates[i] = new TraceState(millis(), offtime_rastro);
    traceStates[i]->finished = true;
  }

  delay(1000);
}

void loop(){
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
    
    // Estado simples: aperta e solta automaticamente 
    // o mais rápido possível
    if(incomingByte == char(100)){
      ind=get_simpleStates_index();
      simpleStates[ind] = new SimpleState(millis(), offtime_simple);
      incomingByte = '\0';
    }

    // Estado de rastro: Aperta sem soltar
    if(incomingByte == char(101)){
      ind = get_traceStates_index();
      traceStates[ind] = new TraceState(millis(), offtime_rastro);
      traceQueue.push(ind);
      incomingByte = '\0';
    }

    // Estado de rastro: Solta
    if(incomingByte == char(102) && !traceQueue.isEmpty()){
      first_item = traceQueue.front();
      if(!traceStates[first_item]->finished){
        ind = traceQueue.pop();
        traceStates[ind]->Soltar(millis(),offtime_simple);
        incomingByte = '\0';
      }
    }

    // Obtem o tempo de offtime de nota simples
    if(incomingByte == char(90)){
      offtime_simple = 0;
      getSimpleTime();
    }

    // Obtem o tempo de offtime de nota de rastro
    if(incomingByte == char(91)){
      offtime_rastro = 0;
      getRastroTime();
    }
    
  }

  checkAllOnStates();
  
}

int get_simpleStates_index(){
  for(int i=0; i<N_SIMPLE_STATES; i++){
    if(simpleStates[i]->finished)
      return i;
  }
  return -1;
}

int get_traceStates_index(){
  for(int i=0; i<N_TRACE_STATES; i++){
    if(traceStates[i]->finished)
      return i;
  }
  return -1;
}

void checkAllOnStates(){
  for(int i=0; i<N_SIMPLE_STATES; i++){
    if(!simpleStates[i]->finished) // se nao foi finished ainda
      simpleStates[i]->Update();
    

    if(i < N_TRACE_STATES){
      if(!traceStates[i]->finished)
        traceStates[i]->Update();
    }
  }
}

void getSimpleTime(){
  while(true){
    if (Serial.available() > 0) {
      if(offtime_simple != 0){
        break;
      }
      incomingByte = Serial.read();
      if(incomingByte == 'a'){
        String str = Serial.readStringUntil('b');
        offtime_simple = str.toInt();
        Serial.print(offtime_simple);
        incomingByte = '\0';
      }
    }
  }
}

void getRastroTime(){
  while(true){
    if (Serial.available() > 0) {
      if(offtime_rastro != 0){
        break;
      }
      incomingByte = Serial.read();
      if(incomingByte == 'a'){
        String str = Serial.readStringUntil('b');
        offtime_rastro = str.toInt();
        Serial.print(offtime_rastro);
        incomingByte = '\0';
      }
    }
  }
}