include <parameters.scad>
use <catchnhole/catchnhole.scad>
use <leg-mount.scad>
use <leg-mount-pin.scad>

module leg_rail_leg_mount () {
  d = leg_d + 2 * t;
  leg_d_fit = leg_d + tight_fit;
  // Ugly hack depending on later difference against the extrusion:
  pin_base_inset = d / 2;
  pin_base_t = pin_base_inset + leg_mount_pin_clearance;
  bolt_d = bolt_diameter(leg_mount_bolt);
  nut_kind = "hexagon_thin";
  nut_h = nut_height(leg_mount_bolt, nut_kind);

  slots = leg_mount_pins + 1;
  pin_w = d / (slots + leg_mount_pins);

  union () {
    translate([0, -d / 2])
      for (i = [1 : slots]) {
        translate([0, 2 * (i - 1) * pin_w, -pin_base_inset])
          rotate([90, 0, 180]) {
            difference () {
              linear_extrude(pin_w)
                leg_mount_pin_2d(pin_base_t);
              if (i == 1) {
                translate([0, 0, -nut_h / 2]) leg_mount_pin_to_bolt(pin_base_t)
                  nutcatch_parallel(leg_mount_bolt, kind = nut_kind);
              }
            }
          }
      }
  }
}

module leg_rail_mount_to_leg_mount () {
  leg_d_fit = leg_d + tight_fit;
  translate([sqrt(2) * leg_d_fit / 2 + t / 2, 0, 0])
    children();
}

module leg_rail_mount (mounts = 3, t = 3) {
  leg_d_fit = leg_d + tight_fit;
  // Circumscribed circle around the extrusion:
  cd = sqrt(2) * leg_d_fit;
  d = cd + 2 * t;
  h = leg_d + 2 * t;
  base_w = leg_d_fit + 2 * t;

  step = 360 / mounts;

  difference () {
    union () {
      translate([0, 0, -h / 2]) cylinder(d = d, h = h);
      for (mount = [1 : mounts]) {
        rotate([0, 0, step * mount]) {
          leg_rail_mount_to_leg_mount()
            rotate([0, 90]) leg_rail_leg_mount();
        }
      }
    }

    cube([leg_d_fit, leg_d_fit, h], center = true);
    rotate([0, 0, 180]) translate([leg_d_fit / 2, 0]) rotate([0, 90, 0])
      bolt(bolt, length = (d - leg_d_fit) / 2, countersink = 0.1, kind = "socket_head");
  }
}

leg_rail_mount();
