// Library for creating 3D models of puzzle pieces.  Side type and size are parametric.

// Types of Side
EDGE = 1;
KNOB = 2;
SOCKET = 3;

module puzzle_piece_knob(knob_radius, thickness) {
    neck_length = knob_radius * 1.3;
    neck_radius = knob_radius * 0.289; // Radius of the connector "cutout" 
    neck_width_solid = knob_radius * 0.8;
    neck_width = neck_width_solid + 2 * neck_radius;
    overlap = 0.1;
    // bury_depth ensures the neck corners are hidden inside the head
    bury_depth = knob_radius * 0.5;

    // Center the entire knob on the Z-axis
    translate([0, 0, -thickness/2]) 
    union() {
        // The Head (Circular Knob)
        translate([neck_length, 0, 0])
            cylinder(r = knob_radius, h = thickness);

        // The Neck
        difference() {
            linear_extrude(height = thickness) {
                polygon(points = [
                    [-overlap, -neck_width/2],
                    [-overlap,  neck_width/2],
                    [neck_length + bury_depth,  neck_width_solid/2],
                    [neck_length + bury_depth, -neck_width_solid/2]
                ]);
            }

            // Cutouts (Adjusted Z to -0.5 and height +1 for clean difference)
            translate([neck_radius - overlap, neck_width / 2, -0.5])
                cylinder(r = neck_radius, h = thickness + 1);
            
            translate([neck_radius - overlap, -neck_width / 2, -0.5])
                cylinder(r = neck_radius, h = thickness + 1);
        }
    }
}

// Positions and rotates each side
module puzzle_piece_side_geometry(side_index, w, h) {
    // side_index: 0=Top, 1=Right, 2=Bottom, 3=Left
    angle = 90 - (side_index * 90);
    
    // Offset calculation based on index
    x_off = (side_index == 1) ? w/2 : (side_index == 3) ? -w/2 : 0;
    y_off = (side_index == 0) ? h/2 : (side_index == 2) ? -h/2 : 0;

    translate([x_off, y_off, 0]) rotate([0, 0, angle]) children();
}

module puzzle_piece(
    sides, // List of length 4 in clockwise order i.e. [EDGE, KNOB, KNOB, SOCKET]
    width = 12, 
    height = 12, 
    thickness = 2, 
    knob_radius = 1.6, 
    stud_length = 8, 
    stud_radius = 1.75
) {
    difference() {
        union() {
            // Main body
            cube([width, height, thickness], center = true);
            
            // Stud
            if (stud_length > 0) {
                translate([0, 0, thickness/2])
                    cylinder(r = stud_radius, h = stud_length);
            }
            
            // Add Knobs
            for (i = [0 : 3]) {
                if (sides[i] == KNOB) {
                    puzzle_piece_side_geometry(i, width, height) 
                        puzzle_piece_knob(knob_radius, thickness);
                }
            }
        }
        
        // Subtract Sockets
        for (i = [0 : 3]) {
            if (sides[i] == SOCKET) {
                // To turn a knob into a socket, we rotate it 180 degrees 
                // so it points inward instead of outward. Increase the thickness
                // for a clean difference.
                puzzle_piece_side_geometry(i, width, height) 
                    rotate([0, 0, 180]) 
                        puzzle_piece_knob(knob_radius, thickness + 1);
            }
        }
    }
}


