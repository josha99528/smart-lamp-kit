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

// --- ESP32-C6-WROOM-1 Module (Bottom Layer) ---
esp_width = 18;
esp_length = 25.5;
esp_height = 3.2; // Module thickness + solder clearance
esp_offset_y = -5; // Move slightly down to clear antenna keep-out at top

// --- USB-C Receptacle (Bottom Layer, Edge Mount) ---
usb_width = 9;
usb_length = 7.5; // How far it protrudes into board
usb_height = 3.2;
usb_overhang = 1.5; // How much it sticks out past the 50mm edge

// --- SK6812 5050 LEDs (Top Layer) ---
led_count = 16;
led_size = 5.0; // 5050 package is 5x5mm
led_height = 1.6;
led_radius = 21; // Distance from center to LED center

// --- Component Assembly ---
union() {
    
    // 1. The Main FR4 PCB Body
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
    }
    
    // 2. ESP32-C6 Module (Placed on BOTTOM, colored metallic grey)
    // Note: Z is negative because it's on the bottom layer
    color("silver")
    translate([-esp_width/2, esp_offset_y - esp_length/2, -esp_height])
    cube([esp_width, esp_length, esp_height]);
    
    // 3. USB-C Port (Placed on BOTTOM edge, colored dark grey)
    // Positioned at the very bottom edge (South pole of the circle)
    color("dimgray")
    translate([-usb_width/2, -(pcb_diameter/2) - usb_overhang, -usb_height])
    cube([usb_width, usb_length + usb_overhang, usb_height]);
    
    // 4. The 16x SK6812 LEDs (Placed on TOP layer, arranged in a ring)
    color("white")
    for (i = [0 : led_count - 1]) {
        // Calculate angle for each LED (360 / 16 = 22.5 degrees)
        angle = i * (360 / led_count);
        
        // Calculate X and Y position based on radius and angle
        x_pos = led_radius * cos(angle);
        y_pos = led_radius * sin(angle);
        
        // Place the LED block on top of the PCB
        translate([x_pos, y_pos, pcb_thickness])
        // Rotate the square LED so it sits tangent to the ring
        rotate([0, 0, angle])
        // Shift by -led_size/2 so the center of the cube is on the radius line
        translate([-led_size/2, -led_size/2, 0])
        cube([led_size, led_size, led_height]);
    }
}
