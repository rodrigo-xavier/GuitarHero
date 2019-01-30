#define N_STATES 10

class SimpleState{
  int pin;
  int state;
  long offTime;
  bool finalizada;
  unsigned long previousMillis;

  public:
    SimpleState(){
      pin=3;
      pinMode(pin, OUTPUT);
      offTime = 1100;
      previousMillis = 0;
      finalizada = false;
    }

    void check(){
      unsigned long currentMillis = millis();
      int delta_time=currentMillis-previousMillis;
      if(!finalizada && (delta_time>= offTime){
        digitalWrite(pin, HIGH);
        delay(50);
        digitalWrite(pin, LOW);
        finalizada = true;
      }
    }

    bool getFinalizada(){
      return finalizada;
    }
}

unsigned char incomingByte = '\0';
SimpleState states[N_STATES];
int freeStates[N_STATES];

void setup() {
  Serial.begin(115200);

  for(int i=0; i<N_STATES; i++){
    freeStates[i] = 1;
  }
}

void loop(){

  if (Serial.available() > 0) {
    incomingByte = Serial.read();
    
    if(incomingByte == 'a'){
      int n=get_state_index();
      states[n] = new SimpleState();
    }
  }

  free_finished_states();
  checkAllOnStates();
}

int get_state_index(){
  for(int i=0; i<N_STATES; i++){
    if(freeStates[i])
      return i;
  }
}

void free_finished_states(){
  for(int i=0; i<N_STATES; i++){
    if(states[i].getFinalizada()){
      freeStates[i] = 1;
    }else{
      freeStates[i] = 0;
    }
  }
}

void checkAllOnStates(){
  for(int i=0; i<N_STATES; i++){
    if(!states[i].getFinalizada()){ // se nao foi finalizada ainda
      states[i].check();
    }
  }
}









class States{
  int freeStates[N_STATES];
  SimpleState states[N_STATES];

  public:
    States(){
      for(int i=0; i<N_STATES; i++){
        freeStates[i] = 1;
      }
    }
}
