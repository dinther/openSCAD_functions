# function ellipseArc(p1, p2 rx, ry, angle, long, ccw)

Produces a list of 2D points that approximates the arc segment required to from p1 to p2.

|parameter|type|Description|
|-------|----|-------|
|p1|2D point|Start point for the arc segment.|
|p2|2D point|End point of the arc segment.|
|rx|number|x radius for the ellipse when angle = 0|
|ry|number|y radius for the ellipse when angle = 0|
|angle|number|Rotation angle of the ellipse around it's center point.|
|long|bool|Two ways around the ellipse. Set to true to take the long way.|
|ccw|bool|Set to true of you want the acr drawn following the ellipse counter clock wize.|
|-------|----|-------|
|return|list|List with two items.
|return[0]|list|2D point list forming a polyline representing the ellipseArc.|
|return[1]|2D point|2D point which represents the position of the ellipse center point.|

### video of demo code in action<br>
https://user-images.githubusercontent.com/1192916/135073287-828f0539-6259-4723-a153-ddf592404a4a.mp4

### example code:

```
//  Helper function to draw polylines for visualisation
module polyline(points, width = 2, closed=false) {
    points=closed? concat(points,[points[0]]) : points;
    for(i = [0:len(points)-2]) hull(){ translate(points[i]) circle(d=width,$fn=16); translate(points[i+1]) circle(d=width); }
}

data = ellipseArc([-50,0], [40,-100], 80, 140, 20, false, false);
color("yellow") polyline(data[0]);
echo(center_of_ellipse_is=data[1]);
```
