# IoT Based Car Parking System

## Authors

- Bee Khee Siang
- Aqeel Ahlam Rauf
- Thang Wan Ru

## Description

The system can be split into 3 main components, which are: 
 - web dashboard/android app (Flutter)
 - cloud database (Google Firestore)
 - physical prototype (Raspberry Pi & Arduino) 

3 Arduinos are used to control 4 parking slots each. Each parking slot has a HC-SR04 ultrasonic sensor and RGB LED light, which detects and displays changes in the status of the parking slot. The code for each Arduino is written in C and uploaded to it using a Raspberry Pi. Updates are sent to Firestore using a python script on the Raspberry Pi. These changes will then be reflected on the web dashboard/android app in real-time. Flutter and Firestore were chosen as they integrate well with each other, after all, they were both created by Google. 

## Prototype
![alt text](https://github.com/kheesiang/IoT_Car_Park/blob/main/Prototype_image.jpeg)

## Web Dashboard
![alt text](https://github.com/kheesiang/IoT_Car_Park/blob/main/Chrome_dashboard_image.png)
