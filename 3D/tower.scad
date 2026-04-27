$fn = 50;

midHeight = 6;
pillarRadius = 2.5;
clearanceHeight = 0.2;
clearanceRadius = 0.1;
// (Max Radius = 1.75" / 2 = 22.225mm)
rimRadius = 22.225;

// Connecting Hole for lower part peg
module connecting_hole(height = 10 + clearanceHeight) {
    translate([0, 0, -0.1])
        cylinder(r = pillarRadius + clearanceHeight, h = height);
}

module tower_upper() {
    difference() {
        union() {      
            // Saucer Rim
            translate([0, 0, 0])
                cylinder(r1 = rimRadius, r2 = 20, h = 3);
                
            // Observation Deck (Recessed)
            translate([0, 0, 3])
                cylinder(r = 15, h = 4);
                
            // Dome
            translate([0, 0, 7])
                cylinder(r1 = 15, r2 = 5, h = 4);
                
            // Inverted Cone below antenna
            translate([0, 0, 11])
                cylinder(r1 = 3, r2 = 6, h = 3);
                
            // Spire (Antenna)
            translate([0, 0, 14])
                cylinder(r1 = 2, r2 = 0.5, h = 25);
        }
        
        union() {
            translate([0, 0, -midHeight])
                connecting_hole();
            // Eliminate the lower dome 
            exclusion = 2 * rimRadius + clearanceHeight;
            translate([0, 0, -(midHeight / 2)])
                cube(size = [exclusion, exclusion, midHeight], center = true);
        }
    }
}

module tower_lower() {
    union() {
        difference() {
            // Lower Flare
            //cylinder(r1 = 7.5, r2 = rimRadius, h = midHeight);
            cylinder(r1 = rimRadius, r2 = 7.5, h = midHeight);

            connecting_hole(midHeight / 3);
        }
        
        tower_legs();
   }
}

module connecting_peg() {
    cylinder(
        r1 = pillarRadius + clearanceHeight,
        r2 = pillarRadius + clearanceHeight,
    h = 5);
}

module tower_legs() {
    union() {
        translate([0,0,3 * midHeight])
            union() {
                // 3 Legs
                for(a = [0, 120, 240]) {
                    rotate([0, 0, a])
                    hull() {
                        translate([
                            0,  // Increases distance between central pillar and bottom of leg
                            0,
                            10,  // Increases height of legs
                        ]) cylinder(r = 2, h = 1);
                        translate([
                            8,  // Affects spacing of legs as they connect to the upper
                            0,  // Skews legs (leave at 0)
                            -14 // Affects spacing of legs as they connect to the upper
                            ]) cylinder(r = 1.5, h = 1);
                    }
                }
            }
            
       // Central Pillar
        translate([0,0, midHeight / 3])
            cylinder(r=pillarRadius, h=38);
    }
}

// separate multiple pieces
offset = 2 * rimRadius + 10;

tower_upper();

translate([0, offset, 0])
    tower_lower();

    
translate([offset / 2 - 10, offset / 2, 0])
    connecting_peg();
