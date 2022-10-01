l = 101.6;
w = 53.3;
t = 1.6;
$fn=45;

module arduino_mega_pcb_holes(diameter = 3.2, height = 1.6){
    translate([13.97, 2.54, 0]) cylinder(d=diameter,h=height);
    translate([15.3, 50.7, 0])  cylinder(d=diameter,h=height);
    translate([66.1, 35.5, 0])  cylinder(d=diameter,h=height);
    translate([66.1, 35.5, 0])  cylinder(d=diameter,h=height);
    translate([66.1, 7.6, 0])   cylinder(d=diameter,h=height);
    translate([90.2, 50.7, 0])  cylinder(d=diameter,h=height);
    translate([96.52, 2.52, 0]) cylinder(d=diameter,h=height);
}

module arduino_mega_pcb(){
    b = 2.8;
    difference(){
        linear_extrude(t) polygon([[0,0],[l-b,0],[l-b,1],[l,1 + b],[l,1 + b + 35],[l-b, 1 + b + 35 + b],[l-b,w-2],[l-b-2,w],[0,w]]);
        //  PCB holes
        translate([0,0,-1]) arduino_mega_pcb_holes(3.2, t + 2);
    }
}

module arduino_mega_headers(){
    translate([17.6,w-3.9,t]) cube([25.6, 2.3, 8.9]);
    translate([44.6,w-3.9,t]) cube([20.5, 2.3, 8.9]);
    translate([67,w-3.9,t]) cube([20.5, 2.3, 8.9]);
    
    translate([26.1,1.8,t]) cube([20.5, 2.3, 8.9]);
    translate([49,1.8,t]) cube([20.5, 2.3, 8.9]);
    translate([72.3,1.8,t]) cube([20.5, 2.3, 8.9]);
    
    translate([93,6.4,t]) cube([4.8,45.9, 8.9]);
    
    translate([15.1,w-9.6,t]) cube([7.2, 5, 8.9]);
    translate([62.5, 24.6,t]) cube([5, 7.2, 8.9]);   
}

module arduino_mega_components(){
    //  cpu
    translate([43.1,21.3,t]) color("#111111") cube([13.4, 13.4, 1.3]);
    //  button
    translate([70.8,24.8,t]) color("silver") cube([6.3, 6.3, 2.1]);
    translate([73.95,27.95,t+2.1]) color("red") cylinder(d = 2.8, h = 0.9);
}

module arduino_mega_USB_plug(){
    translate([-6.3,32.3,t]) color("silver") cube([16.1,12,10.6]);
}

module arduino_mega_USB_plug_cut(){  //  0.5mm oversized for hole cutting
    translate([-6.3,32.05,t-0.25]) color("silver") cube([16.1,12.5,11.1]);
}

module arduino_mega_DC_plug_cut(){  //  0.5mm oversized for hole cutting
    translate([-4.7,3.95,t-0.25]){ cube([6,9.3,11.1]); }    
}

module arduino_mega_DC_plug(){
    color("#111111") difference(){
        union(){
            translate([-1.7,4.2,t]){ cube([13.6,8.8,6.2]); cube([3,8.8,10.6]); }
            translate([-1.7,8.6,t+6.2]) rotate([0,90,0]) cylinder(d=8.8, h=13.6);
        }
        translate([-1.71,8.6,t+6.2]) rotate([0,90,0]) cylinder(d=6.2, h=11.6);
    }
    translate([1,8.6,t+6.2]) rotate([0,90,0]) color("silver") cylinder(d=1.3, h=8);
}

module arduino_mega(){
    color("blue") arduino_mega_pcb();
    color("#111111") arduino_mega_headers();
    arduino_mega_USB_plug();
    arduino_mega_DC_plug();
    arduino_mega_components();
}





