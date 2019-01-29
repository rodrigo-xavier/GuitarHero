// Dorme por determinado tempo
  // Codificação para enviar o tempo
  // r + tempo desejado + s
  if(incomingByte == char(114)){ // r=char(114)
    String str = Serial.readStringUntil(char(115)); // s=char(115)
    tempo = str.toInt();
    delay(tempo);
    tempo = 0;
    incomingByte = '\0';
  }

   // Segura o botão por determinado tempo
  // Codificação para enviar o tempo
  // p + tempo desejado + q
  if(incomingByte == char(112)){ // p=char(112)
    String str = Serial.readStringUntil(char(113)); // q=char(113)
    tempo = str.toInt();
    segura(tempo);
    tempo = 0;
    incomingByte = '\0';
  }


void segura(int tempo){
  // Segura o botão por determinado tempo

  digitalWrite(L1, HIGH);
  delay(tempo);
  digitalWrite(L1, LOW);
}