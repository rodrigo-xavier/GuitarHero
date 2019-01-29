class NotaMusical
{
  // Class Member Variables
  // These are initialized at startup
  
  int L1pin; // the number of the LED pin
  
  long OnTime; // milliseconds of on-time
  long OffTime;

  // These maintain the current state

  int L1; // L1 used to set the LED
  bool terminou;

  unsigned long previousMillis; // will store last time LED was updated

  // Constructor - creates a Flasher
  // and initializes the member variables and state
  public:
    NotaMusical(long on, long off)
    {
      L1pin = 3;
      pinMode(L1pin, OUTPUT);
      OnTime = on;
      OffTime = off;
    
      L1 = LOW;
      previousMillis = 0;
      terminou = false;
    }
    void Update(bool rastro)
    {
      // check to see if it's time to change the state of the LED
      unsigned long currentMillis = millis();
  
      if(!terminou && rastro && (L1 == HIGH) && (currentMillis - previousMillis >= OnTime))
      {
        L1 = LOW; // Turn it off
        previousMillis = currentMillis; // Remember the time
        digitalWrite(L1pin, L1); // Update the actual LED

        // Adicionar à lista de estados livres
        terminou = true;
      }
      else if (!terminou && (L1 == LOW) && (currentMillis - previousMillis >= OffTime))
      {
        previousMillis = currentMillis;

        if(rastro){ // Só aperta
          L1 = HIGH;
          digitalWrite(L1, HIGH);
        }
        else{ // Aperta e solta
          digitalWrite(L1, HIGH);
          delay(50);
          // Solta o botão
          digitalWrite(L1, LOW);

          // Adicionar à lista de estados livres
          terminou = true;
        }
      }
    }

    int getTerminou(){
      return terminou;
    }
};


unsigned char incomingByte = '\0';
//unsigned int incomingTime = 0;
int L1 = 3;
int i = 0, tempo = 0, state;

#define NUM_ROWS 10
int freeRows[10] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};

int on_time = 0;
int off_time = 1100;

bool start = true;
NotaMusical *states[NUM_ROWS];

void setup() {
  pinMode(L1, OUTPUT);  
  Serial.begin(115200);

  for(int row=0; row<NUM_ROWS; row++){
    states[row] = new NotaMusical(on_time, off_time);
  }
}

void loop() {

  state = get_state();
  bool rastro = false;
  states[state]->Update(rastro);

  // Esse if evita bugs
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
  }

  if(incomingByte == char(100)){
    aperto_simples();
    incomingByte = '\0';
  }
  if(incomingByte == char(101)){
    aperta_sem_soltar();
    incomingByte = '\0';
  }
  if(incomingByte == char(102)){
    solta();
    incomingByte = '\0';
  }

}

void free_states(){
  for(int row=0; row<NUM_ROWS; row++){
    if(states[row]->getTerminou()){
      freeRows[row] = 1;
    }else{
      freeRows[row] = 0;
    }
  }
}

int get_state(){
  for(int row=0; row<NUM_ROWS; row++){
    if(freeRows[row])
      return row;
    
  }
}

void aperto_simples(){
  // Aperta L1 se '01100100'(=char(100)) for enviado ao arduino, 
  // soltando em seguida, com o menor tempo possível

  // delay(600);
  digitalWrite(L1, HIGH);
  delay(50);

  // Solta o botão
  digitalWrite(L1, LOW);
}

void aperta_sem_soltar(){
  // Apenas aperta o botão L1, sem soltar, se '01100101'(=char(101)) 
  // for enviado ao arduino.
  
  // Aperta o botão
  digitalWrite(L1, HIGH);
}

void solta(){
  // Apenas solta o botão L1 se '01100110'(=char(102))
  // for enviado ao arduino.
  
  // Solta o botão
  digitalWrite(L1, LOW);
  
}
