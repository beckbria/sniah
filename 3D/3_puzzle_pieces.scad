// Minimum number of facets on round objects
$fn = 50;

include <constants.scad>;
include <puzzle_piece.scad>;

module puzzle_piece_top(
    width = PUZZLE_PIECE_WIDTH,
    height = PUZZLE_PIECE_HEIGHT,
    thickness = PUZZLE_PIECE_THICKNESS,
    knob_radius = KNOB_RADIUS,
    // I can't explain the magic 4.4mm addition here since the stud length
    // *should* reference the front of the hole, which should be STUD_Y,
    // but I can confirm that in practice this makes everything fit at the same height
    stud_length = STUD_LENGTH + abs(TOP_STUD_Y - LEFT_STUD_Y) + TOP_STUD_EXTRA_LENGTH,
    stud_radius = STUD_RADIUS
) {
    puzzle_piece(
        sides = [KNOB, SOCKET, KNOB, SOCKET],
        width = width,
        height = height,
        thickness = thickness,
        knob_radius = knob_radius,
        stud_length = stud_length,
        stud_radius = stud_radius
    );
}

module puzzle_piece_left(
    width = PUZZLE_PIECE_WIDTH,
    height = PUZZLE_PIECE_HEIGHT,
    thickness = PUZZLE_PIECE_THICKNESS,
    knob_radius = KNOB_RADIUS,
    stud_length = STUD_LENGTH,
    stud_radius = STUD_RADIUS
) {
    puzzle_piece(
        sides = [EDGE, KNOB, SOCKET, KNOB],
        width = width,
        height = height,
        thickness = thickness,
        knob_radius = knob_radius,
        stud_length = stud_length,
        stud_radius = stud_radius
   );
}

module puzzle_piece_right(
    width = PUZZLE_PIECE_WIDTH,
    height = PUZZLE_PIECE_HEIGHT,
    thickness = PUZZLE_PIECE_THICKNESS,
    knob_radius = KNOB_RADIUS,
    stud_length = STUD_LENGTH + abs(RIGHT_STUD_Y - LEFT_STUD_Y),
    stud_radius = STUD_RADIUS
) {
    puzzle_piece(
        sides = [EDGE, KNOB, SOCKET, EDGE],
        width = width,
        height = height,
        thickness = thickness,
        knob_radius = knob_radius,
        stud_length = stud_length,
        stud_radius = stud_radius
   );
}

module three_puzzle_pieces(
    width = PUZZLE_PIECE_WIDTH,
    height = PUZZLE_PIECE_HEIGHT,
    thickness = PUZZLE_PIECE_THICKNESS,
    knob_radius = KNOB_RADIUS,
    stud_length = STUD_LENGTH,
    stud_radius = STUD_RADIUS) {

    // Moving two puzzle pieces away from each other
    shift = (width + 2 * knob_radius) * 1.4;
    
    puzzle_piece_top();
    translate([shift,0,0]) puzzle_piece_left();
    translate([-shift,0,0]) puzzle_piece_right();
}

three_puzzle_pieces();