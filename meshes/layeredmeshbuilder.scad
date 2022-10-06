//  buildMeshFromPointLayers builds a convex mesh
//  The idea is to slice a complex shape in layers and then combine the collection of points into a mesh.
//  This can be very powerful when you use splines to create your layer outlines
//
//  pointLayers is a list of point lists. Here heach point list holds points exclusivly for the 2D path outlining that layer.
//  Each point list must have the 3D points in clock wize order where Z is assumed to be the layer height.
//  Each point list must have the same number of points in the list.
//
//  The routine will cap the mesh by default with the points of the first and last layers but you can turn this off by setting
//  the topCap and/or bottomCap variables to false.
//  Checkout my pathbuilder library. It has powerful routines to create those complex 2D shapes

module buildMeshFromPointLayers(pointLayers = [], topCap=true, bottomCap=true){
    n = len(pointLayers[0]);
    pts = [for (deck=[0:1:len(pointLayers)-1]) each pointLayers[deck]];
	faces = [for (d = [0:1:len(pointLayers)-2], p = [0:1:len(pointLayers[d])-2])
	let(c = (n * d)+ p) [c,c+1, c+n+1,c+n]];
    
    top_points = topCap? pointLayers[len(pointLayers)-1] : [];
    top_faces = [for(i=[len(top_points)-1:-1:0]) i];
    bottom_points = bottomCap? pointLayers[0] : [];
    bottom_faces = [for(i=[len(pts)-1 - len(bottom_points)-1:len(pts)-1]) i];
    with_top_faces = topCap? concat(faces, [top_faces]) : faces;
    all_faces = bottomCap? concat(with_top_faces, [bottom_faces]) : with_top_faces;
	polyhedron(points = pts, faces = all_faces, convexity = 10);
} 