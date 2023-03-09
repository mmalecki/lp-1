include <parameters.scad>
use <catchnhole/catchnhole.scad>

function leg_hinge_pin_offset(base_t = t) = t + base_t + (leg_d + 2 * t) / 4;

module leg_hinge_2d(base_t = t, fit = 0) {
  d = leg_d + 2 * t;
  bolt_offset = leg_hinge_pin_offset(base_t);
  difference() {
    hull() {
      translate([ -d / 2, 0 ]) square([ d, base_t ]);
      // Move the circle a t down to avoid creating huge parts.
      translate([ 0, bolt_offset - t ]) circle(d = d - fit);
    }
    translate([ d / 2, 0 ]) rotate([ 0, 0, 180 ]) square([ d, d ]);
    leg_hinge_to_pin(base_t) bolt_2d(leg_hinge_pin_bolt);
  }
}

module leg_hinge_to_pin(base_t = t) {
  translate([ 0, leg_hinge_pin_offset(base_t) ]) children();
}

leg_hinge_2d();
