# Smart Lamp PCB 3D CAD Resources

To help you accurately model the restrictive 10mm housing in Shapr3D, I have gathered the official 3D CAD STEP files for the major components on your board. 

## 1. Downloaded STEP Files (Included in this repo)
A new `/3d_models` folder has been added to this repository. It contains the raw, open-source `.step` files for exactly-dimensioned generic components directly from the official KiCad 3D libraries:

* **`CP_EIA-7343-15_Kemet-W.step`**: The exact metric 7343 (Imperial Size D) low-profile Tantalum Capacitor footprint. You can use this to model the tallest component on the bottom layer.
* **`LED_SK6812_PLCC4_5.0x5.0mm_P3.2mm.step`**: The precise 5.0mm x 5.0mm surface-mount RGBW LED package. You can import this once and duplicate it 16 times in a circular array in Shapr3D.

## 2. Proprietary Vendor STEP Files
Because highly specialized ICs and proprietary connectors belong to their respective manufacturers, they legally restrict the direct redistribution of their raw `.step` files. 

*You must create a free engineering account on the following distributor portals to download the final two 3D models:*

### A. The Mid-Mount USB-C Receptacle (TE Connectivity `2129691-2`)
* **Download Portal:** [SnapEDA (SnapMagic) - TE 2129691-2](https://www.snapeda.com/parts/2129691-2/TE%20Connectivity/view-part/)
* **Instructions:** Click "Download 3D Model", sign in (or create a free account), and select the `.STEP` option. This will give you the precise metal lip geometry needed to refine your housing's stepped keyhole cutout.

### B. The Microcontroller Module (Espressif `ESP32-C6-WROOM-1`)
* **Download Portal:** [Ultra Librarian / DigiKey - ESP32-C6-WROOM-1-N8](https://www.ultralibrarian.com/part/ESP32-C6-WROOM-1-N8-Espressif-Systems)
* **Instructions:** Click "Download Now", select "3D CAD Model", choose the `STEP` format, and check out for free. This model dictates the absolute ceiling of your top-layer housing constraints. 

*(If you decide to switch to the smaller MINI module later against my recommendation, search the same portals for `ESP32-C6-MINI-1` instead).*
