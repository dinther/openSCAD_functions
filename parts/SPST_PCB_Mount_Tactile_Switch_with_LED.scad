//https://www.jaycar.co.nz/spst-pcb-mount-tactile-switch-with-green-led/p/SP0621

module SPST_PCB_Mount_Tactile_Switch_with_LED(){
    p = [[0,0],[0.3,0],[0.3,0.59],[0.36,0.8],[0.6,1.18],[0.67,1.33],[0.69,1.5],[0.67,1.67],[0.6,1.82],[0.36,2.2],[0.3,2.41],[0.3,3],[0,3],[0,2.41],[0.081,2.11],[0.33,1.68],[0.37,1.58],[0.39,1.48],[0.37,1.37],[0.33,1.27],[0.081,0.84],[0,0.54]];
   translate([0,0,-4.7]){
        color("#222222") difference(){
            translate([0,0,7.3]) cylinder(d=8.0, h=0.5);
            translate([0,0,7.6]) cylinder(d=3.5, h=0.3);
        }
        color("green") translate([0,0,7.6]) cylinder(d=3.4, h=0.2);
        color("#222222") translate([0,0,4.7]) cylinder(d=9.8, h=2.6);
        color("#222222") translate([0,0,4.1]) cylinder(d=8.8, h=1.1);
        color("#222222") intersection(){
            cylinder(d=8.8, h=4.7);
            translate([-3.25, -3.85]) cube([6.5, 7.7, 4.1]);
        }
        color("silver"){
            //  switch legs
            translate([2.9,-0.25-2.25,0]) rotate([-90,-5,0]) linear_extrude(0.5) polygon(p);
            translate([2.9,-0.25+2.25,0]) rotate([-90,-5,0]) linear_extrude(0.5) polygon(p);
            mirror([1,0,0]){
                translate([2.9,-0.25-2.25,0]) rotate([-90,-5,0]) linear_extrude(0.5) polygon(p);
                translate([2.9,-0.25+2.25,0]) rotate([-90,-5,0]) linear_extrude(0.5) polygon(p);
            }
            //  LED legs
            translate([0,3.5,-8]) cylinder(d=0.15, h=8);
            translate([0,-3.5,-6]) cylinder(d=0.15, h=8);
        }
    }
}