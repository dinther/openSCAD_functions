include <ellipseArc.scad>

//  Play with these values in the customizer panel
angle = -20; // [0:15:360]
large_arc=false;
ccw = false;
show_details = false;

//  Helper function to draw polylines for visualisation
module polyline(points, width = 1, closed=false) {
    points=closed? concat(points,[points[0]]) : points;
    for(i = [0:len(points)-2]) hull(){ translate(points[i]) circle(d=width,$fn=16); translate(points[i+1]) circle(d=width); }
}

module polar_line(start_point=[], angle=0, distance=1, width=1){
    hull(){
        translate(start_point) circle(d=width);
        translate(start_point + [sin(angle)*distance, cos(angle)*distance]) circle(d=width);
    }
}

$fa = 6;
rx = 80;
ry = 140;
p1 = [-50,0];
p2 = [40,-100];

translate(p1) color("green"){
   circle(r=3);
   translate([10,-4]) text("p1");
}

translate(p2) color("red"){
   circle(r=3);
   translate([-5,10]) text("p2");
}

//  Calculate segment points
data = ellipseArc(p1, p2, rx, ry, angle, large_arc, ccw);
color("yellow") polyline(data[0]);

if (show_details){
    //  Draw ellipsis coordinate axis in blue
    translate(data[1]) rotate(angle) color("blue"){
        polyline([[-rx*1,0],[rx*1,0]]);
        polyline([[0,-ry*1],[0, ry*1]]);
    }
    data1 = ellipseArc(p1, p2, rx, ry, angle, !large_arc, !ccw);
    color("gray") polyline(data1[0]);
}

echo("******************************************");
echo(str("*  ellipse center  point:  ", data[1], "              "));
echo("******************************************");
