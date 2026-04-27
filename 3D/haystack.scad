$fn = 50;

// KNOWN ISSUE:
// This previews fine in OpenSCAD but fails to render (even with absurdly high convexity) with 
// `ERROR: The given mesh is not closed! Unable to convert to CGAL_Nef_Polyhedron.`
// This file is still included as the source of truth for hole dimensions/positions, but the STL file
// currently included is generated with TinkerCAD.

include <constants.scad>;

module studHole() {
    r = STUD_RADIUS+CLEARANCE_RADIUS;
    // Rotate the stud to be oriented along the X axis. Add length padding to ensure full depth insertion
    rotate([90,0,0])
        cylinder(h=STUD_LENGTH * 1.5, r1=r, r2=r);
}

module holes() {
    union() {
        // Pillar at top for space needle to sit in
        connectorRadius = PILLAR_RADIUS+CLEARANCE_RADIUS;
        translate([0,0,45])
            cylinder(h=15, r1=connectorRadius, r2=connectorRadius);
        
        // puzzle piece one/top (socket/knob/socket/knob)
        translate([11,-19,32]) studHole();
        
        // puzzle piece two/left (edge/knob/socket/knob)
        translate([0,-22,18.5]) studHole();
        
        // puzzle piece three/right (edge/edge/socket/knob)
        translate([18.5,-19.5,13.5]) studHole();
        
    }
}

module haystack() {
    // The model is not exactly on the ground for some reason....
    translate([0,0,-2]) {
        // Scale Factor 2.1 -> ~60mm height, ~70mm base diameter
        scaleFactor = 2.1;
    
        scale([scaleFactor,scaleFactor,scaleFactor])
            import("./haystack_mephistoschan.stl", convexity=10);
    }
}

module holey_haystack() {
    difference() {
        haystack();
        holes();
    }
}

holey_haystack();