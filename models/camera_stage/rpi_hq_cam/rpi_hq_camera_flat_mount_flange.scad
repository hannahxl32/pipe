$fn=64;


sh_through = 4;
sh_countersink = 3;
sh_thread = 4.5; // 2.7 for tapping, 4.5 for brass insert
sh_thread_depth = 7;

mounting_holes_height = 40;
mounting_holes_width = 30;

slop_adjust = 0.3;

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
        translate([-50/2-slop_adjust,-40/2,0])cube([50 + (slop_adjust*2),40,5]);
        
        translate([-50/2-5-slop_adjust,-40/2,0])cube([5,40,30]);
        translate([50/2+slop_adjust,-40/2,0])cube([5,40,30]);
        
        translate([0,0,0])cylinder(10,40/2,40/2);
        translate([-16/2,0,0])cube([16,50/2,10]);
    }
    
    
    
    translate([0,0,-1])cylinder(10,30/2,30/2);
    translate([0,0,5])cylinder(10,36/2,36/2);
    translate([-12/2,0,5])cube([12,(36/2)+5,20]);
    
    
    translate([-mounting_holes_height/2,mounting_holes_width/2,-1])cylinder(15, sh_thread/2, sh_thread/2);
    translate([mounting_holes_height/2,mounting_holes_width/2,-1])cylinder(15, sh_thread/2, sh_thread/2);
    translate([-mounting_holes_height/2,-mounting_holes_width/2,-1])cylinder(15, sh_thread/2, sh_thread/2);
    translate([mounting_holes_height/2,-mounting_holes_width/2,-1])cylinder(15, sh_thread/2, sh_thread/2);
    
    
    translate([-50/2-5,-30/2,25])rotate([0,90,0])countersink_cyl();
    translate([-50/2-5,30/2,25])rotate([0,90,0])countersink_cyl();
    translate([50/2+5,-30/2,25])rotate([0,-90,0])countersink_cyl();
    translate([50/2+5,30/2,25])rotate([0,-90,0])countersink_cyl();
}
