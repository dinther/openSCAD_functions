//  openSCAD functions
//  https://github.com/dinther/openSCAD_functions


//  function chamfer(pts, index, size)
//
//  Replaces the point indicated by index with a symetrical chamfer of given size.
//  pts         List of 2D points that needs a point chamfered.
//  index       Index to the point to which the chamfer should be applied.
//  size        width of the chamfer.
//  return      List with 2D points with chamfer applied.
function chamfer(pts, index, size) = let(
    ba = index==0? pts[len(pts)-1] : pts[index-1] - pts[index],
    bc = index == len(pts)-1? pts[0]:pts[index+1] - pts[index],
    l1 = norm(ba), l2 = norm(bc),
    cos_angle = ba * bc / (l1 * l2),
    tan_half_angle = sqrt((1 - cos_angle) / (1 + cos_angle)),
    bf_length = sqrt(pow(size/2/tan_half_angle,2) + pow(size/2,2)),
    ba_u = ba/l1, bc_u = bc/l2,
    bf = ba_u*bf_length, bg = bc_u*bf_length,
    f = pts[index] + bf,    //  chamfer start point
    g = pts[index] + bg     //  chamfer end point
) concat(index>0? [for (i=[0:index-1]) pts[i]] : [],[f], [g], index<len(pts)-1? [for (i=[index+1: len(pts)-1]) pts[i]] : []);