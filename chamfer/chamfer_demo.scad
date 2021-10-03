//  chamfer Demo part of openSCAD functions
//  https://github.com/dinther/openSCAD_functions

include <chamfer.scad>

pts = [[0,0],[10,0],[10,10]];
linear_extrude(1) polygon(pts);

chamfer_size = 3;
point_index = 0;
new_pts = chamfer(pts, point_index, chamfer_size);

color("red") linear_extrude(1.1) polygon(new_pts);