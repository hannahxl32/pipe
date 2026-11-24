$fa=1;
$fs=0.5;

sh_through = 4;
sh_countersink = 3;
sh_thread = 4.5; // 2.7 for tapping, 4.5 for brass insert

shell_thickness = 2;

grow_prop = sqrt(2);

slop_adjust = 0.5;

tube_diameter = 147;

on_tube_dia = (tube_diameter / 2) - (slop_adjust * 2) - (shell_thickness/2);

support_angle = 30;

inner_box_width = 130;
inner_box_height = 80;

top_bottom_bolt_bump_dist = 80;

circle_truncation_width = sqrt((((tube_diameter/2) - shell_thickness - (slop_adjust))^2) - ((inner_box_width/2)^2)) * 2;
circle_top_truncation_width = sqrt((((tube_diameter/2) - shell_thickness - (slop_adjust))^2) - ((inner_box_height/2)^2)) * 2;

module bolt_bump(){
    hull() {
        translate([-10/2,0,0])cube([10,5,10]);
        translate([-(20)/2,0,0])cube([20,0.1,10]);
    }
}

module countersink_cyl() {
    hull () {
        translate([0,0,-30])cylinder(1, (sh_countersink-1) + (sh_through/2), (sh_countersink-1) + (sh_through/2));
        translate([0,0,-1])cylinder(sh_countersink, (sh_countersink-1) + (sh_through/2), sh_through/2);
    }

    translate([0,0,0])cylinder(30, sh_through/2, sh_through/2);
}

difference(){
    union() {
        // main cylinder
        difference() {
            cylinder(10,(tube_diameter/2-slop_adjust),(tube_diameter/2-slop_adjust));
            
            // remove side bits
            translate([0,0,-1])cylinder(12,(tube_diameter/2-slop_adjust)-shell_thickness,(tube_diameter/2-slop_adjust)-shell_thickness);
            translate([-200/2,-circle_truncation_width/2,-1])cube([200,circle_truncation_width,12]);
            translate([(inner_box_width/2) + shell_thickness,-100,-1])cube([200,200,12]);
            translate([-(inner_box_width/2) - shell_thickness - 200,-100,-1])cube([200,200,12]);
            
            // remove top and bottom bits
            translate([0,0,-1])cylinder(12,(tube_diameter/2-slop_adjust)-shell_thickness,(tube_diameter/2-slop_adjust)-shell_thickness);
            translate([-circle_top_truncation_width/2,-200/2,-1])cube([circle_top_truncation_width,200,12]);
            translate([-100, (inner_box_height/2) + shell_thickness,-1])cube([200,200,12]);
            translate([-100,-(inner_box_height/2) - shell_thickness - 200,-1])cube([200,200,12]);
        }
        
        
        translate([-inner_box_width/2-shell_thickness,-circle_truncation_width/2,0])cube([shell_thickness,circle_truncation_width,10]);
        translate([(-inner_box_width)/2,15,0])rotate([0,0,90])bolt_bump();
        translate([(-inner_box_width)/2,-15,0])rotate([0,0,90])bolt_bump();
        translate([inner_box_width/2,-circle_truncation_width/2,0])cube([shell_thickness,circle_truncation_width,10]);
        translate([(inner_box_width)/2,15,0])rotate([0,0,-90])bolt_bump();
        translate([(inner_box_width)/2,-15,0])rotate([0,0,-90])bolt_bump();
        
        
        translate([-circle_top_truncation_width/2,-inner_box_height/2-shell_thickness,0])cube([circle_top_truncation_width,shell_thickness,10]);
        translate([(top_bottom_bolt_bump_dist/2),(-inner_box_height)/2 - shell_thickness,0])rotate([0,0,0])bolt_bump();
        translate([-(top_bottom_bolt_bump_dist/2),(-inner_box_height)/2 - shell_thickness,0])rotate([0,0,0])bolt_bump();
        translate([-circle_top_truncation_width/2,inner_box_height/2,0])cube([circle_top_truncation_width,shell_thickness,10]);
        translate([(top_bottom_bolt_bump_dist/2),(inner_box_height)/2 + shell_thickness,0])rotate([0,0,180])bolt_bump();
        translate([-(top_bottom_bolt_bump_dist/2),(inner_box_height)/2 + shell_thickness,0])rotate([0,0,180])bolt_bump();
    }

    // Holes for side mounts
    translate([(inner_box_width+8)/2,15,5])rotate([-90,0,90])countersink_cyl();
    translate([(inner_box_width+8)/2,-15,5])rotate([-90,0,90])countersink_cyl();
    translate([(-inner_box_width-8)/2,15,5])rotate([-90,0,-90])countersink_cyl();
    translate([(-inner_box_width-8)/2,-15,5])rotate([-90,0,-90])countersink_cyl();


    translate([top_bottom_bolt_bump_dist/2,-tube_diameter/2,5])rotate([-90,0,0])cylinder(tube_diameter,sh_thread/2,sh_thread/2);
    translate([-top_bottom_bolt_bump_dist/2,-tube_diameter/2,5])rotate([-90,0,0])cylinder(tube_diameter,sh_thread/2,sh_thread/2);


}

