#include <QueueArray.h>

#define N_SIMPLE_STATES 10
#define N_TRACE_STATES 10

class SimpleState{
  public:
    int pin;
    unsigned long offTime; // offtime entre detectar a nota e o momento de apertar
    bool finished;
    bool soltar;
    unsigned long previousMillis;
    
  public:
    SimpleState(int pin, unsigned long off){
      this->pin=pin;
      pinMode(this->pin, OUTPUT);
      this->offTime = off;
      this->finished = false;
      this->previousMillis = millis();
      this->soltar = false;
    }

    void Update(){
        unsigned long currentMillis = millis();
        if(!(this->soltar) &&  !(this->finished) &&
            (currentMillis-this->previousMillis)>= this->offTime){
          digitalWrite(this->pin, HIGH);
          this->soltar = true;
          this->previousMillis = millis();
        }
        if(this->soltar && !(this->finished) &&
          (currentMillis-this->previousMillis)>=50){
          digitalWrite(this->pin, LOW);
          this->finished = true;
          this->soltar = false;
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
    TraceState(int pin, unsigned long off){
      this->pin=pin;
      pinMode(this->pin, OUTPUT);
      this->finished = false;
      this->pressed = false;
      this->previousMillis = millis();
      this->previousMillisFree = millis();
      this->soltar = false;
      this->offTime = off;
    }

    void Update(){
      // Aperta após passado o offtime
      unsigned long currentMillis = millis();
      // Solta
      if(this->soltar && !(this->finished) && this->pressed && 
        (currentMillis-this->previousMillisFree)>= this->offTime){
        digitalWrite(this->pin, LOW);
        this->pressed = false;
        this->finished = true;
      }
      // Aperta
      if(!(this->pressed) && !(this->finished) && 
        (currentMillis-this->previousMillis)>= this->offTime){
        digitalWrite(this->pin, HIGH);
        this->pressed = true;
      }
    }
    void Soltar(int off){
      this->soltar = true;
      this->previousMillisFree = millis();
      this->offTime = off;
    }
};

volatile unsigned long offtime_simple = 0;
volatile unsigned long offtime_rastro = 0;

#define L1_PIN 3
#define L2_PIN 2
#define R1_PIN 4
#define R2_PIN 5
#define X_PIN 6

uint8_t incBytes[] = {0, 0};
unsigned char incomingByte = '\0';
uint16_t commands = 0;

// Red States
SimpleState *redSimpleStates[N_SIMPLE_STATES];
TraceState *redTraceStates[N_TRACE_STATES];
QueueArray <int> redTraceQueue;

// Green States
SimpleState *greenSimpleStates[N_SIMPLE_STATES];
TraceState *greenTraceStates[N_TRACE_STATES];
QueueArray <int> greenTraceQueue;

// Yellow States
SimpleState *yellowSimpleStates[N_SIMPLE_STATES];
TraceState *yellowTraceStates[N_TRACE_STATES];
QueueArray <int> yellowTraceQueue;

// Blue States
SimpleState *blueSimpleStates[N_SIMPLE_STATES];
TraceState *blueTraceStates[N_TRACE_STATES];
QueueArray <int> blueTraceQueue;

// Orange States
SimpleState *orangeSimpleStates[N_SIMPLE_STATES];
TraceState *orangeTraceStates[N_TRACE_STATES];
QueueArray <int> orangeTraceQueue;

// Temporary variables
int ind=0, first_item=0;

void setup() {
  Serial.begin(115200);
  
  // Inicializa os estados simples
  for(int i=0; i<N_SIMPLE_STATES; i++){
    redSimpleStates[i] = new SimpleState(L1_PIN, offtime_simple);
    redSimpleStates[i]->finished = true;

    greenSimpleStates[i] = new SimpleState(L2_PIN, offtime_simple);
    greenSimpleStates[i]->finished = true;

    yellowSimpleStates[i] = new SimpleState(R1_PIN, offtime_simple);
    yellowSimpleStates[i]->finished = true;

    blueSimpleStates[i] = new SimpleState(R2_PIN, offtime_simple);
    blueSimpleStates[i]->finished = true;

    orangeSimpleStates[i] = new SimpleState(X_PIN, offtime_simple);
    orangeSimpleStates[i]->finished = true;    
  }

  // Inicializa os estados de rastros
  for(int i=0; i<N_TRACE_STATES; i++){
    redTraceStates[i] = new TraceState(L1_PIN, offtime_rastro);
    redTraceStates[i]->finished = true;

    greenTraceStates[i] = new TraceState(L2_PIN, offtime_rastro);
    greenTraceStates[i]->finished = true;

    yellowTraceStates[i] = new TraceState(R1_PIN, offtime_rastro);
    yellowTraceStates[i]->finished = true;

    blueTraceStates[i] = new TraceState(R2_PIN, offtime_rastro);
    blueTraceStates[i]->finished = true;

    orangeTraceStates[i] = new TraceState(X_PIN, offtime_rastro);
    orangeTraceStates[i]->finished = true;
  }

  delay(1000);
}

void loop(){
  if (Serial.available() >= 2) {
    incBytes[0] = Serial.read();
    incBytes[1] = Serial.read();
    commands = ( (incBytes[1] << 8) | incBytes[0]);
    
    // Estado simples: aperta e solta automaticamente 
    // o mais rápido possível

    // Green (L2_PIN)
    if(bitRead(commands, 0)){
      ind=get_simpleStates_index('G');
      greenSimpleStates[ind] = new SimpleState(L2_PIN, offtime_simple);
    }

    // Red (L1_PIN)
    if(bitRead(commands, 1)){
      ind=get_simpleStates_index('R');
      redSimpleStates[ind] = new SimpleState(L1_PIN, offtime_simple);
    }

    // Yellow (R1_PIN)
    if(bitRead(commands, 2)){
      ind=get_simpleStates_index('Y');
      yellowSimpleStates[ind] = new SimpleState(R1_PIN, offtime_simple);
    }

    // Blue (R1_PIN)
    if(bitRead(commands, 3)){
      ind=get_simpleStates_index('B');
      blueSimpleStates[ind] = new SimpleState(R2_PIN, offtime_simple);
    }

    // Orange (X_PIN)
    if(bitRead(commands, 4)){
      ind=get_simpleStates_index('O');
      orangeSimpleStates[ind] = new SimpleState(X_PIN, offtime_simple);
    }


    // ----------------------------------------------------- //
    // Comandos relacionados com o rastro

    // Estado de rastro: Aperta sem soltar

    // Green (L2_PIN)
    if(bitRead(commands, 5)){
      ind = get_traceStates_index('G');
      greenTraceStates[ind] = new TraceState(L2_PIN, offtime_rastro);
      greenTraceQueue.push(ind);
    }

    // Red (L1_PIN)
    if(bitRead(commands, 6)){
      ind = get_traceStates_index('R');
      redTraceStates[ind] = new TraceState(L1_PIN, offtime_rastro);
      redTraceQueue.push(ind);
    }

    // Yellow (R1_PIN)
    if(bitRead(commands, 7)){
      ind = get_traceStates_index('Y');
      yellowTraceStates[ind] = new TraceState(R1_PIN, offtime_rastro);
      yellowTraceQueue.push(ind);
    }

    // Blue (R2_PIN)
    if(bitRead(commands, 8)){
      ind = get_traceStates_index('B');
      blueTraceStates[ind] = new TraceState(R2_PIN, offtime_rastro);
      blueTraceQueue.push(ind);
    }

    // Orange (X_PIN)
    if(bitRead(commands, 9)){
      ind = get_traceStates_index('O');
      orangeTraceStates[ind] = new TraceState(X_PIN, offtime_rastro);
      orangeTraceQueue.push(ind);
    }

    // ------ //

    // Estado de rastro: Solta
    
    // Green (R1_PIN)
    if(bitRead(commands, 10) && !greenTraceQueue.isEmpty()){
      first_item = greenTraceQueue.front();
      if(!greenTraceStates[first_item]->finished){
        ind = greenTraceQueue.pop();
        greenTraceStates[ind]->Soltar(offtime_simple);
      }
    }

    // Red (L1_PIN)
    if(bitRead(commands, 11) && !redTraceQueue.isEmpty()){
      first_item = redTraceQueue.front();
      if(!redTraceStates[first_item]->finished){
        ind = redTraceQueue.pop();
        redTraceStates[ind]->Soltar(offtime_simple);
      }
    }

    if(bitRead(commands, 12) && !yellowTraceQueue.isEmpty()){
      first_item = yellowTraceQueue.front();
      if(!yellowTraceStates[first_item]->finished){
        ind = yellowTraceQueue.pop();
        yellowTraceStates[ind]->Soltar(offtime_simple);
      }
    }

    // Blue (R2_PIN)
    if(bitRead(commands, 13) && !blueTraceQueue.isEmpty()){
      first_item = blueTraceQueue.front();
      if(!blueTraceStates[first_item]->finished){
        ind = blueTraceQueue.pop();
        blueTraceStates[ind]->Soltar(offtime_simple);
      }
    }
        
    // Orange (X_PIN)
    if(bitRead(commands, 14) && !orangeTraceQueue.isEmpty()){
      first_item = orangeTraceQueue.front();
      if(!orangeTraceStates[first_item]->finished){
        ind = orangeTraceQueue.pop();
        orangeTraceStates[ind]->Soltar(offtime_simple);
      }
    }

    // Configuração de tempo
    if(bitRead(commands, 15)){
      while(true){
        if (Serial.available() > 0) {
          incomingByte = Serial.read();
          // Obtem o tempo de offtime de nota simples
          if(incomingByte == char(90)){
            Serial.print("OK");
            getSimpleTime();
            break;
          }
          // Obtem o tempo de offtime de nota de rastro
          if(incomingByte == char(91)){
            Serial.print("OK");
            getRastroTime();
            break;
          }
        }
      }
      incomingByte == '\0';
    }

    incBytes[0] = 0;
    incBytes[1] = 0;
    commands = 0;
  }

  checkAllOnStates();
  
}

int get_simpleStates_index(char color){
  // Função que retorna o índice do array
  // a ser utilizado para alocar o estado 

  if(color == 'R'){
    for(int i=0; i<N_SIMPLE_STATES; i++){
      if(redSimpleStates[i]->finished)
        return i;
    }
  }
  else if(color == 'G'){
    for(int i=0; i<N_SIMPLE_STATES; i++){
      if(greenSimpleStates[i]->finished)
        return i;
    }
  }
  else if(color == 'Y'){
    for(int i=0; i<N_SIMPLE_STATES; i++){
      if(yellowSimpleStates[i]->finished)
        return i;
    }
  }
  else if(color == 'B'){
    for(int i=0; i<N_SIMPLE_STATES; i++){
      if(blueSimpleStates[i]->finished)
        return i;
    }
  }
  else if(color == 'O'){
    for(int i=0; i<N_SIMPLE_STATES; i++){
      if(orangeSimpleStates[i]->finished)
        return i;
    }
  }

  return -1;
}

int get_traceStates_index(char color){
  // Função que retorna o índice do array
  // a ser utilizado para alocar o estado 

  if(color == 'R'){
    for(int i=0; i<N_TRACE_STATES; i++){
      if(redTraceStates[i]->finished)
        return i;
    }
  }
  else if(color == 'G'){
    for(int i=0; i<N_TRACE_STATES; i++){
      if(greenTraceStates[i]->finished)
        return i;
    }
  }
  else if(color == 'Y'){
    for(int i=0; i<N_TRACE_STATES; i++){
      if(yellowTraceStates[i]->finished)
        return i;
    }
  }
  else if(color == 'B'){
    for(int i=0; i<N_TRACE_STATES; i++){
      if(blueTraceStates[i]->finished)
        return i;
    }
  }
  else if(color == 'O'){
    for(int i=0; i<N_TRACE_STATES; i++){
      if(orangeTraceStates[i]->finished)
        return i;
    }
  }

  return -1;
}

void checkAllOnStates(){
  // Verifica todos os estados que estão ativos

  for(int i=0; i<N_SIMPLE_STATES; i++){
    if(!redSimpleStates[i]->finished) // se não foi finalizada ainda
      redSimpleStates[i]->Update();
    if(!greenSimpleStates[i]->finished)
      greenSimpleStates[i]->Update();
    if(!yellowSimpleStates[i]->finished) 
      yellowSimpleStates[i]->Update();
    if(!blueSimpleStates[i]->finished) 
      blueSimpleStates[i]->Update();
    if(!orangeSimpleStates[i]->finished)
      orangeSimpleStates[i]->Update();
    

    if(i < N_TRACE_STATES){
      if(!redTraceStates[i]->finished)
        redTraceStates[i]->Update();
      if(!greenTraceStates[i]->finished)
        greenTraceStates[i]->Update();
      if(!yellowTraceStates[i]->finished)
        yellowTraceStates[i]->Update();
      if(!blueTraceStates[i]->finished)
        blueTraceStates[i]->Update();
      if(!orangeTraceStates[i]->finished)
        orangeTraceStates[i]->Update();
    }
  }
}

void getSimpleTime(){
  offtime_simple = 0;
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
  offtime_rastro = 0;
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
