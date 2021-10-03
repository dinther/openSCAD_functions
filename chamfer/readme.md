# function chamfer(pts, index, size)

Applies a chamfer to a point in a list of 2D points.

|parameter|type|Description|
|-------|----|-------|
|pts|2D points|List of 2D points.|
|index|number|Indicates which point need to be chamfered.|
|size|number|Size of the chamfered corner surface.|
|-------|----|-------|
|return|list|List of 2D points with chamfer applied.

### screenshot of demo code<br>
![image](https://user-images.githubusercontent.com/1192916/135736777-bcc9f928-07c4-4c8b-8664-122900cbba77.png)

### example code:

```
include <chamfer.scad>

pts = [[0,0],[10,0],[10,10]];
new_pts = chamfer(pts=pts, index=0, size=3);
polygon(new_pts);
```
