# **Project Requirements: Custom Smart Power Cord**

## **1. Project Overview & Goal**
* **Objective:** Design a custom 1.5-meter USB-C to USB-C power cable that acts as an optional "smart toggle" accessory for the ESP32-C6 LED Lamp. 
* **Core Functionality:** The cable continuously provides 5V power to the lamp. It features an inline push-button switch that, when pressed, sends a hardware signal via the USB `D+` (Data Positive) line. The ESP32-C6 firmware will detect this signal and software-toggle the LEDs on or off, ensuring the lamp remains powered and connected to the smart home network at all times.
* **Compatibility:** Standard USB-C charging cables must still work perfectly with the lamp (providing power without the button feature). This custom cable must also be safe if accidentally plugged into a PC or standard phone charger.

## **2. Physical Specifications**
* **Connectors:** USB Type-C Male on both ends.
* **Total Length:** 1.5 meters (150 cm).
* **Wire Outer Diameter (OD):** 3.0 mm or maximum permitted by 4-5 conductor wires cleanly.
* **Switch Housing Placement:** Positioned approximately in the middle of the cable.
* **Switch Housing Maximum Dimensions:** 15.5 mm (W) x 45.5 mm (L) x 12.5 mm (H).

## **3. Wiring & Logic Design**
* **Internal Wires:** The cable requires 4 active internal wires passing through: `VBUS` (5V), `GND`, `D+`, and `D-`. (A `CC` wire may also be included depending on the OEM).
* **Pass-Through:** `VBUS`, `GND`, and `D-` wires pass straight through the switch housing directly from one end to the other without interruption.
* **Button Implementation (Simplest & Cheapest Method):**
  * Inside the switch housing, a simple tactile momentary push-button is bridging the `D+` wire and the `GND` wire.
  * **Safety Resistor:** A small ~330Ω to 470Ω resistor MUST be placed in series between the `GND` wire and the push-button. 
  * **How it works:** When the button is pressed, it pulls the `D+` line to Ground (LOW). When unpressed, the line floats (and will be pulled HIGH by the ESP32's internal resistor). 
  * **Why the resistor?** If a user mistakenly uses this custom cord to connect their cell phone to their laptop, pressing the button could short the active 3.3V USB data line to ground. The series resistor safely limits this current, protecting the PC's USB port from short-circuit damage while still pulling the voltage low enough for the ESP32 to detect it as a button press.

## **4. Main PCB Firmware Integration**
* **Pin Configuration:** The ESP32-C6 utilizes GPIO 13 for USB `D+`. By default, this is mapped to the hardware USB/JTAG peripheral for native flashing.
* **Runtime Behavior:** In the firmware, after the ESP32-C6 boots up and determines it is not currently connected to a PC for flashing, it can reconfigure GPIO 13 as a standard digital `INPUT_PULLUP`.
* **Signal Detection:** The firmware will listen for GPIO 13 to drop LOW. When it detects a LOW signal, it toggles the LED state.
* **Main PCB Compatibility Check:** The current main PCB requirements **already support this natively**. By specifying that `D+` and `D-` are routed directly to the ESP32-C6 for flashing, we enable this dual-purpose capability (flashing vs. button sensing) entirely in software. No hardware changes to the main PCB are required.

## **5. Manufacturing Approach**
Creating a custom injection-molded USB cable requires working with an OEM/ODM Cable Assembly Factory (e.g., sourcing from Shenzhen, China via Alibaba or direct B2B).
* **Tooling / Molds:** The factory will require you to pay a one-time "Tooling Fee" to create the injection molds for your custom switch plastic housing and the USB-C end strain-reliefs. This tooling fee typically ranges from **$500 to $1,500 USD**. 
* **Minimum Order Quantity (MOQ):** Custom runs generally require an MOQ to start production (typically 1,000 to 2,000 units). 
* **Unit Cost:** Once tooling is complete, simple custom cables like this usually cost between **$0.80 and $1.50 USD per cable**, depending on volume, wire gauge, and material (e.g., TPE vs PVC).
* **Design Handoff:** You will provide the factory with a 3D CAD model (STEP file) of your desired switch housing and a basic wiring schematic showing the push-button and resistor bridging `D+` to `GND`. They will handle the PCB design for the tiny board inside the switch, the wire soldering, resin overmolding, and final assembly.
