include <parameters.scad>
use <leg-mount-pin.scad>
use <catchnhole/catchnhole.scad>

module leg_mount (fit = tight_fit) {
  leg_d_fit = leg_d + tight_fit;
  d = leg_d_fit + 2 * t;
  h = leg_hold_h + t;

  slots = leg_mount_pins + 1;
  pin_w = d / (slots + leg_mount_pins);

  difference () {
    union () {
      translate([-d / 2, -d / 2])
        cube([d, d, leg_hold_h + t]);

      translate([0, -d / 2, leg_hold_h + t]) 
        for (i = [1 : leg_mount_pins]) {
          translate([0, (2 * i - 1) * pin_w + fit / 2]) rotate([90, 0, 180]) linear_extrude(pin_w - fit)
            leg_mount_pin_2d(leg_mount_pin_clearance);
        }
    }

    translate([-leg_d_fit / 2, -leg_d_fit / 2])
      cube([leg_d_fit, leg_d_fit, leg_hold_h]);

    for (side = [0, 1]) mirror([side, 0])
      translate([d / 2 - t, 0, leg_hold_h / 2]) rotate([0, 90]) bolt(bolt, length = t);
  }
}

leg_mount();
