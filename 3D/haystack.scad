$fn = 50;

pillarRadius = 2.5;
clearanceRadius = 0.05;
studRadius = 1.75;

module stud() {
    rotate([90,0,0])
        cylinder(h=12, r1=studRadius+clearanceRadius, r2=studRadius+clearanceRadius);
}

module holes() {
    union() {
        // Pillar at top for space needle to sit in
        connectorRadius = pillarRadius+clearanceRadius;
        translate([0,0,45])
            cylinder(h=15, r1=connectorRadius, r2=connectorRadius);
        
        // puzzle piece one/top (socket/knob/socket/knob)
        translate([11,-19,32]) stud();
        
        // puzzle piece two/left (edge/knob/socket/knob)
        translate([0,-22,18.5]) stud();
        
        // puzzle piece three/right (edge/edge/socket/knob)
        translate([18.5,-19.5,13.5]) stud();
        
    }
}

module haystack() {
    // The model is not exactly on the ground for some reason....
    translate([0,0,-2]) {
        // Scale Factor 2.1 -> ~60mm height, ~70mm base diameter
        scaleFactor = 2.1;
    
        scale([scaleFactor,scaleFactor,scaleFactor])
            import("./haystack_mephistoschan.stl", convexity=4);
    }
}

module holey_haystack() {
    difference() {
        haystack();
        holes();
    }
}

holey_haystack();