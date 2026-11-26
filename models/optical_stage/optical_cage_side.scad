
$fn=64;

cam_offset = 15;

// 6 and 4.5 for M5
// 5 and 3.6 for M4
// 4 and 2.7 for M3
sh_through = 4;
sh_countersink = 3;
sh_thread = 2.7;

cage_length = 110;
cage_thickness = 5;
cg_margin = 10;

bar_height = 5;
bar_chamfer = 2.5;

slot_offset = 15;
slot_length = 30;

slot_spacing = 30;

// V3
module countersink_cyl() {
    translate([0,0,-2]) {
    cylinder(40, sh_through/2, sh_through/2);
    hull () {
        translate([0,0,-5])cylinder(1, (sh_countersink-1) + (sh_through/2), (sh_countersink-1) + (sh_through/2));
        translate([0,0,mounting_holes_height/2 + 1])cylinder(sh_countersink, (sh_countersink-1) + (sh_through/2), sh_through/2);
    }
}
}

translate([0,0,0])difference() {
    union() {
        hull() {
            translate([60/2,-5,5])rotate([-90,0,0])cylinder(cage_length + 10, 5, 5);
            translate([-60/2,-5,5])rotate([-90,0,0])cylinder(cage_length + 10, 5, 5);
        }
        translate([-70/2,-5,0])cube([70,cage_length + 10,5]);
    }




    hull() {
        translate([slot_spacing/2,(cage_length/2)-(slot_length/2)+ slot_offset,cage_thickness+bar_chamfer + 1 - sh_countersink])cylinder(sh_countersink, sh_through/2, sh_countersink + (sh_through/2));
        translate([slot_spacing/2,(cage_length/2)+(slot_length/2)+slot_offset,cage_thickness +bar_chamfer + 1 - sh_countersink])cylinder(sh_countersink, sh_through/2, sh_countersink + (sh_through/2));
        translate([slot_spacing/2,(cage_length/2)-(slot_length/2)+ slot_offset,cage_thickness+20])cylinder(sh_countersink, sh_through/2, sh_countersink + (sh_through/2));
        translate([slot_spacing/2,(cage_length/2)+(slot_length/2)+slot_offset,cage_thickness+20])cylinder(sh_countersink, sh_through/2, sh_countersink + (sh_through/2));
    }
    hull() {
        translate([slot_spacing/2,(cage_length/2)-(slot_length/2)+slot_offset,-1])cylinder(15, sh_through/2, sh_through/2);
        translate([slot_spacing/2,(cage_length/2)+(slot_length/2)+slot_offset,-1])cylinder(15, sh_through/2, sh_through/2);
    }

    hull() {
        translate([-slot_spacing/2,(cage_length/2)-(slot_length/2)+slot_offset,cage_thickness+bar_chamfer + 1 - sh_countersink])cylinder(sh_countersink, sh_through/2, sh_countersink + (sh_through/2));
        translate([-slot_spacing/2,(cage_length/2)+(slot_length/2)+slot_offset,cage_thickness +bar_chamfer + 1 - sh_countersink])cylinder(sh_countersink, sh_through/2, sh_countersink + (sh_through/2));
        translate([-slot_spacing/2,(cage_length/2)-(slot_length/2)+slot_offset,cage_thickness+20])cylinder(sh_countersink, sh_through/2, sh_countersink + (sh_through/2));
        translate([-slot_spacing/2,(cage_length/2)+(slot_length/2)+slot_offset,cage_thickness+20])cylinder(sh_countersink, sh_through/2, sh_countersink + (sh_through/2));
    }
    hull() {
        translate([-slot_spacing/2,(cage_length/2)-(slot_length/2)+slot_offset,-1])cylinder(15, sh_through/2, sh_through/2);
        translate([-slot_spacing/2,(cage_length/2)+(slot_length/2)+slot_offset,-1])cylinder(15, sh_through/2, sh_through/2);
    }
    
    // mounting holes

    translate([-60/2,0,5])rotate([180,0,0])countersink_cyl();
    translate([-60/2,cage_length,5])rotate([180,0,0])countersink_cyl();
    translate([60/2,0,5])rotate([180,0,0])countersink_cyl();
    translate([60/2,cage_length,5])rotate([180,0,0])countersink_cyl();
 
}

//    translate([60/2,-15,-1])cylinder(15, sh_through/2, sh_through/2);
//    translate([-60/2,-40,-1])cylinder(sh_countersink, sh_countersink + (sh_through/2), sh_through/2);
//    translate([-65/2,0,-1])cylinder(15, sh_thread/2, sh_thread/2);
