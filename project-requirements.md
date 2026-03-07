# **Project Requirements: Custom ESP32-C6 LED Lamp PCB**

## **1. Project Overview & Deliverables**

* **Objective:** Design a custom 50 mm circular PCB.  
* **Core Functionality:** An ESP32-C6-based smart light utilizing 11 addressable RGBW (warm white) LEDs. It must be powered via USB-C and support data transfer over USB-C for initial firmware flashing and software features (USB-C data wires must be mapped to ESP32-C6 module).  
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

## **6. Software Requirements & Firmware Delivery**

The ESP32-C6 firmware will handle LED control, Wi-Fi/Zigbee communication, and the USB serial data bridge. Once the boards enter mass production and are distributed to users, firmware updates will be delivered natively Over-the-Air (OTA).

* **OTA Partitioning:** The C++ firmware must be compiled with an OTA partition table (e.g., `Factory`, `OTA_0`, `OTA_1`) to allow the ESP32 to download updates in the background without interrupting current operations, ensuring failsafe installation.
* **Production OTA Delivery Methods:** The final software architecture will support one of the following delivery mechanisms:
  * **Option A (Local Network OTA):** Integrating directly with local smart home hubs (like Home Assistant or ESPHome) to push updates from the user's local network router directly to the lamp.
  * **Option B (Custom HTTP Web Server):** Writing an internal polling loop in the firmware that checks a custom web server (e.g., a simple hosted `.txt` file) once a day for a higher version number, and downloading the associated `.bin` file if found.
  * **Option C (Third-Party Managed Dashboard - Recommended):** Integrating a professional IoT fleet-management library (such as **Bytebeam**, **Memfault**, or **Toit**) into the firmware. This provides a secure web dashboard to monitor the health of all sold lamps globally and deploy highly-managed, push-button OTA updates to the entire fleet simultaneously.
