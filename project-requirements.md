# **Project Requirements: Custom ESP32-C6 LED Lamp PCB**

## **1. Project Overview & Deliverables**

* **Objective:** Design a custom 50 mm circular PCB designed to fit inside the Bambu Lab LED Lamp Kit-001 housing.  
* **Core Functionality:** An ESP32-C6-based smart lamp utilizing 16 addressable RGBW (Warm White) LEDs. It must be powered via USB-C and support data transfer over USB-C for initial firmware flashing and software features (USB-C data wires must be mapped to ESP32-C6 module).  
* **Design Software Requirement:** **KiCad** (Latest stable version). No proprietary or cloud-locked EDA tools (e.g., [Flux.ai](http://flux.ai/), Altium, Eagle) are permitted.  
* **Required Deliverables:**  
  * Native KiCad schematic (`.kicad_sch`) and PCB layout (`.kicad_pcb`) source files.  
  * Gerber files (RS-274X2 format) for fabrication.  
  * Bill of Materials (BOM) in CSV format, mapped to LCSC or standard generic components.  
  * Component Placement List (CPL) / Pick-and-Place file for automated assembly.  
  * 3D STEP file of the fully populated board for mechanical fit verification.

## **2. Printed Circuit Board (PCB) Specifications**

* **Dimensions:** 50 **mm** circular diameter.  
* **Mechanical Fit:** Must include two 3mm mounting holes for seating the PCB inside the 3D-printed housing.  
* **Layer Count:** 4 Layers (Supported by standard fabrication pools at JLCPCB, PCBWay, and Seeed Studio Fusion without extra premium).  
* **Assembly Routing:** Double-sided PCBA.  
  * **Top Layer:** Exclusively reserved for the 16x LED components to ensure unobstructed 360-degree light diffusion.  
  * **Inner Layers:** Utilize for dedicated Ground (GND) and Power (5V/3.3V) planes to simplify routing and improve thermal dissipation.
  * **Bottom Layer:** USB-C receptacle, MCU module, voltage regulator, level shifter, tactile button, and all passive components.  
* **Material:** FR-4 (TG130 or TG150).  
* **Thickness:** 1.6 mm.  
* **Copper Weight:** 1 oz.  
* **Surface Finish:** HASL Lead-Free or ENIG.  
* **Programming & Testing:** Must include 6x bare copper test pads on the bottom layer (**3V3, GND, EN, IO9/BOOT, TXD, RXD**) exposed for a factory pogo-pin programming jig.
* **Silkscreen Requirements:** Must print the FCC ID of the ESP32-C6 module on the bottom silkscreen (e.g., "Contains FCC ID: 2AC7Z-ESP32C6" - verify exact ID for the specific WROOM-1 variant chosen).

## **3. Hardware & Routing Guidelines**

* **Power Distribution & Safety:** 
  * Route the 5V VBUS net directly from the USB-C input to the LED array. Step down 5V to 3.3V via the LDO regulator exclusively for the ESP32-C6 module and logic circuitry.
  * Include a 2A or 3A PTC resettable inline fuse on the 5V VBUS intake to prevent fire hazards from short circuits.
  * Place a bulk capacitor (e.g., 470µF or 1000µF) directly on the 5V rail near the LEDs to prevent voltage drops during sudden current spikes.
* **Thermal Design:** 
  * Ensure the PCB layout includes a small copper polygon under the 3.3V LDO to act as a heatsink.
  * Include an NTC Thermistor connected to an ESP32 ADC pin to monitor board temperature.
  * **Firmware Note:** The firmware MUST enforce a soft-limit on the LED power to ensure total board power draw stays under 3 Watts (~600mA at 5V) to prevent melting PLA housings.
* **USB-C Implementation & Protection:** 
  * Mount the USB-C receptacle (mid-mount or bottom-mount) flush with the PCB edge to align perfectly with the external housing cutout. 
  * Route USB D+ and D- to the ESP32-C6 hardware USB/JTAG pins for native USB flashing. 
  * Include two 5.1kΩ pull-down resistors on CC1 and CC2.
  * Add a TVS diode array (e.g., SRV05-4) on the USB-C VBUS, D+, and D- lines for ESD protection.
* **Logic Level Shifting & LED Data:** 
  * Place a 3.3V-to-5V level shifter (e.g., 74AHCT125) on the data line between the ESP32-C6 GPIO output and the data-in pin of the first SK6812 LED.
  * Add a 330Ω to 470Ω series resistor between the level shifter output and the data input of LED1 to damp signal ringing.
* **Antenna Clearance:** Ensure there are no copper pours, traces, or components on any layer directly beneath or adjacent to the PCB antenna trace of the ESP32-C6-WROOM-1 module.  
* **User Interface & Boot Strapping:** 
  * Connect the single tactile button between a standard GPIO pin and Ground. 
  * **Critical:** Do not hardwire this button to strapping pins (like GPIO 8 or GPIO 9) in a way that holding the button during power-on would prevent the ESP32 from booting normally or accidentally force it into download mode.

## **4. Bill of Materials (BOM)**

| Reference Designator | Component Name / Part Number | Qty | Description |
| ----- | ----- | ----- | ----- |
| **U1** | **ESP32-C6-WROOM-1** | 1 | Wi-Fi 6, Bluetooth 5, Zigbee MCU module. |
| **LED1 - LED16** | **SK6812-5050-RGBW (Warm White)** | 16 | 5V Addressable RGB + Warm White LED. Top layer mount. |
| **J1** | **USB Type-C Receptacle** | 1 | 16-pin or 6-pin power+data SMD edge connector. |
| **U2** | **AP2112K-3.3TRG1** | 1 | 3.3V, 600mA Low Dropout (LDO) Voltage Regulator. |
| **U3** | **74AHCT125** | 1 | 3.3V to 5V Logic Level Shifter (Single gate variant e.g., SN74AHCT1G125). |
| **D1** | **SRV05-4** (or similar) | 1 | TVS Diode Array for ESD protection on USB data/power lines. |
| **F1** | **PTC Resettable Fuse (2A-3A)** | 1 | Inline fuse on 5V VBUS for short circuit protection. |
| **SW1** | **Tactile Push Button** | 1 | SMD push button for user control (Bottom Layer). |
| **TH1** | **NTC Thermistor** (e.g., 10kΩ) | 1 | Temperature monitoring sensor for LED thermal throttling. |
| **C1, C2** | **10µF Ceramic Capacitor** | 2 | Decoupling for 3.3V LDO input and output (0805 or 0603). |
| **CBLK1** | **470µF or 1000µF Capacitor** | 1 | Bulk capacitor for 5V LED rail (SMD Electrolytic or Tantalum/Polymer). |
| **C3, C4, C5** | **0.1µF Ceramic Capacitor** | 3 | Bypass capacitors for ESP32 and Level Shifter (0603). |
| **C6 - C21** | **0.1µF Ceramic Capacitor** | 16 | Bypass capacitors (one for each SK6812 LED). |
| **R1, R2** | **5.1kΩ Resistor** | 2 | USB-C CC1/CC2 pull-down resistors. |
| **R3** | **10kΩ Resistor** | 1 | Pull-up resistor for ESP32 EN pin / Thermistor voltage divider (may need matching resistor for thermistor). |
| **R4** | **330Ω - 470Ω Resistor** | 1 | Series resistor for LED data line protection. |

## **5. Packaging & Distribution**

* **Packaging Material:** The fully assembled PCB will be shipped in an **ESD Shielding Bag** (metallic silver bag) to prevent electrostatic discharge damage during transit.
* **Labeling:** Amazon FNSKU barcode stickers, as well as any other retail labeling, must be applied to the **outside** of the outer bag, not on the PCB itself.
