$fn = 64;

sh_through = 4;
sh_countersink = 3;
sh_thread = 4.5; // 2.7 for tapping, 4.5 for brass insert
sh_thread_depth = 7;

// 4 and 2.7 for M3
// 3 and 1.9 for M2

tsh_through = 3.2;
tsh_countersink = 2;
tsh_thread = 3.3;

mounting_holes_height = 30;
mounting_holes_width = mounting_holes_height;

mount_hole_pad_dia = 3;

translate([0,0,0])difference() {
    union() {
        translate([-25,-20,0])cube([50,40,10]);
    }
    
    difference() {
        translate([-19,-19,10-4])cube([38,38,5]);
        hull() {
            translate([-mounting_holes_height/2,mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
            translate([-mounting_holes_height/2-20,mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
            translate([-mounting_holes_height/2,mounting_holes_width/2+20,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
        }
        hull() {
            translate([mounting_holes_height/2,mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
            translate([mounting_holes_height/2+20,mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
            translate([mounting_holes_height/2,mounting_holes_width/2+20,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
        }
        hull() {
            translate([-mounting_holes_height/2,-mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
            translate([-mounting_holes_height/2-20,-mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
            translate([-mounting_holes_height/2,-mounting_holes_width/2-20,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
        }
        hull() {
            translate([mounting_holes_height/2,-mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
            translate([mounting_holes_height/2+20,-mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
            translate([mounting_holes_height/2,-mounting_holes_width/2-20,0])cylinder(50, mount_hole_pad_dia, mount_hole_pad_dia);
        }
    }

    difference() {
        translate([-35/2,-35/2,-1])cube([35,35,10]);
        hull() {
            translate([-mounting_holes_height/2,mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
            translate([-mounting_holes_height/2-20,mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
            translate([-mounting_holes_height/2,mounting_holes_width/2+20,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
        }
        hull() {
            translate([mounting_holes_height/2,mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
            translate([mounting_holes_height/2+20,mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
            translate([mounting_holes_height/2,mounting_holes_width/2+20,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
        }
        hull() {
            translate([-mounting_holes_height/2,-mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
            translate([-mounting_holes_height/2-20,-mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
            translate([-mounting_holes_height/2,-mounting_holes_width/2-20,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
        }
        hull() {
            translate([mounting_holes_height/2,-mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
            translate([mounting_holes_height/2+20,-mounting_holes_width/2,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
            translate([mounting_holes_height/2,-mounting_holes_width/2-20,0])cylinder(50, mount_hole_pad_dia+2, mount_hole_pad_dia+2);
        }
    }
    
    
    
    cutout_width = mounting_holes_width - (mount_hole_pad_dia * 2);
    translate([-cutout_width/2,-50/2,10-4])cube([cutout_width,50,5]);
 
    
    translate([-mounting_holes_height/2,mounting_holes_width/2,-1])cylinder(15, tsh_thread/2, tsh_thread/2);
    translate([mounting_holes_height/2,mounting_holes_width/2,-1])cylinder(15, tsh_thread/2, tsh_thread/2);
    translate([-mounting_holes_height/2,-mounting_holes_width/2,-1])cylinder(15, tsh_thread/2, tsh_thread/2);
    translate([mounting_holes_height/2,-mounting_holes_width/2,-1])cylinder(15, tsh_thread/2, tsh_thread/2);
    
    translate([-50/2-1,-30/2,5])rotate([0,90,0])cylinder(sh_thread_depth+1, sh_thread/2, sh_thread/2);
    translate([-50/2-1,30/2,5])rotate([0,90,0])cylinder(sh_thread_depth+1, sh_thread/2, sh_thread/2);
    translate([50/2+1,-30/2,5])rotate([0,-90,0])cylinder(sh_thread_depth+1, sh_thread/2, sh_thread/2);
    translate([50/2+1,30/2,5])rotate([0,-90,0])cylinder(sh_thread_depth+1, sh_thread/2, sh_thread/2);
}