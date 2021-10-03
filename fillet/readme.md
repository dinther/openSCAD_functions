# function fillet(pts, index, radius)

Applies a fillet with given radius to a point in a list of 2D points.
The segmentation of the curve is donw according $fn, $fa and $fs
Make the radius negative to flip the curve.

|parameter|type|Description|
|-------|----|-------|
|pts|2D points|List of 2D points.|
|index|number|Indicates which point need to be filleted.|
|size|number|Radius of the fillet.|
|-------|----|-------|
|return|list|List of 2D points with fillet applied.

### screenshot of demo code<br>
![image](https://user-images.githubusercontent.com/1192916/135736777-bcc9f928-07c4-4c8b-8664-122900cbba77.png)

### example code:

```
include <fillet.scad>

pts = [[0,0],[40,0],[40,40]];
new_pts = fillet(pts, 1, 10);
polygon(new_pts);
```
