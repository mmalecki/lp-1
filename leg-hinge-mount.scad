include <parameters.scad>
use <catchnhole/catchnhole.scad>
use <leg-hinge.scad>

module leg_hinge_mount (fit = tight_fit) {
  leg_d_fit = leg_d + tight_fit;
  d = leg_d_fit + 2 * t;
  h = leg_hold_h + t;
  adh_add = d * tan(layer_adhesion_rot);
  adh_hyp = layer_adhesion_rot != 0 ? adh_add / sin(layer_adhesion_rot) : 0;
  base_h = leg_hold_h + t + adh_add;

  slots = leg_hinge_mount_prongs + 1;
  pin_w = d / (slots + leg_hinge_mount_prongs);

  translate([ 0, 0, -adh_add ]) {
    difference() {
      union() {
        translate([ -d / 2, -d / 2 ]) {
          difference() {
            cube([ d, d, base_h ]);
            translate([ 0, 0, -adh_add ]) rotate([ 0, -layer_adhesion_rot ])
              translate([ 2 * (adh_hyp - d), 0 ]) cube([ adh_hyp, d, adh_add ]);
          }
        }

        translate([ 0, -d / 2, base_h ]) for (i = [1:leg_hinge_mount_prongs]) {
          translate([ 0, (2 * i - 1) * pin_w + fit / 2 ]) rotate([ 90, 0, 180 ])
            linear_extrude(pin_w - fit) leg_hinge_2d(leg_hinge_clearance);
        }
      }

      translate([ -leg_d_fit / 2, -leg_d_fit / 2 ])
        cube([ leg_d_fit, leg_d_fit, leg_hold_h + adh_add ]);

      for (side = [ 0, 1 ])
        mirror([ 0, side ]) translate([ 0, d / 2 - t, leg_hold_h / 2 + adh_add / 2 ])
          rotate([ 90, 0, 180 ]) bolt(bolt, length = t);
    }
  }
}

leg_hinge_mount();
