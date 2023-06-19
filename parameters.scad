$fn = 50;
bolt = "M4";

leg_hinge_pin_bolt = "M8";

tight_fit = 0.1;
fit = 0.2;

// Edge of the aluminium extrusion you're using as a launch rail:
leg_d = 20;
// Thickness of walls:
t = 3;

leg_hinge_mount_prongs = 2;
// How much of the extrusion to hold onto for the leg:
leg_hold_h = 3 / 4 * leg_d;
leg_hinge_clearance = leg_d / 4 + fit;

// Increase leg hinge mount's overall strength by rotating it a little.
layer_adhesion_rot = 7.5;
