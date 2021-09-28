//  openSCAD functions
//  https://github.com/dinther/openSCAD_functions
//  
//  Note:
//      ellipseArc uses two other functions:
//          segments
//          ellipseCenter
//
//      These functions can be useful in themselves but can also be substituted
//      The relevant lines are surrounded by empty lines in the ellipseArc function.


//  function segments(r)
//
//  Calculates how many segments per 360 degrees would be used
//  with the current $fn, $fa and $fs setings and given radius.
//  r           average radius of the curve.
//
//  return      number of segments required for 360 degrees
function segments(r=1) = $fn>0?($fn>=3?$fn:3):ceil(max(min(360/$fa,abs(r)*2*PI/$fs),5));

//  function ellipseCenter(p1, p2, rx, ry, angle, long, ccw)
//
//  Calculates center of a ellipse rx, ry rotated to angle that runs through both p1 and p2.
//  p1          2D start point for the arc segment.
//  p2          2D end point of the arc segment.
//  rx          x radius for the ellipse when angle = 0
//  ry          y radius for the ellipse when angle = 0
//  angle       rotation angle of the ellipse around it's center point.
//  long        Two ways around the ellipse. Set to true to take the long way.
//  ccw         Set to true of you want the acr drawn following the ellipse counter clock wize.
//
//  return      List with two values.
//      return[0]   2D point list forming a polyline representing the ellipseArc.
//      return[1]   2D point which represents the position of the ellipse center point.
function ellipseCenter(p1=[], p2=[], rx, ry, angle=0, long=false, ccw=false)= let(
P = [[cos(-angle), sin(-angle)], [-sin(-angle), cos(-angle)]] * ((p1-p2)*0.5),
x = P[0], y = P[1], a =  ((x * x) / (rx * rx) ) + ( (y * y) / (ry * ry) ),
rx = a > 1? (sqrt(a) * abs(rx)) : abs(rx), ry = a > 1? (sqrt(a) * abs(ry)) : abs(ry),
co = (long == ccw? 1 : -1) * sqrt(( (rx*rx*ry*ry) - (rx*rx*y*y) - (ry*ry*x*x) ) / ( (rx*rx*y*y) + (ry*ry*x*x) )),
C = ([[ cos(-angle), -sin(-angle)],[sin(-angle), cos(-angle)]] * [rx*y/ry, -ry*x/rx] * co) + ((p1+p2)*0.5)) C;


//  function ellipseArc(p1, p2, rx, ry, angle, long, ccw)
//
//  Produces a list of 2D points that approximates the arc segment required to from p1 to p2.
//  p1          2D start point for the arc segment.
//  p2          2D end point of the arc segment.
//  rx          x radius for the ellipse when angle = 0
//  ry          y radius for the ellipse when angle = 0
//  angle       rotation angle of the ellipse around it's center point.
//  long        Two ways around the ellipse. Set to true to take the long way.
//  ccw         Set to true of you want the acr drawn following the ellipse counter clock wize.
//
//  return      List with two values.
//      return[0]   2D point list forming a polyline representing the ellipseArc.
//      return[1]   2D point which represents the position of the ellipse center point.

function ellipseArc(p1=[], p2=[], rx, ry, angle=0, long=false, ccw=false) = rx==0||ry==0? [p1,p2] : let(
    d = norm(p2-p1),
    e = assert(rx*2>=d, str("Radius:",rx," is too small for distance:",d)),
   
    pc = ellipseCenter(p2,p1,rx,ry,angle, long, ccw),
    
    m = [[cos(angle), -sin(angle)],[sin(angle), cos(angle)]],
    nm = [[cos(-angle), -sin(-angle)],[sin(-angle), cos(-angle)]],
    v1 = (p1-pc) * nm, v2 = (p2-pc) * nm,
    a1 = (v1[1]<0? 180 : 0)+ atan2(v1[0]/v1[1],rx/ry),
    a2 = (v2[1]<0? 180 : 0)+ atan2(v2[0]/v2[1],rx/ry),
    da = abs(a2 - a1 % 360), das = da<=180? da : 360-da,
    cda = long? 360-das : das,
    
    s = segments((rx+ry)/2),
    
    steps = floor(abs(cda*s/360)), sa = ccw? -(cda/steps) : cda/steps,
    angles = [for(i=[1:steps-1]) (a1 + (sa * i))%360],
    pts = steps<=2? [p1,p2] : [p1,for(a=angles) pc+[sin(a) * rx , cos(a) * ry] * m, p2]
) [pts,concat(pc,0)];
    
//  quick test
//polygon(ellipseArc([0,0], [100,40], 100,140,0,false,false)[0]);
