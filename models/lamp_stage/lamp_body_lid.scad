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
rails_gap = 0.5;
shell_height = 50/2 - slop_adjust;

module flange() {
    union() {
        translate([-20, 0, 0])cube([40,shell_thickness,shell_height]);

        hull() {
            translate([0,5,0])cylinder(shell_thread_hole_thickness, shell_thread_hole_diameter/2, shell_thread_hole_diameter/2);
            translate([-shell_thread_hole_diameter/2,0,0])cube([shell_thread_hole_diameter, 1,shell_thread_hole_thickness]);
        }
    }
}

module flange_holes() {
    translate([0,-1,50/2])rotate([-90,0,0])cylinder(shell_thickness+2, optical_hole/2, optical_hole/2);

    translate([0,5,-1])cylinder(shell_thread_hole_thickness + 2, sh_thread/2, sh_thread/2);
}

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

module thread_cyl() {
    translate([0,0,-22]) {
        cylinder(mounting_holes_height + 10, sh_thread/2, sh_thread/2);
        hull () {
            translate([0,0,-5])cylinder(1, (sh_countersink-1) + (sh_through/2), (sh_countersink-1) + (sh_through/2));
            translate([0,0,mounting_holes_height/2 - sh_countersink])cylinder(sh_countersink+2, (sh_countersink-1) + (sh_through/2), sh_thread/2);
        }
    }
}

module asymmetric_bolt_post() {
    hull() {
        translate([5,0,0])cylinder(shell_height, 10/2, 10/2);
        translate([0,-5,0])translate([0, 0, 0])cube([2,10,shell_height]);
    }
}

module asymmetric_bolt_post_thread() {
    translate([5,0,22])thread_cyl();
}

module asymmetric_bolt_post_cs() {
    translate([5,0,25])countersink_cyl();
}

shell_depth_add = 32.5;
shell_width_add = 10;

module shell_half() {
    // walls
    translate([-50, 0, 0])cube([shell_thickness,12.5,shell_height]);
    hull() {
        translate([-50 + (shell_thickness/2),12.5,0])cylinder(shell_height, shell_thickness/2, shell_thickness/2);
        translate([-50 + (shell_thickness/2) - shell_width_add,12.5 + shell_width_add,0])cylinder(shell_height, shell_thickness/2, shell_thickness/2);
    }
    translate([-50 - shell_width_add, 12.5 + shell_width_add, 0])cube([shell_thickness,2.5 + shell_depth_add - shell_width_add,shell_height]);
    hull() {
        translate([-50 + (shell_thickness/2),15 + shell_width_add + shell_depth_add,0])cylinder(shell_height, shell_thickness/2, shell_thickness/2);
        translate([-50 + (shell_thickness/2) - shell_width_add,15 + shell_depth_add,0])cylinder(shell_height, shell_thickness/2, shell_thickness/2);
    }
    hull() {
        translate([-50 + (shell_thickness/2),15 + shell_width_add + shell_depth_add,0])cylinder(shell_height, shell_thickness/2, shell_thickness/2);
        translate([5,15 + shell_width_add + shell_depth_add,0])cylinder(shell_height, shell_thickness/2, shell_thickness/2);
    }

    // floor
    translate([-50, 0, 0])cube([50,12.5,shell_thickness]);
    hull() {
        translate([-50 + (shell_thickness/2),12.5,0])cylinder(shell_thickness, shell_thickness/2, shell_thickness/2);
        translate([-50 + (shell_thickness/2) - shell_width_add,12.5 + shell_width_add,0])cylinder(shell_thickness, shell_thickness/2, shell_thickness/2);
        translate([0,12.5,0])cylinder(shell_thickness, shell_thickness/2, shell_thickness/2);
        translate([0,12.5 + shell_width_add,0])cylinder(shell_thickness, shell_thickness/2, shell_thickness/2);
    }
    translate([-50 - shell_width_add, 12.5 + shell_width_add, 0])cube([50 + shell_width_add,2.5 + shell_depth_add - shell_width_add,shell_thickness]);
    hull() {
        translate([-50 + (shell_thickness/2),15 + shell_width_add + shell_depth_add,0])cylinder(shell_thickness, shell_thickness/2, shell_thickness/2);
        translate([-50 + (shell_thickness/2) - shell_width_add,15 + shell_depth_add,0])cylinder(shell_thickness, shell_thickness/2, shell_thickness/2);
        translate([0,15 + shell_width_add + shell_depth_add,0])cylinder(shell_thickness, shell_thickness/2, shell_thickness/2);
        translate([0,15 + shell_depth_add,0])cylinder(shell_thickness, shell_thickness/2, shell_thickness/2);
    }

}


optical_elements_back_dist = 32.5;

difference(){
    union() {
        translate([ifd/2,0,0])flange();
        translate([-ifd/2,0,0])flange();
        translate([-10,0,0])cube([20,shell_thickness,shell_height]);




        translate([-50 - shell_width_add,40,0])asymmetric_bolt_post();
        translate([50 + shell_width_add,40,0])rotate([0,0,180])asymmetric_bolt_post();
        translate([0,0,0])rotate([0,0,90])asymmetric_bolt_post();

        shell_half();
        mirror([1,0,0])shell_half();

        //translate([30,25,0])cylinder(2.5,5,5);
        //translate([30,45,0])cylinder(2.5,5,5);
        //translate([-30,25,0])cylinder(2.5,5,5);
        //translate([-30,45,0])cylinder(2.5,5,5);

        // mirror mount
        translate([ifd/2,optical_elements_back_dist,0]){
            rotate([0,0,45]){
                translate([10,0,0])cylinder(6,5,5);
                translate([-10,0,0])cylinder(6,5,5);
            }
        }

        // lens mount
        translate([-5,optical_elements_back_dist,0]){
            translate([10,0,0])cylinder(6,5,5);
            translate([-10,0,0])cylinder(6,5,5);
        }

        // lamp mount
        translate([-35,optical_elements_back_dist,0]){
            translate([10,0,0])cylinder(6,5,5);
            translate([-10,0,0])cylinder(6,5,5);
        }
    }

    translate([ifd/2,0,0])flange_holes();
    translate([-ifd/2,0,0])translate([0,5,-1])cylinder(shell_thread_hole_thickness + 2, sh_thread/2, sh_thread/2);


    translate([-50 - shell_width_add,40,0])asymmetric_bolt_post_cs();
    translate([50 + shell_width_add,40,0])rotate([0,0,180])asymmetric_bolt_post_cs();
    translate([0,0,0])rotate([0,0,90])asymmetric_bolt_post_cs();


    // mirror mount
    translate([ifd/2,optical_elements_back_dist,0]){
        rotate([0,0,45]){
            translate([-10/2,-45/2,-1])cube([10,45,100]);
            translate([10,0,0])thread_cyl();
            translate([-10,0,0])thread_cyl();
        }
    }

    // lens mount
    translate([-5,optical_elements_back_dist,0]){
        translate([-10/2,-40/2,-1])cube([10,40,100]);
        translate([10,0,0])thread_cyl();
        translate([-10,0,0])thread_cyl();
    }

    // lamp mount
    translate([-35,optical_elements_back_dist,0]){
        translate([-10/2,-30/2,-1])cube([10,30,100]);
        translate([10,0,0])thread_cyl();
        translate([-10,0,0])thread_cyl();
    }

    //translate([30,25,0])countersink_cyl();
    //translate([30,45,0])countersink_cyl();
    //translate([-30,25,0])countersink_cyl();
    //translate([-30,45,0])countersink_cyl();
}