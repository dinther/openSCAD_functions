//  fillet Demo part of openSCAD functions
//  https://github.com/dinther/openSCAD_functions

include <fillet.scad>

pts = [[0,0],[50,0],[60,50],[100,50], [100,80], [0,80]];

fillet_radius = 10;
point_index1 = 2;  //  outer fillet
point_index2 = 1;  //  inner fillet
pts1 = fillet(pts, point_index1, fillet_radius);
pts2 = fillet(pts1, point_index2, fillet_radius);


color("red") linear_extrude(1.1) polygon(pts2);