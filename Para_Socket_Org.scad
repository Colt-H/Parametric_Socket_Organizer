// user variables
socket_diameter = 27; // measured diameter of the sockets
socket_clearance = 1.5; // added to diameter
number_of_sockets = 7;
overall_height = 10; // overall height of the organizer
spacing_offset = 0; // use this for sockets that are wider than the base of the socket
drive_size = .5;

// constants
floor_depth = 2;
socket_nub = drive_size * 25.4; // convert from standard to metric

// calculated variables
overall_width = socket_diameter + 6;
socket_node_len = socket_diameter + spacing_offset + 2;
socket_hole_radius = (socket_diameter + socket_clearance) / 2;
socket_hole_depth = overall_height - floor_depth;

// parameter verification
assert(socket_diameter > socket_nub, "Socket diameter is too small for drive size.");
assert(socket_node_len * number_of_sockets <= 225, "Organizer longer than standard build plate.");
assert((socket_node_len / 2) + (socket_node_len) > (socket_diameter + socket_clearance), "Socket spacing smaller than sockets, increase spacing offset.");
assert((socket_hole_radius * 2) >= socket_diameter, "Socket hole too small, increase socket clearance.");
assert(socket_hole_depth > 0, "Socket hole invalid, increase overall height.");
assert(drive_size < 1, "Socket drive size should be entered in SAE units.");

// roundedcube module by Daniel Upshaw

$fs = 0.15;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}

// create overall holder
difference() {
        roundedcube(size = [socket_node_len * number_of_sockets, overall_width, overall_height], center = false, radius = 3, apply_to = "z");
    for (i = [0:1:number_of_sockets - 1]) {
        // create holes
        translate(v = [((socket_node_len / 2) + (socket_node_len * i)), (overall_width / 2), floor_depth])  
            cylinder(h = socket_hole_depth + 1, r = socket_hole_radius);
    }
}

for (i = [0:1:number_of_sockets - 1]) {
    // add nubs
    translate(v = [((socket_node_len * i) + (socket_node_len / 2)), (overall_width / 2), (floor_depth + (socket_hole_depth / 2) - 2)])
        cube([socket_nub, socket_nub, socket_hole_depth], center = true);
    translate(v = [((socket_node_len * i) + (socket_node_len / 2)), (overall_width / 2), (floor_depth + (socket_hole_depth) - 2.001)])
        rotate([0, 0, 45])
        cylinder(h = 2, r1 = socket_nub - (socket_nub / 3), r2 = socket_nub / 3.5, $fn = 4);
}