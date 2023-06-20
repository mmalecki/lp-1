include <parameters.scad>;
use <catchnhole/catchnhole.scad>

module leg_pad (leg_d = 20, leg_hold_h = 15, t = 3, pad_d = 29) {
  leg_d_fit = leg_d + tight_fit;
  d = 2 * t + leg_d_fit;
  difference() {
    hull() {
      translate([ -d / 2, -d / 2, 0 ]) cube([ d, d, leg_hold_h ]);
      translate([ 0, 0, leg_hold_h ]) sphere(d = pad_d);
    }
    translate([ -leg_d_fit / 2, -leg_d_fit / 2, 0 ])
      cube([ leg_d_fit, leg_d_fit, leg_hold_h ]);

    for (side = [ 0, 1 ])
      mirror([ side, 0 ]) translate([ d / 2 - t, 0, leg_hold_h / 2 ]) rotate([ 0, 90 ])
        bolt(bolt, length = t, kind = "socket_head");
  }
}

leg_pad(leg_d, leg_hold_h, t);
