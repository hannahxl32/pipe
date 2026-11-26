$fn=64;

sh_through = 4;
sh_countersink = 3;
sh_thread = 4.5; // 2.7 for tapping, 4.5 for brass insert
sh_thread_depth = 6;

shell_thickness = 3;
shell_thread_hole_thickness = 10;
shell_thread_hole_diameter = 8;
path_width = 10;

mount_holes_length = 130;
mount_holes_width = 80;

// V3
module countersink_cyl() {
    translate([0,0,-50])cylinder(100, sh_through/2, sh_through/2);
    hull () {
        translate([0,0,50])cylinder(1, (sh_countersink-1) + (sh_through/2), (sh_countersink-1) + (sh_through/2));
        translate([0,0,-2.5])cylinder(sh_countersink-0.5, sh_through/2, (sh_countersink-1) + (sh_through/2));
    }
}

module thread_cyl() {
    translate([0,0,-50])cylinder(100, sh_thread/2, sh_thread/2);
    hull () {
        translate([0,0,50])cylinder(1, (sh_countersink-1) + (sh_thread/2), (sh_countersink-1) + (sh_thread/2));
        translate([0,0,0])cylinder(sh_countersink+2, sh_thread/2, (sh_countersink-1) + (sh_thread/2));
    }
}

difference() {
    union() {
        hull() {
            translate([mount_holes_width/2,mount_holes_length/2,0])cylinder(shell_thickness, path_width/2, path_width/2);
            translate([-mount_holes_width/2,mount_holes_length/2,0])cylinder(shell_thickness, path_width/2, path_width/2);
        }
        hull() {
            translate([mount_holes_width/2,-mount_holes_length/2,0])cylinder(shell_thickness, path_width/2, path_width/2);
            translate([-mount_holes_width/2,-mount_holes_length/2,0])cylinder(shell_thickness, path_width/2, path_width/2);
        }
        hull() {
            translate([mount_holes_width/2,mount_holes_length/2,0])cylinder(shell_thickness, path_width/2, path_width/2);
            translate([mount_holes_width/2,-mount_holes_length/2,0])cylinder(shell_thickness, path_width/2, path_width/2);
        }
        hull() {
            translate([-mount_holes_width/2,mount_holes_length/2,0])cylinder(shell_thickness, path_width/2, path_width/2);
            translate([-mount_holes_width/2,-mount_holes_length/2,0])cylinder(shell_thickness, path_width/2, path_width/2);
        }
        // middle horiz
        hull() {
            translate([mount_holes_width/2,0,0])cylinder(shell_thickness, path_width/2, path_width/2);
            translate([-mount_holes_width/2,0,0])cylinder(shell_thickness, path_width/2, path_width/2);
        }

        translate([-70/2,0,0])cylinder(6, path_width/2, path_width/2);
        translate([70/2,0,0])cylinder(6, path_width/2, path_width/2);
    }

    translate([mount_holes_width/2,mount_holes_length/2,shell_thickness])countersink_cyl();
    translate([-mount_holes_width/2,mount_holes_length/2,shell_thickness])countersink_cyl();
    translate([mount_holes_width/2,-mount_holes_length/2,shell_thickness])countersink_cyl();
    translate([-mount_holes_width/2,-mount_holes_length/2,shell_thickness])countersink_cyl();
    
    
    translate([-70/2,0,6])thread_cyl();
    translate([70/2,0,6])thread_cyl();
}