# PCB Designer Recommendations

Based on the highly specific requirements of the Smart Lamp PCB (6.5mm height constraint, mid-mount USB-C receptacle, ESP32-C6-MINI integration, and JLCPCB automated SMT assembly), the browser agent has scraped and filtered the following top-tier freelancers and design agencies.

## A. Upwork Freelancers (Top Rated KiCad & ESP32 Specialists)

These independent freelancers were selected based on their explicit experience with KiCad, ESP32 modules, and preparing flawless Gerber/BOM/CPL files for JLCPCB manufacturing.

1. **Lap V.** 
   * **Profile:** [View on Upwork](https://www.upwork.com/freelancers/kicadpcbleevawns)
   * **Typical Rate:** ~$25 - $40/hr
   * **Why they fit:** Expert mechatronics engineer from Vietnam with 7+ years of experience. His profile specifically mentions designing for **JLCPCB (Gerber, BOM, PnP)** and deep expertise in **KiCad and ESP32**. He is an ideal, budget-friendly candidate for meeting your tight mechanical constraints.

2. **Asim S.**
   * **Profile:** [View on Upwork](https://www.upwork.com/freelancers/~019debb59886b361e4)
   * **Typical Rate:** $60/hr
   * **Why they fit:** **Top Rated Plus** on Upwork with extensive experience in high-speed and IoT PCB design. He specifically lists **ESP32** and **JLCPCB/PCBWay** assembly as core competencies. If you want the most experienced, manufacturing-ready professional, he is a top choice.

3. **Faizan H.**
   * **Profile:** [View on Upwork](https://www.upwork.com/freelancers/faizanhasan)
   * **Typical Rate:** ~$35/hr
   * **Why they fit:** Recently completed projects involving **ESP32-S3 modules** and complex IoT devices natively in KiCad. He mentions deep familiarity with **JLCPCB parts sourcing** and PCBA component setup.

4. **Emmanuel K.**
   * **Profile:** [View on Upwork](https://www.upwork.com/freelancers/~01d938e395972fd7a2)
   * **Typical Rate:** ~$40/hr
   * **Why they fit:** A dedicated Hardware Design Engineer with a strong portfolio of **KiCad projects**. He specializes in converting complex schematics into optimized, low-profile layouts like the 6.5mm design you need.

5. **Vasil M.**
   * **Profile:** [View on Upwork](https://www.upwork.com/freelancers/~01ff105e16da2a57a9)
   * **Typical Rate:** ~$50/hr
   * **Why they fit:** Expert in **RF and antenna routing** (critical for the ESP32-C6 to maintain WiFi/Zigbee signal stability) and specifically markets his ability to design for **JLCPCB's automated assembly lines**.

---

## B. Hardware Design Partners (JLCPCB & PCBWay Networks)

These are established design agencies and official layout services that build heavily-optimized boards specifically for rapid Shenzhen manufacturing lines every single day. 

1. **JLCPCB Official Layout Service**
   * **Profile:** [design.jlcpcb.com](https://design.jlcpcb.com/)
   * **Typical Pricing:** Fixed pricing per project (typically $200 - $800 depending on complexity).
   * **Why they fit:** This is their **internal professional team**. Since they are designing for their own pick-and-place machines, they are the single most likely team to avoid "DNF" (Do Not Fit) or sourcing errors with the specific LCSC components we picked.

2. **Amarula Electronics** *(UK / Netherlands)*
   * **Profile:** [View on Partner Network](https://www.pcbway.com/service_providers.html)
   * **Specialty:** High-speed design and RF (Radio Frequency).
   * **Why they fit:** They specialize in complex embedded systems and have a deep understanding of **ESP32 RF layout requirements**, ensuring your Wi-Fi/Zigbee performance is solid despite the small, dense board size.

3. **ValiTech Team** *(Canada)*
   * **Profile:** [View on Partner Network](https://www.pcbway.com/service_providers.html)
   * **Specialty:** Full-cycle IoT development.
   * **Why they fit:** They are excellent at "design-for-manufacturability" (DFM). They can handle the **6.5mm height constraint** immediately because they inherently understand how to cross-reference dimensions against the available "Basic" and "Extended" parts catalog.

4. **Algarhard Team** *(Portugal)*
   * **Profile:** [View on Partner Network](https://www.pcbway.com/service_providers.html)
   * **Specialty:** Cost-optimized and reliable PCB design.
   * **Why they fit:** They focus on industrial-grade reliability. Given your concern about the **USB-C mechanical strain** pulling up on the keyhole cutout, an agency like Algarhard is highly experienced in ensuring the anchoring pads are structurally reinforced in the layout.

5. **3DPHOTONiX** *(France)*
   * **Profile:** [View on Partner Network](https://www.pcbway.com/service_providers.html)
   * **Specialty:** Miniaturization and IoT.
   * **Why they fit:** With over 100 hardware projects, they are specialists in **tight mechanical integration**. They are well-versed in KiCad and preparing dense design packages for high-volume Chinese manufacturers.

---

### **Next Steps Recommendation**
I recommend reaching out to **Lap V.** (for budget and speed) or **Asim S.** (for high-end expertise) on Upwork first. Send them the `pcb-freelancer-requirements.md` file via the Upwork messaging system. Because our requirements document is so detailed, they will be able to provide you with a highly accurate, exact fixed-price quote almost immediately.
