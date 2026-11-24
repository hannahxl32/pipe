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
outer_height = 27;
shell_umod_height = outer_height/2 - slop_adjust;
shell_height = shell_umod_height - 2; // We need some clamping force on the mirrors, so this leaves a small gap


module countersink_cyl() {
    translate([0,0,-21]){
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

lhw = 20;
lhh = lhw / (4/3); // Sensor's native resolution is in 4/3 aspect ratio.

difference() {
    union(){
        translate([-30/2, -90/2, 0])cube([30,90,shell_height]);
        translate([-15, -50/2, 0])cube([15,50,shell_umod_height]);
    }
    translate([0, -ifd/2, outer_height/2])rotate([0,90,-45])cylinder(4,25.5/2,25.5/2);
    translate([0, ifd/2, outer_height/2])rotate([0,90,45])cylinder(4,25.5/2,25.5/2);

    
    difference(){
        hull() {
            translate([-lhh/2, -(ifd-lhh)/2, (outer_height/2)-(lhw/2)])cube([lhh, (ifd-lhh), lhw]);
        translate([-50-(lhh/2), -ifd/2-(lhh/2), (outer_height/2)-(lhw/2)])cube([50, lhh, lhw]);
        translate([-50-(lhh/2), ifd/2-(lhh/2), (outer_height/2)-(lhw/2)])cube([50, lhh, lhw]);
        }
        translate([-lhh/2-100, -(ifd-lhh)/2, -5])cube([100, (ifd-lhh), 100]);
    }

    translate([7.5, 37.5, -5])cylinder(100, sh_thread/2, sh_thread/2);
    translate([7.5, -37.5, shell_height])countersink_cyl();

    translate([-50,15,(outer_height/2) - 10])rotate([0,90,0])cylinder(100, sh_thread/2, sh_thread/2);
    translate([-50,-15,(outer_height/2) - 10])rotate([0,90,0])cylinder(100, sh_thread/2, sh_thread/2);

    translate([-11.25,-5,-5])cylinder(mounting_holes_height + 10, sh_thread/2, sh_thread/2);
    translate([-11.25,5,-5])cylinder(mounting_holes_height + 10, sh_through/2, sh_through/2);
    translate([-11.25,5,-1])cylinder(sh_countersink, (sh_countersink-1) + (sh_through/2), sh_through/2);

    translate([0,0,(outer_height/2)])rotate([0,90,0])cylinder(mounting_holes_height + 10, 10, 10);
}