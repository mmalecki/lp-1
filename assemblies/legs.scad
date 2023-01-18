use <../leg-mount.scad>
use <../leg-rail-mount.scad>
use <../leg-mount-pin.scad>
include <../parameters.scad>

module legs_assembly () {
  leg_rail_mount();

  pin_bolt_offset = leg_mount_pin_bolt_offset(leg_mount_pin_clearance);
  translate([pin_bolt_offset, 0, -leg_hold_h - t - pin_bolt_offset])
    leg_rail_mount_to_leg_mount() 
       leg_mount();
}

legs_assembly();
