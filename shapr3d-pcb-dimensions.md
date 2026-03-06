# Smart Lamp PCB Dimensions & Clearances for Shapr3D

This document provides the exact physical dimensions, placement constraints, and cutout geometries of the custom 50mm ESP32-C6 Smart Lamp PCB. Use these measurements to design the restrictive 10mm-tall 3D printed housing in Shapr3D (or any CAD software).

## 1. Global Board Dimensions
The core fiberglass board that forms the foundation of the electronics.

* **Diameter (X/Y):** 50.0 mm
* **Total Assembly Max Height:** 6.5 mm (The absolute ceiling limit from the bottom of the lowest component to the top of the highest component, fitting inside a 10.0 mm housing).

---

## 2. Major Component Clearances (Top Layer)
These components dictate the "ceiling" of the 3D printed housing above the board.

### Addressable LEDs (8x SK6812 RGBW)
The LEDs form a perfect ring around the perimeter of the board.
* **Size (X/Y):** 5.0 mm x 5.0 mm
* **Height (Z):** 1.6 mm
* **Placement:** Centered perfectly on a 42.0 mm diameter circle (a 21.0 mm radius from the board center). Spaced at exactly 45-degree intervals.

### MCU Module Option A: ESP32-C6-MINI-1-N4 (Selected Base)
This is the severely compressed variant chosen to ensure maximum clearance inside the housing. It has a built-in PCB trace antenna (up to 2.33 dBi) for local mesh routing.
* **Width (X):** 13.2 mm
* **Length (Y):** 16.6 mm
* **Height (Z):** 2.4 mm
* **Placement:** Placed on the **Bottom Layer**. Because it is 2.4mm tall, it easily fits within the 3.0mm Z-depth floor established by the bulk capacitor.

### MCU Module Option B: ESP32-C6-WROOM-1 (Alternative Range-Extender)
This is the standard, longer module. It takes up more of the inner circle but features a much stronger high-gain antenna (3.26 dBi) for better wall penetration.
* **Width (X):** 18.0 mm
* **Length (Y):** 25.5 mm
* **Height (Z):** 3.2 mm 
* **Placement:** Placed on the **Bottom Layer**. (Note: At 3.2mm tall, this module would become the new lowest-hanging component on the board, surpassing the 3.0mm capacitor).

---

## 3. Major Component Clearances (Bottom Layer)
These components dictate the "floor" of the 3D printed housing below the board.

### USB-C Mid-Mount Receptacle (TE 2129691-2)
Because this is a "mid-mount" receptacle, its belly hangs below the board and its top sticks up above the board. 
* **Width (X):** 12.35 mm
* **Length (Y):** 9.0 mm
* **Total Height (Z):** 2.225 mm 
* **Protrusion limits:** It extends roughly 0.3mm above the top FR4 layer and 0.3mm below the bottom FR4 layer.

### Low-Profile Tantalum Polymer Capacitor
A large bulk capacitor used to stabilize the 5V LED rail.
* **Width/Length:** 7.3 mm x 4.3 mm (EIA 7343 footprint metric)
* **Max Height (Z):** 3.0 mm (This component is the tallest item on the bottom layer and dictates the absolute floor depth of the bottom housing cavity).

### Low-Profile SMD Tactile Buttons (x3)
* **Width/Length:** 3.0 mm x 4.0 mm
* **Max Height (Z constraint):** 1.5 mm 

> **Note on Minor Components:** All remaining logic chips (LDO regulator, level shifter) and passive components (resistors, tiny ceramic bypass capacitors) are extremely flat (under 1.5mm tall). As long as the Shapr3D housing provides enough empty Z-depth to clear the 3.0mm Tantalum Capacitor, all the tiny chips will easily clear.

---

## 4. The Multi-Stage "Stepped Keyhole" Cutout Geometry
This is the physical cutout on the edge of the PCB required to mount the USB-C receptacle while burying the thick plastic "strain-relief" head of the male cable.

Your Shapr3D housing design must accommodate a male USB cord entering through the narrow 5mm outer perimeter slot and terminating in the 14mm inner cavern.

### Stage 1 (Receptacle Mount)
Where the mid-mount receptacle is physically soldered to the board. 
* **Y-Axis Depth:** Extends from `Y = -14mm` to `Y = -19mm` (approaching the perimeter). 
* **X-Axis Width:** 12.35mm. (Provides a tight fit for the metal belly of the USB port to drop through, while leaving FR4 fiberglass on the left and right for soldering).

### Stage 2 (Strain Relief Void)
The large empty cavern inside the board's footprint.
* **Y-Axis Depth:** Extends from `Y = -19mm` to `Y = -27mm`. 
* **X-Axis Width:** 14.0mm. (Deep and wide enough to hide the entire rigid plastic cable head). 

### Stage 3 (Cord Exit Slot)
The narrow slot where the flexible copper wire leaves the board structure entirely.
* **Y-Axis Depth:** Extends from `Y = -27mm` out to the absolute perimeter edge of the 50mm board.
* **X-Axis Width:** 5.0mm. (This narrow pinch ensures the wire passes perfectly *between* two 5.0mm SK6812 LEDs without requiring any LEDs to be removed from the 8-LED circle).
