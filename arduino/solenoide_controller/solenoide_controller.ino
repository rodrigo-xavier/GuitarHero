unsigned char incomingByte = '\0';
//unsigned int incomingTime = 0;
int L1 = 3;
int i = 0;

void setup() {
  pinMode(L1, OUTPUT);  
  Serial.begin(115200);
}

void loop() {
  
  // Esse if evita bugs
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
  }

  // Aperta L1 se '01100100'(=char(100)) for enviado ao arduino, 
  // soltando em seguida, com o menor tempo possível
  if(incomingByte == char(100)){
    // delay(600);
    digitalWrite(L1, HIGH);
    delay(50);

    // Solta o botão
    incomingByte = '\0';
    digitalWrite(L1, LOW);
  }

  // Apenas aperta o botão L1, sem soltar, se '01100101'(=char(101)) 
  // for enviado ao arduino.
  if(incomingByte == char(101)){
    // Aperta o botão
    digitalWrite(L1, HIGH);
  }

  // Apenas solta o botão L1 se '01100110'(=char(102))
  // for enviado ao arduino.
  if(incomingByte == char(102)){
    // Solta o botão
    incomingByte = '\0';
    digitalWrite(L1, LOW);
  }
  
  // Segura o botão por determinado tempo
  // Codificação para enviar o tempo
  // char(254) -> inicio de recebimento de parâmetros de tempo
  // char (255) -> fim de recebimento
  // Ex: enviar, na ordem: char(254), char(5), char(1), char(255)
  // o programa decodificará como 51.
  // Enviar sempre valores de 0 a 9 para serem concatenados
  if(incomingByte == char(254)){
    i = 1;
    int total = 0;
    do{
      if (Serial.available() > 0) { // Esse if evita bugs
        incomingByte = Serial.read();
      }
      int digito = (int)incomingByte;
      if(digito<10){
        total += digito * pow(10,i);
        i++;
      }
    }while(incomingByte != char(255));
    digitalWrite(L1, HIGH);
    delay(total);
    digitalWrite(L1, LOW);
  }

}