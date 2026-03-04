# **Smart Power Cord Prototype Guide**

This document outlines the simplest method for prototyping the "Smart Toggle" power cord logic using off-the-shelf components and a Seeed Studio XIAO ESP32-C6. This proves the concept without requiring custom printed circuit boards or factory tooling.

## **1. Hardware Required**
* 1x Seeed Studio XIAO ESP32-C6.
* 1x Standard USB-A to USB-C (or C-to-C) data cable (must support data, not just charging).
* 1x 4-pin Tactile Momentary Push Button.
* 1x ~330Ω to 470Ω Resistor (Optional, but highly recommended for safety).
* 1x Breadboard & Jumper wires.
* 1x Standard USB Wall Charger or Power Bank. **(CRITICAL: Do not plug this prototype cord into a laptop or PC while testing the button, as shorting data lines on a PC port can cause the port to crash or disable itself for safety).**

## **2. Modifying the USB Cable**
1. Take your USB data cable and carefully slice away 2 to 3 inches of the outer rubber jacket near the middle of the cable.
2. Peel back any foil or braided metal shielding.
3. You will expose four colored inner wires. Typically:
   * **Red:** VBUS (5V Power)
   * **Black:** GND (Ground)
   * **Green:** D+ (Data Positive)
   * **White:** D- (Data Negative)
4. **DO NOT cut any of the wires.** They must pass continuously from the charger to the XIAO board.
5. Carefully strip a small section of insulation (about 3mm) off the middle of the **Green (D+)** and **Black (GND)** wires to expose the bare copper.

## **3. Breadboard Wiring (The 4-Pin Switch)**
A standard 4-pin tactile switch has two pairs of legs that are permanently connected internally. To ensure the button only bridges the circuit when actively pressed, you must wire to **diagonally opposite** legs.

1. Place the 4-pin push button across the center ravine of your breadboard.
2. Connect a jumper wire from the exposed copper of the **Green** (`D+`) USB wire to **Top-Left** pin of the button.
3. Connect a jumper wire from the exposed copper of the **Black** (`GND`) USB wire to one end of the **330Ω Resistor**.
4. Connect the other end of the **330Ω Resistor** to the **Bottom-Right** pin of the button.

*When the button is pressed, it temporarily bridges the D+ signal to Ground through the resistor.*

## **4. Prototyping Code (Arduino IDE)**
The XIAO ESP32-C6's physical USB-C port routes `D+` and `D-` directly to its internal hardware pins. On the ESP32-C6, the `D+` pin is `GPIO 13`.

Upload the following code to the XIAO ESP32-C6. (Note: You must upload this code *before* you plug your modified cord with the shorted wires into it).

```cpp
/*
  Smart Toggle Cord Prototype Receiver
  Board: Seeed Studio XIAO ESP32C6
*/

const int buttonPin = 13; // GPIO 13 maps to USB D+ on ESP32-C6
int ledState = LOW;       // Track if the lamp is currently ON or OFF
int lastButtonState = HIGH;
unsigned long lastDebounceTime = 0; 
unsigned long debounceDelay = 50; 

void setup() {
  Serial.begin(115200);
  
  // Enable internal pull-up. Pin will read HIGH (3.3V) when cord button is unpressed.
  // When cord button is pressed, it shorts D+ to Ground, and pin will read LOW (0V).
  pinMode(buttonPin, INPUT_PULLUP);
  
  // Using the built-in LED to represent the main lamp LEDs
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, ledState);
}

void loop() {
  int reading = digitalRead(buttonPin);

  // Check if the button state changed
  if (reading != lastButtonState) {
    lastDebounceTime = millis();
  }

  // Only register the press if the state has been stable longer than the debounce delay
  if ((millis() - lastDebounceTime) > debounceDelay) {
    
    // We only care about the moment the button goes LOW (is actively being pressed down)
    if (reading == LOW && lastButtonState == HIGH) {
      
      // Toggle the LED memory state
      ledState = !ledState;
      digitalWrite(LED_BUILTIN, ledState);
      
      Serial.print("Cord Button Pressed! Lamp is now: ");
      Serial.println(ledState == HIGH ? "ON" : "OFF");
    }
  }

  lastButtonState = reading;
}
```

## **5. Testing Protocol**
1. Upload the code above to the XIAO via a normal, unmodified USB cord.
2. Remove the XIAO from your computer.
3. Plug the XIAO into a standard USB Wall Charger using your **Modified Prototype Cord**.
4. Press the tactile button on your breadboard. 
5. The built-in LED on the XIAO should instantly toggle on or off with every click, proving the "Smart Cord" hardware interrupt works without disrupting the 5V power supply.
