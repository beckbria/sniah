// This file is only intended for rendering, not for printing

include <constants.scad>
use <3_puzzle_pieces.scad>
use <tower.scad>
use <haystack.scad>

module tower_combined() {
    translate([0,0,40])
    union() {
        tower_upper();
        rotate([180,0,0]) tower_lower();
    }
}

module pieces() {
    studYOffset = -12;
    translate([TOP_STUD_X,TOP_STUD_Y + studYOffset,TOP_STUD_Z]) rotate([-90,45,0]) 
        puzzle_piece_top();
    translate([LEFT_STUD_X,LEFT_STUD_Y + studYOffset,LEFT_STUD_Z]) rotate([-90,45,0])
        puzzle_piece_left();
    translate([RIGHT_STUD_X,RIGHT_STUD_Y + studYOffset - 2,RIGHT_STUD_Z]) rotate([-90,-135,0]) 
        puzzle_piece_right();
}

module combined() {
    union() {
        color("#d3af37") holey_haystack();
        color("silver") translate([PILLAR_X,PILLAR_Y,PILLAR_Z]) tower_combined();
        color("#960019") pieces();
    }
}

combined();

