// This file is only intended for rendering, not for printing

// Minimum number of facets on round objects
$fn = 50;

use <haystack.scad>
use <3_puzzle_pieces.scad>
use <tower.scad>
use <render_combined.scad>

color("#d3af37") holey_haystack();
color("silver") translate([70,0,0]) rotate([0,0,-90]) tower_components();
color("#960019") translate([70,-40,0]) three_puzzle_pieces();
 
translate([-80,0,0])
    combined();