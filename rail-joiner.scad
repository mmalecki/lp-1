include <parameters.scad>
use <catchnhole/catchnhole.scad>

module rail_joiner_side_2d(l, t, rail_d, bolt) {
  difference() {
    translate([ -l / 2, -t - rail_d / 2 ]) square([ l, t + (rail_d * 3/4) ]);
    translate([ -l / 4, 0 ]) bolt_2d(bolt);
    translate([ +l / 4, 0 ]) bolt_2d(bolt);
  }
}

module rail_joiner(l = 40, t = 4, rail_d = 20, bolt) {
  w = rail_d + 2 * t;
  difference() {
    rotate([ 0, 90, 0 ])
      translate([ 0, 0, -w / 2 ])
        linear_extrude(w)
          rail_joiner_side_2d(l = l, t = t, rail_d = rail_d, bolt);

    cube([rail_d, rail_d, l], center = true);
  }
}

rail_joiner(l = 40, t = 4, rail_d = 20, bolt = "M4");
