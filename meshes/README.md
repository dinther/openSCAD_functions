## Layered Mesh builder

This routine is essentially doing the opposite of what a slicer program does for 3D printers. Through a stack of 2D outlines it is possible to create complex parametric shapes of very  complex geometry.

![image](https://user-images.githubusercontent.com/1192916/194210768-0d9f865b-5b37-4c64-922b-d006413401e4.png)

This is a very high resolution 3D model of a ship hull. By using splines to draw the 2D path outlines it is possible to really crank up the resolution.
I strongly recommend my library pathbuilder to define the path outlines. It uses SVG syntax handling a range of spline types with ease.


