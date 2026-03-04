# **Project Requirements: Custom ESP32-C6 LED Lamp PCB**

## **1\. Project Overview & Deliverables**

* **Objective:** Design a custom 50 mm circular PCB designed to fit inside the Bambu Lab LED Lamp Kit-001 housing.  
* **Core Functionality:** An ESP32-C6-based smart lamp utilizing 16 addressable RGBW (Warm White) LEDs. It must be powered via USB-C and support data transfer over USB-C for initial firmware flashing and software features (USB-C data wires must be mapped to ESP32-C6 module).  
* **Design Software Requirement:** **KiCad** (Latest stable version). No proprietary or cloud-locked EDA tools (e.g., [Flux.ai](http://flux.ai/), Altium, Eagle) are permitted.  
* **Required Deliverables:**  
  * Native KiCad schematic (`.kicad_sch`) and PCB layout (`.kicad_pcb`) source files.  
  * Gerber files (RS-274X2 format) for fabrication.  
  * Bill of Materials (BOM) in CSV format, mapped to LCSC or standard generic components.  
  * Component Placement List (CPL) / Pick-and-Place file for automated assembly.  
  * 3D STEP file of the fully populated board for mechanical fit verification.

## **2\. Printed Circuit Board (PCB) Specifications**

* **Dimensions:** 50 **mm** circular diameter.  
* **Mechanical Fit:** Must include three 3mm mounting holes.  
* **Layer Count:** 2 Layers.  
* **Assembly Routing:** Double-sided PCBA.  
  * **Top Layer:** Exclusively reserved for the 16x LED components to ensure unobstructed 360-degree light diffusion.  
  * **Bottom Layer:** USB-C receptacle, MCU module, voltage regulator, level shifter, tactile button, and all passive components.  
* **Material:** FR-4 (TG130 or TG150).  
* **Thickness:** 1.6 mm.  
* **Copper Weight:** 1 oz.  
* **Surface Finish:** HASL Lead-Free or ENIG.  
* **Programming & Testing:** Must include 6x bare copper test pads on the bottom layer (**3V3, GND, EN, IO9/BOOT, TXD, RXD**) exposed for a factory pogo-pin programming jig.

## **3\. Hardware & Routing Guidelines**

* **Power Distribution:** Route the 5V VBUS net directly from the USB-C input to the LED array. Step down 5V to 3.3V via the LDO regulator exclusively for the ESP32-C6 module and logic circuitry.  
* **USB-C Implementation:** Mount the USB-C receptacle (mid-mount or bottom-mount) flush with the PCB edge to align perfectly with the external housing cutout. Route USB D+ and D- to the ESP32-C6 hardware USB/JTAG pins for native USB flashing. Include two 5.1kΩ pull-down resistors on CC1 and CC2.  
* **Logic Level Shifting:** Place a 3.3V-to-5V level shifter (e.g., 74AHCT125) on the data line between the ESP32-C6 GPIO output and the data-in pin of the first SK6812 LED.  
* **Antenna Clearance:** Ensure there are no copper pours, traces, or components on any layer directly beneath or adjacent to the PCB antenna trace of the ESP32-C6-WROOM-1 module.  
* **User Interface:** Connect the single tactile button between a standard GPIO pin and Ground. Do not hardwire this to the EN or BOOT pins.

## **4\. Bill of Materials (BOM)**

| Reference Designator | Component Name / Part Number | Qty | Description |
| ----- | ----- | ----- | ----- |
| **U1** | **ESP32-C6-WROOM-1** | 1 | Wi-Fi 6, Bluetooth 5, Zigbee MCU module with integrated PCB antenna. |
| **LED1 \- LED16** | **SK6812-5050-RGBW (Warm White)** | 16 | 5V Addressable RGB \+ Warm White LED. Top layer mount. |
| **J1** | **USB Type-C Receptacle** | 1 | 16-pin or 6-pin power+data SMD edge connector (Mid-Mount/Bottom-Mount). |
| **U2** | **AP2112K-3.3TRG1** | 1 | 3.3V, 600mA Low Dropout (LDO) Voltage Regulator. |
| **U3** | **74AHCT125** | 1 | 3.3V to 5V Logic Level Shifter (Single gate variant e.g., SN74AHCT1G125). |
| **SW1** | **Tactile Push Button** | 1 | SMD push button for user control (Bottom Layer). |
| **C1, C2** | **10µF Ceramic Capacitor** | 2 | Decoupling for 3.3V LDO input and output (0805 or 0603). |
| **C3, C4, C5** | **0.1µF Ceramic Capacitor** | 3 | Bypass capacitors for ESP32 and Level Shifter (0603). |
| **C6 \- C21** | **0.1µF Ceramic Capacitor** | 16 | Bypass capacitors (one for each SK6812 LED). |
| **R1, R2** | **5.1kΩ Resistor** | 2 | USB-C CC1/CC2 pull-down resistors (requests 5V from USB PD chargers). |
| **R3** | **10kΩ Resistor** | 1 | Pull-up resistor for ESP32 EN pin. |

