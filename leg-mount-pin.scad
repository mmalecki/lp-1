use <catchnhole/catchnhole.scad>
include <parameters.scad>

function leg_mount_pin_bolt_offset (base_t = t) = t + base_t + (leg_d + 2 * t) / 4;

module leg_mount_pin_2d (base_t = t, fit = 0) {
  d = leg_d + 2 * t;
  bolt_offset = leg_mount_pin_bolt_offset(base_t);
  difference () {
    hull () {
      translate([-d / 2, 0]) square([d, base_t]);
      // Move the circle a t down to avoid creating huge parts.
      translate([0, bolt_offset - t]) circle(d = d - fit);
    }
    translate([d / 2, 0]) rotate([0, 0, 180]) square([d, d]);
    leg_mount_pin_to_bolt(base_t) bolt_2d(leg_mount_bolt);
  }
}

module leg_mount_pin_to_bolt (base_t = t) {
  translate([0, leg_mount_pin_bolt_offset(base_t)]) children();
}

leg_mount_pin_2d();
