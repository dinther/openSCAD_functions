$fn=45;

digit_height = 14.5;
display_outer_width = 60.7;
digit_width = display_outer_width / 8;

module segmentblock(){
    translate([0,0,7.2]) color("black") cube([30,14,0.1]);
    color("ivory") difference(){
        cube([30,14,7.2]);
        translate([3,-1,0]) cube([24,16,0.6]);
        translate([-1,3,0]) cube([32,8,0.6]);
        
    }
    translate([8.7, 1.6, -1.3]) for (i =[0:5]) translate([i*13.3/5,0,0]){ cylinder(d=0.3, h=1.9, $fn=5); translate([0, 0,3]) cylinder(d=0.6, h=0.2, $fn=5);}
    translate([8.7, 14-1.6, -1.3]) for (i =[0:5]) translate([i*13.3/5,0,0]){ cylinder(d=0.3, h=1.9, $fn=5); translate([0, 0,3]) cylinder(d=0.6, h=0.2, $fn=5);}
    translate([0.4,2.6,7.2]) color("red") linear_extrude(0.15) text("8888",size = 9.5,font="Liberation Sans:style=Italic");
}

//  slot is an array of 8 values being either 0, 1, 2 or 3
//  eg: slot = [1,1,1,0,1,1,2,0];

module displayslot(slot){
    translate([0, 0, -0.1]) linear_extrude(thickness-0.9) union(){
        for (i =[0:7]){
            translate([digit_width * i, 0]) square([digit_width, digit_height]);
        }
    }
    translate([0, 0, -1]) linear_extrude(thickness+2) offset(delta=-ridge) union(){
        for (i =[0:7]){
            //  1 = Full digit hole
            if (slot[i] == 1){
                translate([digit_width * i, 0]) square([digit_width, digit_height]);
                
            }
        }
    }
    for (i =[0:7]){
        //  2 = two signal light holes
        if (slot[i] == 2){
            translate([digit_width * (i+0.5), digit_height-3.5, -1]) cylinder(d=1.75, h=thickness+2); //  Top hole
            translate([digit_width * (i+0.5), 3, -1]) cylinder(d=1.75, h=thickness+2);  //  Bottom hole
        }
        //  3 = minus sign
        if (slot[i] == 3){
            translate([digit_width * (i+0.5)-1.9, 6.7, -1]) cube([4, 0.7, thickness+2]);
        }
    }
}

module 8_digit_7_segment_max9219_display_module(){
    t = 1.4;
    difference(){
        color("blue") cube([82.4, 15, t]);
        s = (15-8.5)*0.5; //76.4
        translate([s,s,-1]) cylinder(d=3.2, h=3.4);
        translate([s,15-s,-1]) cylinder(d=3.2, h=3.4);
        translate([s+76.4,s,-1]) cylinder(d=3.2, h=3.4);
        translate([s+76.4,15-s,-1]) cylinder(d=3.2, h=3.4);
        
        translate([7.4, 0, -0.01]) for (i =[1:5]) translate([0,i*2.5,0]) cylinder(d=0.3, h=t+0.02, $fn=9);
        translate([82.4-7.4, 0, -0.01]) for (i =[1:5]) translate([0,i*2.5,0]) cylinder(d=0.3, h=t+0.02, $fn=9);
    }
    translate([13.1,0.5,1.41]) segmentblock();
    translate([43.2,0.5,1.41]) segmentblock();

    translate([35.9,4,-2.8]) color("black") cube([15.2,7,2.8]);
    translate([34.9, 4.2, -1.0]) for (i =[1:12]) translate([i*14.5/11,0,0]) rotate([55,0,0]) color("silver") cylinder(d=0.3, h=2, $fn=5);
    translate([34.9, 12.5, 0.2]) for (i =[1:12]) translate([i*14.5/11,0,0]) rotate([125,0,0]) color("silver") cylinder(d=0.3, h=2, $fn=5);
}
