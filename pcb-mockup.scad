// Smart Lamp 50mm PCB Physical Mockup
// Render with OpenSCAD (F6) and Export to STL

// --- PCB Dimensions ---
pcb_diameter = 50;
pcb_thickness = 1.6;

// --- Mounting Holes ---
// 3 holes: one dead center, and two on the sides spaced 28mm apart
outer_hole_diameter = 3.2; // M3 clearance for BT3 screws
center_hole_diameter = 4.8;
hole_distance_from_center = 14; // 28mm apart = 14mm radius

// --- Stepped Keyhole Cutout Dimensions ---
// The cutout has 3 stages: Receptacle mount, Strain Relief void, and Wire exit slot.

// Stage 1: Receptacle Cutout (Where the mid-mount drops in)
cutout_rec_width = 12.35; // TE 2129691-2 belly width
cutout_rec_depth = 5;
cutout_rec_y = -14; // Placed deep into the board

// Stage 2: Strain Relief Void (For the thick plastic cable head)
cutout_void_width = 14; 
cutout_void_depth = 8;
cutout_void_y = -21; // From y=-13 to y=-21

// Stage 3: Wire Exit Slot (Passes exactly through the LED ring)
cutout_slot_width = 5; 
cutout_slot_depth = 5; 
cutout_slot_y = -26; // Reach past the outer edge

// --- ESP32-C6-WROOM-1 Module (Bottom Layer) ---
// Module must be rotated horizontally to fit in the top hemisphere
esp_width = 25.5; // (Swapped length and width for horizontal orientation)
esp_length = 18;
esp_height = 3.2; // Module thickness + solder clearance
esp_offset_y = 10; // Moved into the positive Y hemisphere, safely above the center mounting hole

// --- Low-Profile Bulk Capacitor (Bottom Layer) ---
cap_width = 7.3;
cap_length = 4.3;
cap_height = 3.0; // Tantalum Polymer SMD max height constraint
cap_offset_y = -3;
cap_offset_x = 10; // Placed firmly on the bottom right quadrant

// --- Low-Profile Tactile Button (Bottom Layer) ---
btn_width = 3.0;
btn_length = 4.0;
btn_height = 1.5; // Strict low profile constraint
btn_offset_y = -3;
btn_offset_x = -10; // Placed firmly on the bottom left quadrant 

// --- USB-C Receptacle (Mid-Mount) ---
usb_width = 12.35;
usb_length = 9; 
usb_height = 2.225; // TE 2129691-2 height
// Mid-mount means it straddles the Z-axis center of the PCB
usb_z_offset = (pcb_thickness / 2) - (usb_height / 2); 

// --- SK6812 5050 LEDs (Top Layer) ---
led_count = 16;
led_size = 5.0; 
led_height = 1.6;
led_radius = 21; // Distance from center to LED center

// --- Component Assembly ---
union() {
    
    // 1. The Main FR4 PCB Body with Holes and Keyhole Cutout
    difference() {
        // PCB Base
        color("darkgreen")
        cylinder(h=pcb_thickness, d=pcb_diameter, $fn=100);
        
        // Center Mounting Hole
        translate([0, 0, -1])
        cylinder(h=pcb_thickness+2, d=center_hole_diameter, $fn=50);

        // Mounting Hole 2 (Left)
        translate([-hole_distance_from_center, 0, -1])
        cylinder(h=pcb_thickness+2, d=outer_hole_diameter, $fn=50);
        
        // Mounting Hole 3 (Right)
        translate([hole_distance_from_center, 0, -1])
        cylinder(h=pcb_thickness+2, d=outer_hole_diameter, $fn=50);
        
        // Stage 1: Receptacle Belly Cutout
        translate([-cutout_rec_width/2, cutout_rec_y, -1])
        cube([cutout_rec_width, cutout_rec_depth, pcb_thickness+2]);
        
        // Stage 2: Strain Relief Void
        translate([-cutout_void_width/2, cutout_void_y, -1])
        cube([cutout_void_width, cutout_void_depth, pcb_thickness+2]);
        
        // Stage 3: Wire Exit Slot
        translate([-cutout_slot_width/2, cutout_slot_y, -1])
        cube([cutout_slot_width, cutout_slot_depth, pcb_thickness+2]);
    }
    
    // 2a. ESP32-C6 Module (Placed on BOTTOM, Top Hemisphere)
    color("silver")
    difference() {
        translate([-esp_width/2, esp_offset_y - esp_length/2, -esp_height])
        cube([esp_width, esp_length, esp_height]);
        
        // Engrave "ESP32" into the bottom face of the module
        translate([0, esp_offset_y, -esp_height - 0.1])
        linear_extrude(1)
        mirror([1,0,0])
        text("ESP32", size=4, halign="center", valign="center");
    }
    
    // 2b. Low-Profile Bulk Capacitor (Bottom)
    color("orange")
    difference() {
        translate([cap_offset_x - cap_width/2, cap_offset_y - cap_length/2, -cap_height])
        cube([cap_width, cap_length, cap_height]);
        
        // Engrave "CAP" into the bottom face of the capacitor
        translate([cap_offset_x, cap_offset_y, -cap_height - 0.1])
        linear_extrude(1)
        mirror([1,0,0])
        text("CAP", size=2.5, halign="center", valign="center");
    }
    
    // 2c. Low-Profile Tactile Button (Bottom)
    color("black")
    difference() {
        translate([btn_offset_x - btn_width/2, btn_offset_y - btn_length/2, -btn_height])
        cube([btn_width, btn_length, btn_height]);
        
        // Engrave "BTN" into the bottom face of the button
        translate([btn_offset_x, btn_offset_y, -btn_height - 0.1])
        linear_extrude(1)
        mirror([1,0,0])
        text("BTN", size=1.5, halign="center", valign="center");
    }
    
    // 3. USB-C Port (TE 2129691-2 Mid-Mounted inside the cutout)
    // Using a brighter distinct color so it stands out against the PCB
    color("LightGray")
    difference() {
        // Positioned inside the Stage 1 receptacle cutout
        translate([-usb_width/2, cutout_rec_y - 0.5, usb_z_offset])
        cube([usb_width, usb_length, usb_height]);
        
        // Engrave "USB" into the top face of the receptacle
        translate([0, cutout_rec_y + (usb_length/2) - 0.5, usb_z_offset + usb_height + 0.1])
        linear_extrude(1)
        text("USB", size=2.5, halign="center", valign="center");
    }
    
    // 4. The 16x SK6812 LEDs (Placed in a continuous ring)
    // The keyhole slot is only 5mm wide, which fits perfectly between the LEDs!
    color("white")
    for (i = [0 : led_count - 1]) {
        // Calculate angle for each LED (360 / 16 = 22.5 degrees)
        // Offset by 11.25 degrees so the slot perfectly splits the gap between two LEDs at the bottom
        angle = (i * (360 / led_count)) + 11.25;
        
        x_pos = led_radius * cos(angle);
        y_pos = led_radius * sin(angle);
        
        // Place the LED block and engrave "LED" on top of it
        difference() {
            translate([x_pos, y_pos, pcb_thickness])
            rotate([0, 0, angle])
            translate([-led_size/2, -led_size/2, 0])
            cube([led_size, led_size, led_height]);
            
            // Engrave text on top of the LED
            translate([x_pos, y_pos, pcb_thickness + led_height - 0.4])
            rotate([0, 0, angle])
            linear_extrude(1)
            text("LED", size=1.5, halign="center", valign="center");
        }
    }
}
