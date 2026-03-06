# **Custom ESP32-C6 Smart Light PCB Requirements**

## **1. Project Overview & Deliverables**

* **Objective:** Design a custom 50 mm circular PCB.  
* **Core Functionality:** An ESP32-C6-based smart light utilizing 8 addressable RGBW (warm white) LEDs. It must be powered via USB-C and support data transfer over USB-C for initial firmware flashing and data-over-USB feature controlled by the ESP32 module. 
* **Design Software Requirement:** **KiCad** (Latest stable version). No proprietary or cloud-locked EDA tools are permitted.  
* **Required Deliverables:**  
  * Native KiCad schematic (`.kicad_sch`) and PCB layout (`.kicad_pcb`) source files.  
  * Gerber files (RS-274X2 format) for fabrication.  
  * Bill of Materials (BOM) in CSV format, strictly mapped to JLCPCB LCSC part numbers.  
  * Component Placement List (CPL) / Pick-and-Place file for automated assembly.  
  * 3D STEP file of the fully populated board for mechanical fit verification.
  * **Pinout Mapping Table:** A simple text or markdown file explicitly listing which ESP32-C6 GPIO pins were routed to the LEDs, Buttons, and USB Data lines, to ensure immediate readiness for software development.

## **2. Printed Circuit Board (PCB) Specifications**

* **Dimensions:** 50 **mm** circular diameter.  
* **Total Vertical Height (Critical):** The absolute maximum height of the fully assembled PCBA (including the 1.6mm PCB, top LEDs, and all bottom components) must **not exceed 6.5 mm**. This is strictly required so it physically drops into the 10mm restrictive enclosure.
* **Layer Count:** 4 Layers.  
* **Assembly Routing:** Double-sided PCBA.  
  * **Top Layer:** Reserved exclusively for the 8x LED components (arranged in a perimeter ring) and the top-side edge of the mid-mount USB-C receptacle.
  * **Inner Layers:** Utilize for dedicated Ground (GND) and Power (5V/3.3V) planes to simplify routing and improve thermal dissipation.
  * **Bottom Layer:** ESP32-C6 module, bottom-side edge of the mid-mount USB-C receptacle, voltage regulator, level shifter, tactile buttons, and all passive components.
* **Material:** FR-4 (TG130 or TG150).  
* **Thickness:** 1.6 mm.  
* **Copper Weight:** 1 oz.  
* **Surface Finish:** HASL Lead-Free or ENIG.  
* **Programming & Testing:** Must include 6x bare copper test pads on the bottom layer (**3V3, GND, EN, IO9/BOOT, TXD, RXD**) exposed for a factory pogo-pin programming jig. These pads must be spaced at least 2.54mm apart or arranged in a standard programming header footprint.
* **Silkscreen Requirements:** Must print the FCC ID of the ESP32-C6 module on the bottom silkscreen (e.g., "Contains FCC ID: 2AC7Z-ESP32C6M" - verify exact ID for the specific MINI-1 variant chosen).

## **3. Hardware & Routing Guidelines**

* **Component Placement & Clearances (Critical):**
  * **ESP32-C6 Placement:** The module must be placed on the **Bottom Layer**. The massive USB-C Keyhole Cutout consumes too much space within the Top Layer LED ring. The ESP32 must be placed carefully on the bottom layer to avoid the USB receptacle pins.
* **LED Placement (Critical):** The 8x SK6812 LEDs must be placed on the Top Layer, arranged in a perfect ring/circle along the outer perimeter of the board. They must be evenly spaced at exactly 45-degree intervals.
* **Power Distribution & Safety:** 
  * Route the 5V VBUS net directly from the USB-C input to the LED array. Step down 5V to 3.3V via the LDO regulator exclusively for the ESP32-C6 module and logic circuitry.
  * Include a 2A or 3A PTC resettable inline fuse on the 5V VBUS intake to prevent fire hazards from short circuits.
  * Place a bulk capacitor (e.g., 470µF or 1000µF) directly on the 5V rail near the LEDs to prevent voltage drops during sudden current spikes.
* **Thermal Design:** 
  * Ensure the PCB layout includes a small copper polygon under the 3.3V LDO to act as a heatsink.
  * Include an NTC Thermistor connected to an ESP32 ADC pin to monitor board temperature.
* **USB-C Implementation & Protection:** 
  * **Component Selection:** Use the **TE Connectivity 2129691-2** (or equivalent 24-position Hybrid Mid-Mount Receptacle) to achieve the absolute minimum vertical height of ~2.2mm.
  * **Mounting Style (Critical):** The receptacle must be an **Inward-Recessed Mid-Mount**.
  * **The Multi-Stage "Stepped Keyhole" Cutout Geometry:** The PCB edge must feature a complex stepped cutout. Do NOT use a single massive square void, or the receptacle will fall through.
    1. **Inner Void (Strain Relief Chamber):** Deepest into the board, a void wide enough (~14mm) and deep enough to completely bury the rigid plastic strain relief head of a male USB-C cable.
    2. **Receptacle Bridge (Mounting Support):** Immediately outward from the inner void, the fiberglass must "pinch" inwards, leaving enough solid PCB on the left and right sides to mechanically support and solder the mid-mount receptacle's SMD mounting wings and grounding tabs, while following the exact ~12.35mm internal hole mandated by the TE footprint. 
    3. **Outer Slot (Wire Exit):** At the extreme outer perimeter of the 50mm board, the cutout must narrow down to a **6.5mm slot**. 
  * **LED Ring Preservation (Critical):** Because the very outer perimeter slot is only 6.5mm wide, the flexible cord can exit the board without interrupting the ring of 8 LEDs. The user will drop the cable head into the inner void from the Z-axis, plug it into the receptacle bridge, and lay the wire through the narrow exit slot before placing the board in its enclosure.
  * Route USB D+ and D- to the ESP32-C6's dedicated hardware USB Serial/JTAG pins (**GPIO12 for USB_D-** and **GPIO13 for USB_D+**). This is mandatory to support both native firmware flashing and your custom data-over-USB smart cable functionality.
  * Include two 5.1kΩ pull-down resistors on CC1 and CC2.
  * Add a TVS diode array (e.g., SRV05-4) on the USB-C VBUS, D+, and D- lines for ESD protection.
* **Logic Level Shifting & LED Data:** 
  * Place a 3.3V-to-5V level shifter (e.g., 74AHCT125) on the data line between the ESP32-C6 GPIO output and the data-in pin of the first SK6812 LED.
  * Add a 330Ω to 470Ω series resistor between the level shifter output and the data input of LED1 to damp signal ringing.
* **Antenna Clearance:** Ensure there are no copper pours, traces, or components on any layer directly beneath or adjacent to the PCB antenna trace of the ESP32-C6-MINI-1-N4 module.  
* **User Interface & Development Features:** 
  * **User Button:** Connect one tactile button between a standard GPIO pin and Ground for user input (e.g., toggling the lamp). Do not hardwire this to strapping pins.
  * **Boot & Reset Buttons:** Include two tactile buttons specifically for development: one connected to the `EN` pin (Reset) and one connected to `GPIO9` (Boot). These are essential for manual firmware flashing. 
  * **Status LEDs:** Include two 0603 or 0402 SMD LEDs on the bottom layer:
    * **Power LED:** Connected to the 3.3V rail (with a suitable current-limiting resistor) to indicate system power.
    * **User LED:** Connected to a free GPIO pin (with a suitable resistor) for user-programmable status indication.

## **4. Bill of Materials (BOM)**

| Reference Designator | Component Name / Part Number | Qty | Description |
| ----- | ----- | ----- | ----- |
| **U1** | **ESP32-C6-MINI-1** | 1 | Ultra-compact Wi-Fi 6, Bluetooth 5, Zigbee MCU module. Bottom layer mount. |
| **LED1 - LED8** | **SK6812-5050-RGBW (Warm White)** | 8 | 5V Addressable RGB + Warm White LED. Top layer mount. |
| **J1** | **USB Type-C Receptacle** | 1 | 16-pin or 6-pin power+data SMD edge connector, bottom-mount style. |
| **U2** | **AP2112K-3.3TRG1** | 1 | 3.3V, 600mA Low Dropout (LDO) Voltage Regulator. |
| **U3** | **74AHCT125** | 1 | 3.3V to 5V Logic Level Shifter (Single gate variant e.g., SN74AHCT1G125). |
| **D1** | **SRV05-4** (or similar) | 1 | TVS Diode Array for ESD protection on USB data/power lines. |
| **F1** | **PTC Resettable Fuse (2A-3A)** | 1 | Inline fuse on 5V VBUS for short circuit protection. |
| **SW1** | **Tactile Push Button** | 1 | SMD push button for user control (Bottom Layer). **Must be Low-Profile (max 1.5mm height).** |
| **SW2, SW3** | **Tactile Push Button** | 2 | Boot and Reset buttons for development. Must also be low profile. |
| **DL1** | **Red/Green SMD LED (0603)** | 1 | System Power indicator LED. |
| **DL2** | **Blue SMD LED (0603)** | 1 | User programmable status LED. |
| **R5, R6** | **Current Limiting Resistors** | 2 | Resistors for DL1 and DL2. |
| **TH1** | **NTC Thermistor** (e.g., 10kΩ) | 1 | Temperature monitoring sensor. |
| **C1, C2** | **10µF Ceramic Capacitor** | 2 | Decoupling for 3.3V LDO input and output (0805 or 0603). |
| **CBLK1** | **470µF or 1000µF Capacitor** | 1 | Bulk capacitor for 5V LED rail. **Must be a Low-Profile Tantalum Polymer SMD (max 3.0mm height).** (Reason: Standard tall electrolytic cylinder capacitors are tall and will completely violate the strict 6.5mm PCBA Z-limit). |
| **C3, C4, C5** | **0.1µF Ceramic Capacitor** | 3 | Bypass capacitors for ESP32 and Level Shifter (0603). |
| **C6 - C13** | **0.1µF Ceramic Capacitor** | 8 | Bypass capacitors (one for each SK6812 LED). |
| **R1, R2** | **5.1kΩ Resistor** | 2 | USB-C CC1/CC2 pull-down resistors. |
| **R3** | **10kΩ Resistor** | 1 | Pull-up resistor for ESP32 EN pin / Thermistor voltage divider (may need matching resistor for thermistor). |
| **R4** | **330Ω - 470Ω Resistor** | 1 | Series resistor for LED data line protection. |

## **5. JLCPCB SMT Assembly Guidelines & LCSC Parts**

To optimize for manufacturing costs and turnaround time at JLCPCB, the following parts routing is recommended. "Basic" parts are pre-loaded on the JLCPCB Pick-and-Place machines and incur zero feeder loading fees. "Extended" parts require manual reel loading by JLCPCB technicians and incur an ~$3.00 USD setup fee per unique component.

| BOM Ref | Primary LCSC Recommendation | JLCPCB Status | Secondary Alternative | JLCPCB Status |
| :--- | :--- | :--- | :--- | :--- |
| **U1 (ESP32-C6)** | **ESP32-C6-MINI-1-N4** (Espressif)<br>*C5295989* | **Extended** | **ESP32-C6-WROOM-1-N8** (Espressif)<br>*C5295988* | **Extended** |
| **LED1-8 (SK6812)** | **SK6812-5050-RGBW** (Opsco)<br>*C2890022* | **Extended** | **WS2812B-B/W** (Worldsemi)<br>*(Note: RGB only, no White)* | **Basic** |
| **J1 (USB-C)** | **2129691-2** (TE Connectivity)<br>*C3197911* | **Extended** | **USB4520-03-0-A** (GCT)<br>*C2988369* | **Extended** |
| **U2 (3.3V LDO)** | **AP2112K-3.3TRG1** (Diodes Inc)<br>*C51118* | **Extended** | **XC6206P332MR** (Torex)<br>*(Cheaper, highly common variant)* | **Basic** |
| **U3 (Level Shifter)** | **SN74AHCT1G125** (Texas Instruments)<br>*C131102* | **Extended** | **74HC125D** (Nexperia)<br>*(Standard 3.3V-compatible logic)* | **Basic** |
| **D1 (TVS ESD)** | **SRV05-4** (Tech Public / Sembo)<br>*C558418* | **Extended** | **ESDA5V3L** (STMicroelectronics) | **Basic** |
| **F1 (PTC Fuse)** | **1812 2A PTC** (Littelfuse or generic)<br>*C5074* | **Basic** | **1210 2A PTC** (Generic) | **Basic** |
| **SW1-3 (Buttons)** | **3x4x1.5mm SMD Low-Profile**<br>*C318884* | **Extended** | **3x6x2.5mm SMD Standard**<br>*(Violates 1.5mm height constraint)* | **Basic** |
| **DL1-2 (Dev LEDs)** | **0603 Red/Green/Blue LED** | **Basic** | **0805 Red/Green/Blue LED** | **Basic** |
| **TH1 (Thermistor)**| **0603 10kΩ NTC** (Murata) | **Basic** | **0402 10kΩ NTC** | **Basic** |
| **CBLK1 (Bulk Cap)**| **7343 470µF 6.3V Tantalum** (AVX)<br>*C7171* | **Extended** | **7343 330µF 6.3V Tantalum** | **Extended** |
| **Decoupling Caps** | **10µF, 0.1µF Ceramic (0603)** | **Basic** | **10µF, 0.1µF Ceramic (0402)** | **Basic** |
| **Resistors** | **5.1kΩ, 10kΩ, 330Ω (0603)** | **Basic** | **5.1kΩ, 10kΩ, 330Ω (0402)** | **Basic** |
