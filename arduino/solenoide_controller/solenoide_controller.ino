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
    SimpleState(int pin, unsigned long prev, unsigned long offtime){
      pin=pin;
      pinMode(pin, OUTPUT);
      offTime = offtime;
      finished = false;
      previousMillis = prev;
    }

    void Update(){
        unsigned long currentMillis = millis();
        if((currentMillis-previousMillis)>= offTime){
          Serial.print(currentMillis);
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
    unsigned long offTime; // offtime entre detectar a nota e o momento de apertar
    unsigned long previousMillis;

  public:
    TraceState(int pin; unsigned long prev, unsigned long offTime){
      pin=pin;
      pinMode(pin, OUTPUT);
      finished = false;
      pressed = false;
      previousMillis = prev;
      offTime = offTime;
    }

    void Update(){
      // Aperta após passado o offtime
      unsigned long currentMillis = millis();
      if(!pressed && (currentMillis-previousMillis)>= offTime){
        digitalWrite(this->pin, HIGH);
        this->pressed = true;
      }
    }
    void Soltar(){
      digitalWrite(pin, LOW);
      this->pressed = false;
      finished = true;
    }
};

int L1 = 3;
unsigned long offtime = 1100;
unsigned char incomingByte = '\0';

int freeStates[N_SIMPLE_STATES]={1,1,1,1,1,1,1,1,1,1};
SimpleState *simpleStates[N_SIMPLE_STATES];
TraceState *traceStates[N_TRACE_STATES];
QueueArray <int> traceQueue;

int ind = 0, first_item;

void setup() {
  Serial.begin(115200);
  
  for(int i=0; i<N_SIMPLE_STATES; i++){
    freeStates[i] = 1;
    simpleStates[i] = new SimpleState(L1, millis(), offtime);
    simpleStates[i]->finished = true;
  }

  for(int i=0; i<N_TRACE_STATES; i++){
    traceStates[i] = new TraceState(L1, millis(), offtime);
    traceStates[i]->finished = true;
  }

  delay(5000);
}

void loop(){
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
    
    if(incomingByte == char(100)){
      ind=get_simpleStates_index();
      simpleStates[ind] = new SimpleState(L1, millis(), offtime);
      incomingByte = '\0';
    }
    
    if(incomingByte == char(101)){
      ind = get_traceStates_index();
      Serial.println(ind);
      traceStates[ind] = new TraceState(L1, millis(), offtime);
      traceQueue.push(ind);
      incomingByte = '\0';
    }

    if(incomingByte == char(102) && !traceQueue.isEmpty()){
      first_item = traceQueue.front();
      if(!traceStates[first_item]->finished && traceStates[first_item]->pressed){
        ind = traceQueue.pop();
        traceStates[ind]->Soltar();
        incomingByte = '\0';
      }
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
