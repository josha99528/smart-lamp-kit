# **Custom ESP32-C6 Smart Light PCB Requirements**

## **1. Project Overview & Deliverables**

* **Objective:** Design a custom 50 mm circular PCB.  
* **Core Functionality:** An ESP32-C6-based smart light utilizing 16 addressable RGBW (warm white) LEDs. It must be powered via USB-C and support data transfer over USB-C for initial firmware flashing (USB-C data wires must be mapped to ESP32-C6 module).  
* **Design Software Requirement:** **KiCad** (Latest stable version). No proprietary or cloud-locked EDA tools are permitted.  
* **Required Deliverables:**  
  * Native KiCad schematic (`.kicad_sch`) and PCB layout (`.kicad_pcb`) source files.  
  * Gerber files (RS-274X2 format) for fabrication.  
  * Bill of Materials (BOM) in CSV format, strictly mapped to JLCPCB LCSC part numbers.  
  * Component Placement List (CPL) / Pick-and-Place file for automated assembly.  
  * 3D STEP file of the fully populated board for mechanical fit verification.

## **2. Printed Circuit Board (PCB) Specifications**

* **Dimensions:** 50 **mm** circular diameter.  
* **Mechanical Fit:** Must include three mounting holes for exact alignment with standard housing pins/screws:
  * One dead-center hole (~4.8mm diameter).
  * Two outer holes (3.2mm diameter for standard M3 / BT3 clearance), placed exactly **28mm apart** across the center (i.e., each hole is 14mm from the center point on the X-axis).
* **Layer Count:** 4 Layers.  
* **Assembly Routing:** Double-sided PCBA.  
  * **Top Layer:** Exclusively reserved for the 16x LED components to ensure unobstructed 360-degree light diffusion.  
  * **Inner Layers:** Utilize for dedicated Ground (GND) and Power (5V/3.3V) planes to simplify routing and improve thermal dissipation.
  * **Bottom Layer:** USB-C receptacle (bottom-mount preferred), MCU module, voltage regulator, level shifter, tactile button, and all passive components.  
* **Material:** FR-4 (TG130 or TG150).  
* **Thickness:** 1.6 mm.  
* **Copper Weight:** 1 oz.  
* **Surface Finish:** HASL Lead-Free or ENIG.  
* **Programming & Testing:** Must include 6x bare copper test pads on the bottom layer (**3V3, GND, EN, IO9/BOOT, TXD, RXD**) exposed for a factory pogo-pin programming jig. These pads must be spaced at least 2.54mm apart or arranged in a standard programming header footprint.
* **Silkscreen Requirements:** Must print the FCC ID of the ESP32-C6 module on the bottom silkscreen (e.g., "Contains FCC ID: 2AC7Z-ESP32C6" - verify exact ID for the specific WROOM-1 variant chosen).

## **3. Hardware & Routing Guidelines**

* **LED Placement (Critical):** The 16x SK6812 LEDs must be placed on the Top Layer, arranged in a perfect ring/circle along the outer perimeter of the board. They must be evenly spaced at exactly 22.5-degree intervals.
* **Power Distribution & Safety:** 
  * Route the 5V VBUS net directly from the USB-C input to the LED array. Step down 5V to 3.3V via the LDO regulator exclusively for the ESP32-C6 module and logic circuitry.
  * Include a 2A or 3A PTC resettable inline fuse on the 5V VBUS intake to prevent fire hazards from short circuits.
  * Place a bulk capacitor (e.g., 470µF or 1000µF) directly on the 5V rail near the LEDs to prevent voltage drops during sudden current spikes.
* **Thermal Design:** 
  * Ensure the PCB layout includes a small copper polygon under the 3.3V LDO to act as a heatsink.
  * Include an NTC Thermistor connected to an ESP32 ADC pin to monitor board temperature.
* **USB-C Implementation & Protection:** 
  * **Mounting Style (Critical):** Use an **Inward-Recessed Mid-Mount (Cutout)** USB-C receptacle.
  * **The "Keyhole" Cutout Geometry:** The PCB edge must feature a 'T-shaped' or 'Keyhole' edge-cut. The inner part of the cutout must be wide enough (~14mm) and deep enough to completely house the rigid plastic strain relief head of a male USB-C cable. The outer edge of the cutout (where it meets the 50mm perimeter) must narrow down to a **~4.5mm to 5mm slot**. 
  * **LED Ring Preservation (Critical):** Because the perimeter slot is only 5mm wide, the flexible cord can exit the board, but the 16 LEDs can still be placed in a continuous, evenly-spaced ring without the cutout destroying any LED positions. The user will drop the cable head into the cutout from the Z-axis before placing the board in its enclosure.
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
| **J1** | **USB Type-C Receptacle** | 1 | 16-pin or 6-pin power+data SMD edge connector, bottom-mount style. |
| **U2** | **AP2112K-3.3TRG1** | 1 | 3.3V, 600mA Low Dropout (LDO) Voltage Regulator. |
| **U3** | **74AHCT125** | 1 | 3.3V to 5V Logic Level Shifter (Single gate variant e.g., SN74AHCT1G125). |
| **D1** | **SRV05-4** (or similar) | 1 | TVS Diode Array for ESD protection on USB data/power lines. |
| **F1** | **PTC Resettable Fuse (2A-3A)** | 1 | Inline fuse on 5V VBUS for short circuit protection. |
| **SW1** | **Tactile Push Button** | 1 | SMD push button for user control (Bottom Layer). |
| **TH1** | **NTC Thermistor** (e.g., 10kΩ) | 1 | Temperature monitoring sensor. |
| **C1, C2** | **10µF Ceramic Capacitor** | 2 | Decoupling for 3.3V LDO input and output (0805 or 0603). |
| **CBLK1** | **470µF or 1000µF Capacitor** | 1 | Bulk capacitor for 5V LED rail (SMD Electrolytic or Tantalum/Polymer). |
| **C3, C4, C5** | **0.1µF Ceramic Capacitor** | 3 | Bypass capacitors for ESP32 and Level Shifter (0603). |
| **C6 - C21** | **0.1µF Ceramic Capacitor** | 16 | Bypass capacitors (one for each SK6812 LED). |
| **R1, R2** | **5.1kΩ Resistor** | 2 | USB-C CC1/CC2 pull-down resistors. |
| **R3** | **10kΩ Resistor** | 1 | Pull-up resistor for ESP32 EN pin / Thermistor voltage divider (may need matching resistor for thermistor). |
| **R4** | **330Ω - 470Ω Resistor** | 1 | Series resistor for LED data line protection. |
