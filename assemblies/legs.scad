include <../parameters.scad>
use <../leg-hinge-mount.scad>
use <../leg-hinge.scad>
use <../stand-center.scad>

module legs_assembly() {
  stand_center();

  pin_bolt_offset = leg_hinge_pin_offset(leg_hinge_clearance);

  translate([ pin_bolt_offset, 0, -leg_hold_h - t - pin_bolt_offset ])
    stand_center_to_leg_hinge()
    // Due to its origin, this cannot be rotated easily. Let's skip this for now -
    // the "default" position is the trickiest in this mating anyway.
    leg_hinge_mount();
}

legs_assembly();
