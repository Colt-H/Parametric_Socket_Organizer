include <roundedcube.scad>

//user variables
socket_diameter = 15; // measured diameter of the sockets
number_of_sockets = 11;
overall_height = 12; // overall height of the organizer
spacing_offset = 0; // use this for sockets that are wider than the base of the socket
drive_size = .250;

//constants
floor_depth = 2;
socket_nub = drive_size * 25.4;

//calculated variables
overall_width = socket_diameter + 6;
overall_length = socket_diameter + spacing_offset + 2;
socket_hole_radius = (socket_diameter + 1.5) / 2;
socket_hole_depth = overall_height - floor_depth;

//create overall holder
//TODO - radius should be calculated
difference() {
    roundedcube(size = [overall_length * number_of_sockets, overall_width, overall_height], center = false, radius = 3, apply_to = "z");
    for (i = [0:1:number_of_sockets - 1]) {
        // create holes
        translate(v = [((overall_length / 2) + (overall_length * i)), (overall_width / 2), floor_depth])  
            cylinder(h = socket_hole_depth + 1, r = socket_hole_radius);
    }
}

for (i = [0:1:number_of_sockets - 1]) {
    // add nubs
    translate(v = [((overall_length * i) + (overall_length / 2)), (overall_width / 2), (floor_depth + (socket_hole_depth / 2) - 2)])
        cube([socket_nub, socket_nub, socket_hole_depth], center = true);
    translate(v = [((overall_length * i) + (overall_length / 2)), (overall_width / 2), (floor_depth + (socket_hole_depth) - 2.001)])
        rotate([0, 0, 45])
        cylinder(h = 2, r1 = socket_nub - 2, r2 = socket_nub - 4, $fn = 4);
}