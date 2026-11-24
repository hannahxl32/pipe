$fn=64;


sh_through = 4;
sh_countersink = 3;
sh_thread = 4.5; // 2.7 for tapping, 4.5 for brass insert
sh_thread_depth = 7;

mounting_holes_height = 40;
mounting_holes_width = 30;

slop_adjust = 0.3;

back_focal_offset = 10;
shell_thickness = 3;

// V2
module countersink_cyl() {
    translate([0,0,-22]) {
    cylinder(mounting_holes_height + 10, sh_through/2, sh_through/2);
    hull () {
        translate([0,0,-5])cylinder(1, (sh_countersink-1) + (sh_through/2), (sh_countersink-1) + (sh_through/2));
        translate([0,0,mounting_holes_height/2 + 1])cylinder(sh_countersink, (sh_countersink-1) + (sh_through/2), sh_through/2);
    }
}
}



difference() {
    union() {
        hull() {
            translate([-20,15,0])cylinder(shell_thickness,5,5);
            translate([20,15,0])cylinder(shell_thickness,5,5);
            translate([-20,-15,0])cylinder(shell_thickness,5,5);
            translate([20,-15,0])cylinder(shell_thickness,5,5);
        }
        
        translate([-20,15,0])cylinder(7,5,5);
        translate([20,15,0])cylinder(7,5,5);
        translate([-20,-15,0])cylinder(7,5,5);
        translate([20,-15,0])cylinder(7,5,5);
        
        hull() {
            translate([0,0,0])cylinder(back_focal_offset,(15+max(back_focal_offset,5))/2,25/2);
            translate([-20,0,0])cylinder(back_focal_offset,5,5);
            translate([20,0,0])cylinder(back_focal_offset,5,5);
        }

    }
    
    
    
    translate([0,0,back_focal_offset-1.5])cylinder(10,20/2,20/2);
    translate([0,0,-1])cylinder(back_focal_offset,(13+back_focal_offset)/2,13/2); // just brushes the corners of the RPI cam 3 module
    
    
    translate([-mounting_holes_height/2,mounting_holes_width/2,-1])cylinder(15, sh_thread/2, sh_thread/2);
    translate([mounting_holes_height/2,mounting_holes_width/2,-1])cylinder(15, sh_thread/2, sh_thread/2);
    translate([-mounting_holes_height/2,-mounting_holes_width/2,-1])cylinder(15, sh_thread/2, sh_thread/2);
    translate([mounting_holes_height/2,-mounting_holes_width/2,-1])cylinder(15, sh_thread/2, sh_thread/2);
    
    translate([-mounting_holes_height/2,0,-1])cylinder(15+back_focal_offset, sh_thread/2, sh_thread/2);
    translate([mounting_holes_height/2,0,-1])cylinder(15+back_focal_offset, sh_thread/2, sh_thread/2);
}
