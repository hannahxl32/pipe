$fn=64;

sh_through = 4;
sh_countersink = 3;
sh_thread = 4.5; // 2.7 for tapping, 4.5 for brass insert
sh_thread_depth = 6;

shell_thickness = 2;
shell_thread_hole_thickness = 10;
shell_thread_hole_diameter = 8;

mounting_holes_height = 30;
mounting_holes_width = 40;

optical_hole = 30;
mirror_hole = 40;
flange_thickness = 3;

flange_gap = 20;
ifd = flange_gap + 40;

slop_adjust = 0.25;
shell_height = 50/2 - slop_adjust;

slider_tolerance = 0.75; // Needs to take into account thickness of aluminium tape.

module countersink_cyl() {
    translate([0,0,-20]){
        cylinder(mounting_holes_height + 10, sh_through/2, sh_through/2);
        hull () {
            translate([0,0,-5])cylinder(1, (sh_countersink-1) + (sh_through/2), (sh_countersink-1) + (sh_through/2));
            translate([0,0,mounting_holes_height/2 + 1])cylinder(sh_countersink, (sh_countersink-1) + (sh_through/2), sh_through/2);
        }
    }
}

module thread_cyl() {
    translate([0,0,-25]){
        cylinder(mounting_holes_height + 10, sh_thread/2, sh_thread/2);
        hull () {
            translate([0,0,-5])cylinder(1, (sh_countersink-1) + (sh_through/2), (sh_countersink-1) + (sh_through/2));
            translate([0,0,mounting_holes_height/2 - sh_countersink])cylinder(sh_countersink+2, (sh_countersink-1) + (sh_through/2), sh_thread/2);
        }
    }
}

slider_rail_gap = 30;

module mirror_holder() {
    hull() {
        translate([-(8/2), -(36/2), 0])cube([8, 36,flange_thickness]);
        translate([-(14/2), -(30/2), 0])cube([14, 30,flange_thickness]);
    }
}

lhw = 20;
lhh = lhw / (4/3); // Sensor's native resolution is in 4/3 aspect ratio.

module mirror_holes() {
    translate([-(lhh/2), -(lhw/2), -1])cube([lhh,lhw,30]);

    translate([-(3/2)-slider_tolerance, (slider_rail_gap/2), -5])cube([3 + (slider_tolerance*2),10,30]);
    translate([-(3/2)-slider_tolerance, -10 - (slider_rail_gap/2), -5])cube([3 + (slider_tolerance*2),10,30]);
}


carrier_width = 80;




difference(){
    union() {
        translate([-ifd/2, 0, 0])mirror_holder();
        translate([ifd/2, 0, 0])rotate([0,0,180])mirror_holder();

        translate([-carrier_width/2, -30/2, 0])cube([carrier_width,30,flange_thickness]);
        
        translate([0,0,0])cylinder(15,5,5);;
    }
    translate([-ifd/2, 0, 0])mirror_holes();
    translate([ifd/2, 0, 0])rotate([0,0,180])mirror_holes();
    translate([-15, -10, 0])rotate([0,180,0])countersink_cyl();
    translate([15, -10, 0])rotate([0,180,0])countersink_cyl();
    translate([-15, 10, 0])rotate([0,180,0])countersink_cyl();
    translate([15, 10, 0])rotate([0,180,0])countersink_cyl();

    translate([0,0,-1])cylinder(30,6.5/2,6.5/2);
}