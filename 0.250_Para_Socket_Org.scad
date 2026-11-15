//user variables
socket_diameter = 14; // measured diameter of the sockets
number_of_sockets = 7;
overall_height = 12; // overall height of the organizer
spacing_offset = 2; // use this for sockets that are wider than the base of the socket

//constants
floor_depth = 2;
socket_nub = 6.35;

//calculated variables
overall_width = socket_diameter + 6;
overall_length = socket_diameter + spacing_offset + 3;
socket_hole_radius = (socket_diameter + 1.5) / 2;
socket_hole_depth = overall_height - floor_depth;

//for loop to create socket holders based on user input
for (i = [0:1:number_of_sockets - 1]) {
    // create holes
    translate(v = [overall_length * i - 0.001, 0, 0]) 
    difference() {
        cube([overall_length, overall_width, overall_height]);
        translate(v = [(overall_length / 2), (overall_width / 2), floor_depth])  
            cylinder(h = socket_hole_depth + 1, r = socket_hole_radius);
    }
    // add nubs
    translate(v = [((overall_length * i) + (overall_length / 2)), (overall_width / 2), (floor_depth + (socket_hole_depth / 2) - 2)])
        cube([socket_nub, socket_nub, socket_hole_depth], center = true);
    translate(v = [((overall_length * i) + (overall_length / 2)), (overall_width / 2), (floor_depth + (socket_hole_depth) - 2.001)])
        rotate([0, 0, 45])
        cylinder(h = 2, r1 = socket_nub - 2, r2 = socket_nub - 4, $fn = 4);
}
