#include <MultiShiftRegister.h>
#include <Servo.h> 

/*
  Test script for Arduino Controlling Slots L1_B1, L1_B2, L1_B3, L1_B4

  Four Ultrasonic Sensors controlling their respective LED and transmits
  the data using Serial Communication to the Raspberry Pi with a baudrate of 9600:
  
  Turns on and off a light emitting diode (LED) connected to a digital pin,
  whenever the Ultrasonic Sensor detects an object within a distance of 3cm.
  We will then go on to print a string to the serial monitor which will be 
  manipulated to update the database
  
  The circuit:
  - Arduino Ultrasoninc Sensor HC-SR04
  - Shift Regist 74HC595
  - RGB light emitting diode (LED)
  - Resistor: 220 Ohm
  - Servo Motor

  created 2020
  created by Bee Khee Siang

*/

// Shift Register: Initializing
int dataPin = 11;   // Data Pin connected to arduino digital pin 11
int latchPin  = 12; // Latch Pin connected to arduino digital pin 12
int clockPin = 13;  // Clock Pin connected to arduino digital pin 13

// Initialize a Servo Object for the connected servo 
Servo servo_exit;        

// Initialize the angle
int angle = 0;    

// Ultrasonic Sensor L1_B1
#define trigPin1 0  // Attach pin 0 Arduino to pin Trig of HC-SR04
#define echoPin1 1  // Attach pin 1 Arduino to pin Echo of HC-SR04

// Ultrasonic Sensor L1_B2
#define trigPin2 2  // Attach pin 2 Arduino to pin Trig of HC-SR04
#define echoPin2 3  // Attach pin 3 Arduino to pin Echo of HC-SR04

// Ultrasonic Sensor L1_B3
#define trigPin3 4  // Attach pin 4 Arduino to pin Trig of HC-SR04
#define echoPin3 5  // Attach pin 5 Arduino to pin Echo of HC-SR04

// Ultrasonic Sensor L1_B4
#define trigPin4 6  // Attach pin 6 Arduino to pin Trig of HC-SR04
#define echoPin4 7  // Attach pin 7 Arduino to pin Echo of HC-SR04

// Ultrasonic Sensor for EXIT GATE
#define trigPinG 8  // Attach pin 8 Arduino to pin Trig of HC-SR04
#define echoPinG 9  // Attach pin 9 Arduino to pin Echo of HC-SR04

/* 
 * Defining the number of registers we will be talking to: 
 * Two 8 bit registers can host 16 individually (Digital Inputs) 
 * addressable binary outputs.
 */
int numberOfRegisters = 2;
int testCounter = 0;

/*
 * Setup group of shift registers and name it `msr`.
 * All outputs are initialized to low/off.
 */
MultiShiftRegister msr (numberOfRegisters , latchPin, clockPin, dataPin); 

/*
Function that test if the ultrasonic sensors are working or not
:param distance: the distance returned by the ultrasonic sensor
:param slotNumber: the slot we are testing
:param expectedOutput: the expected output
*/
void testUltrasonic(int distance, String slotNumber, String expectedOutput) {
  String testNum = "Starting test for: " + slotNumber;
  Serial.println(testNum);
  String output;

  if(distance > 0 && distance <= 3){
    output = "True";
    //Serial.println(output);
  }
  else if(distance > 3) {
    output = "False";
    //Serial.println(output);
  }
  Serial.println((output == expectedOutput) ? "PASS\n": "FAIL\n");
}
  

void setup() {
  Serial.begin (9600);        // Begin Serial communication at a baudrate of 9600:
  pinMode(latchPin, OUTPUT);  // Sets the latchPin as an Output
  pinMode(clockPin, OUTPUT);  // Sets the clockPin as an Output
  pinMode(dataPin, OUTPUT);   // Sets the dataPin as an Output

 /*
  * We setup all the Ultrasonic Sensors:
  * Trigger Pin : Set as Output
  * Echo Pin : Set as Input
  */
  // Ultrasonic Sensor for Slot L1_B1
  pinMode(trigPin1, OUTPUT);  
  pinMode(echoPin1, INPUT);   
  // Ultrasonic Sensor for Slot L1_B2
  pinMode(trigPin2, OUTPUT);
  pinMode(echoPin2, INPUT);
  // Ultrasonic Sensor for Slot L1_B3
  pinMode(trigPin3, OUTPUT);
  pinMode(echoPin3, INPUT);
  // Ultrasonic Sensor for Slot L1_B4
  pinMode(trigPin4, OUTPUT);
  pinMode(echoPin4, INPUT);  
  // Ultrasonic Sensor for the Gate
  pinMode(trigPinG, OUTPUT);
  pinMode(echoPinG, INPUT);  

  servo_exit.attach(10);  // Attach pin 10 Arduino to signal pin of servo    
  servo_exit.write(0);    // Sets the initial servo position to 0 (Horizontal)
  
}

void loop() {
    
  /* 
   * Ultrasonic Sensor For Parking Slot L1_B1
   */
  long duration, distance;
  // Trigger the sensor by setting the trigPin high for 150ms:
  digitalWrite(trigPin1, HIGH);  
  delay(150);
  digitalWrite(trigPin1, LOW);

  duration = pulseIn(echoPin1, HIGH);
  distance = (duration/2) / 29.1;

  if(distance > 0 && distance <= 3){
    //Serial.println("L1_B1;True");
    msr.clear_shift(1);   // Green LED is off
    msr.clear_shift(2);   // Blue LED is off
    delay(50);            // Delay 50ms
    msr.set_shift(0);     // Red LED is on

  }
  else if(distance > 3) {
    //Serial.println("L1_B1;False");
    msr.clear_shift(0);   // Red LED is off
    msr.clear_shift(2);   // Blue LED is off
    delay(50);            // Delay 50ms
    msr.set_shift(1);     // Green LED is on
  }
  
  /* 
   * Ultrasonic Sensor Parking Slot L1_B2
   */
  long duration2, distance2;
  // Trigger the sensor by setting the trigPin high for 150ms:
  digitalWrite(trigPin2, HIGH); 
  delay(150);
  digitalWrite(trigPin2, LOW);

  duration2 = pulseIn(echoPin2, HIGH);
  distance2 = (duration2/2) / 29.1;

  if(distance2 > 0 && distance2 <= 3){
    //Serial.println("L1_B2;True");
    msr.clear_shift(4);   // Green LED is off
    msr.clear_shift(5);   // Blue LED is off
    delay(50);            // Delay 50ms
    msr.set_shift(3);     // Red LED is on
    
  }
  else if(distance2 > 3) {
    //Serial.println("L1_B2;False");
    msr.clear_shift(3);   // Red LED is off
    msr.clear_shift(5);   // Blue LED is off
    delay(50);            // Delay 50ms
    msr.set_shift(4);     // Green LED is on
  }

  /* 
   * Ultrasonic Sensor For Parking Slot L1_B3
   */
  long duration3, distance3;
  // Trigger the sensor by setting the trigPin high for 150ms:
  digitalWrite(trigPin3, HIGH);  
  delay(150);
  digitalWrite(trigPin3, LOW);

  duration3 = pulseIn(echoPin3, HIGH);
  distance3 = (duration3/2) / 29.1;

  if(distance3 > 0 && distance3 <= 3){
    //Serial.println("L1_B3;True");
    msr.clear_shift(7);   // Green LED is off
    msr.clear_shift(8);   // Blue LED is off
    delay(50);            // Delay 50ms
    msr.set_shift(6);     // Red LED is on
    
  }
  else if(distance3 > 3) {
    //Serial.println("L1_B3;False");
    msr.clear_shift(6);   // Red LED is off
    msr.clear_shift(8);   // Blue LED is off
    delay(50);            // Delay 50ms
    msr.set_shift(7);     // Green LED is on
  }

  /* 
   * Ultrasonic Sensor For Parking Slot L1_B4
   */
  long duration4, distance4;
  // Trigger the sensor by setting the trigPin high for 150ms:
  digitalWrite(trigPin4, HIGH);  // Added this line
  delay(150);
  digitalWrite(trigPin4, LOW);

  duration4 = pulseIn(echoPin4, HIGH);
  distance4 = (duration4/2) / 29.1;

  if(distance4 > 0 && distance4 <= 3){
    //Serial.println("L1_B4;True");
    msr.clear_shift(10);  // Green LED is off
    msr.clear_shift(11);  // Blue LED is off
    delay(50);            // Delay 50ms
    msr.set_shift(9);     // Red LED is on
    
  }
  else if(distance4 > 3) {
    //Serial.println("L1_B4;False");
    msr.clear_shift(9);   // Red LED is off
    msr.clear_shift(11);  // Blue LED is off
    delay(50);            // Delay 50ms
    msr.set_shift(10);    // Green LED is on
  }


  // Code to test if something is in front of the sensor
  if (testCounter == 0) {
    Serial.println("TEST 1: CAR IS PRESENT IN FRONT OF ALL SENSORS");
    Serial.println("EXPECTED OUTPUT: ALL SENSORS ARE RED. GATE IS OPEN.\n");
    testUltrasonic(distance, "L1_B1", "True");
    testUltrasonic(distance2, "L1_B2", "True");
    testUltrasonic(distance3, "L1_B3", "True");
    testUltrasonic(distance4, "L1_B4", "True");
  }
  // Code to test if nothing is in front of the sensor
  // counter == 5 to allow for time to empty the parking slots
  else if (testCounter == 5) {
    Serial.println("TEST 2: NO CAR PRESENT IN FRONT OF ALL SENSORS");
    Serial.println("EXPECTED OUTPUT: ALL SENSORS ARE GREEN. GATE IS CLOSED.\n");
    testUltrasonic(distance, "L1_B1", "False");
    testUltrasonic(distance2, "L1_B2", "False");
    testUltrasonic(distance3, "L1_B3", "False");
    testUltrasonic(distance4, "L1_B4", "False");
  }

  testCounter++;

}
