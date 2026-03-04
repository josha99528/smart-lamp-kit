# **Project Requirements: Custom ESP32-C6 LED Lamp PCB**

## **1. Project Overview & Deliverables**

* **Objective:** Design a custom 50 mm circular PCB.  
* **Core Functionality:** An ESP32-C6-based smart light utilizing 16 addressable RGBW (warm white) LEDs. It must be powered via USB-C and support data transfer over USB-C for initial firmware flashing and software features (USB-C data wires must be mapped to ESP32-C6 module).  
* **Design Software Requirement:** **KiCad** (Latest stable version). No proprietary or cloud-locked EDA tools are permitted (e.g., [Flux.ai](http://flux.ai/), Altium, Eagle).  
* **Required Deliverables:**  
  * Native KiCad schematic (`.kicad_sch`) and PCB layout (`.kicad_pcb`) source files.  
  * Gerber files (RS-274X2 format) for fabrication.  
  * Bill of Materials (BOM) in CSV format, mapped to LCSC or standard generic components.  
  * Component Placement List (CPL) / Pick-and-Place file for automated assembly.  
  * 3D STEP file of the fully populated board for mechanical fit verification.

## **2. Printed Circuit Board (PCB) Specifications**

*The detailed PCB layout, routing guidelines, and Bill of Materials (BOM) have been extracted to a dedicated hand-off document for the hardware freelancer.*

**Please refer to the standalone document:** [`pcb-freelancer-requirements.md`](./pcb-freelancer-requirements.md)

## **5. Packaging & Distribution**

* **Packaging Material:** The fully assembled PCB will be shipped in an **ESD Shielding Bag** (metallic silver bag) to prevent electrostatic discharge damage during transit.
* **Labeling:** Amazon FNSKU barcode stickers, as well as any other retail labeling, must be applied to the **outside** of the outer bag, not on the PCB itself.
