function segments(r=1) = $fn>0?($fn>=3?$fn:3):ceil(max(min(360/$fa,abs((rx+ry)/2)*2*PI/$fs),5));

function ellipseCenter(last=[0,0], p2=[], rx, ry, angle, fA, fS)= let(
P = [[cos(angle), sin(angle)], [-sin(angle), cos(angle)]] * ((last-p2)*0.5),
x1p = P[0], y1p = P[1],
lambda =  ((x1p * x1p) / (rx * rx) ) + ( (y1p * y1p) / (ry * ry) ),
rx = lambda > 1? (sqrt(lambda) * abs(rx)) : abs(rx),
ry = lambda > 1? (sqrt(lambda) * abs(ry)) : abs(ry),
flip = fA == fS? -1 : 1,
co = (fA == fS? 1 : -1) * sqrt(( (rx*rx*ry*ry) - (rx*rx*y1p*y1p) - (ry*ry*x1p*x1p) ) / ( (rx*rx*y1p*y1p) + (ry*ry*x1p*x1p) )),
Cp = [rx*y1p/ry, -ry*x1p/rx] * co)([[ cos(angle), -sin(angle)],[sin(angle), cos(angle)]] * Cp) + ((last+p2)*0.5);

function ellipseArc(p1=[], p2=[], rx, ry, angle=0, large_arc=false, ccw=false) = rx==0||ry==0? [p1,p2] : let(
    d = norm(p2-p1),
    e = assert(rx*2>=d, str("Radius:",rx," is too small for distance:",d)),
    x3 = (p1[0] + p2[0])/2,
    y3 = (p1[1] + p2[1])/2,
    basex = sqrt(pow(rx,2) - pow((d / 2),2)) * (p1[1] - p2[1]) / d,
    basey = sqrt(pow(ry,2) - pow((d / 2),2)) * (p2[0] - p1[0]) / d,
    xor = large_arc&&!ccw || !large_arc&&ccw,
    pc = ellipseCenter(p2,p1,rx,ry,angle, large_arc, ccw),
    m = [[cos(-angle), -sin(-angle)],[sin(-angle), cos(-angle)]],
    nm = [[cos(angle), -sin(angle)],[sin(angle), cos(angle)]],
    v1 = (p1-pc) * nm,
    v2 = (p2-pc) * nm,
    a1 = (v1[1]<0? 180 : 0)+ atan2(v1[0]/v1[1],rx/ry),
    a2 = (v2[1]<0? 180 : 0)+ atan2(v2[0]/v2[1],rx/ry),
    da = abs(a2 - a1 % 360),
    das = da<=180? da : 360-da,
    cda = large_arc? 360-das : das,
    steps = floor(abs(cda*(segments((rx+ry)/2))/360)),
    sa = ccw? -(cda/steps) : cda/steps,
    angles = [for(i=[1:steps-1]) (a1 + (sa * i))%360],
    pts = steps<=2? [p1,p2] : [p1,for(a=angles) pc+[sin(a) * rx , cos(a) * ry] * m, p2]
) [pts,concat(pc,0)];
