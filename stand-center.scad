include <parameters.scad>
use <catchnhole/catchnhole.scad>
use <leg-hinge.scad>

module stand_center_leg_hinge() {
  d = leg_d + 2 * t;
  leg_d_fit = leg_d + tight_fit;
  // Ugly hack depending on later difference against the extrusion:
  pin_base_inset = d / 2;
  pin_base_t = pin_base_inset + leg_hinge_clearance;
  bolt_d = bolt_diameter(leg_hinge_pin_bolt);
  nut_kind = "hexagon_thin";
  nut_h = nut_height(leg_hinge_pin_bolt, nut_kind);

  slots = leg_hinge_mount_prongs + 1;
  prong_w = d / (slots + leg_hinge_mount_prongs);

  union() {
    translate([ 0, -d / 2 ]) for (i = [1:slots]) {
      translate([ 0, 2 * (i - 1) * prong_w, -pin_base_inset ]) rotate([ 90, 0, 180 ]) {
        difference() {
          linear_extrude(prong_w) leg_hinge_2d(pin_base_t);
          if (i == 1) {
            translate([ 0, 0, -nut_h / 2 ]) leg_hinge_to_pin(pin_base_t)
              nutcatch_parallel(leg_hinge_pin_bolt, kind = nut_kind);
          }
        }
      }
    }
  }
}

module stand_center_to_leg_hinge() {
  leg_d_fit = leg_d + tight_fit;
  translate([ sqrt(2) * leg_d_fit / 2 + t / 2, 0, 0 ]) children();
}

module stand_center(legs = 3, t = 3) {
  leg_d_fit = leg_d + tight_fit;
  // Circumscribed circle around the extrusion:
  cd = sqrt(2) * leg_d_fit;
  d = cd + 2 * t;
  h = leg_d + 2 * t;
  base_w = leg_d_fit + 2 * t;

  step = 360 / legs;

  difference() {
    union() {
      translate([ 0, 0, -h / 2 ]) cylinder(d = d, h = h);
      for (mount = [1:legs]) {
        rotate([ 0, 0, step * mount ]) {
          stand_center_to_leg_hinge() rotate([ 0, 90 ]) stand_center_leg_hinge();
        }
      }
    }

    cube([ leg_d_fit, leg_d_fit, h ], center = true);
    rotate([ 0, 0, 180 ]) translate([ leg_d_fit / 2, 0 ]) rotate([ 0, 90, 0 ])
      bolt(bolt, length = (d - leg_d_fit) / 2, countersink = 0.1, kind = "socket_head");
  }
}

stanenter();
