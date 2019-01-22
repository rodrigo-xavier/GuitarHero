unsigned char incomingByte = '\0';
//unsigned int incomingTime = 0;
int rowPin = 3; //L2

void setup() {
  pinMode(rowPin, OUTPUT);  
  Serial.begin(115200);
}

void loop() {
  
  // Esse if evita bugs
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
  }

  // Aperta L2 se '01100100'(=char(100)) for enviado ao arduino, 
  // soltando em seguida, com o menor tempo possível
  if(incomingByte == char(100)){
    // delay(600);
    digitalWrite(rowPin, HIGH);
    delay(50);

    // Solta o botão
    incomingByte = '\0';
    digitalWrite(rowPin, LOW);
  }

  // Apenas aperta o botão L2, sem soltar, se '01100101'(=char(101)) 
  // for enviado ao arduino.
  if(incomingByte == char(101)){
    // Aperta o botão
    digitalWrite(rowPin, HIGH);
  }

  // Apenas solta o botão L2 se '01100110'(=char(102))
  // for enviado ao arduino.
  if(incomingByte == char(102)){
    // Solta o botão
    incomingByte = '\0';
    digitalWrite(rowPin, LOW);
  }
  

  // Segura L1 em notas continuas
  //if(incomingByte == 'b'){
  //  delay(600);
  //  digitalWrite(rowPin, HIGH);
  //delay(incomingTime);
  //}
}
