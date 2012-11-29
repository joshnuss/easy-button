#define LED_PIN 13
#define BUTTON_PIN 2

void setup() {
  pinMode(LED_PIN, OUTPUT);
  pinMode(BUTTON_PIN, INPUT);

  Serial.begin(115200);
}

void loop() {
  if (digitalRead(BUTTON_PIN) == LOW) {
    delay(100);
    
    if (digitalRead(BUTTON_PIN) == HIGH) {
      return;
    }
    digitalWrite(LED_PIN, HIGH);
    
    while (digitalRead(BUTTON_PIN) == LOW) {
      // loop
      delay(100);
    }
    Serial.println("PRESSED");
    
    digitalWrite(LED_PIN, LOW);
      
  } 
}
