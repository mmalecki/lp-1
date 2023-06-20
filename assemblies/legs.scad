include <../parameters.scad>
use <../leg-foot.scad>
use <../leg-hinge-mount.scad>
use <../leg-hinge.scad>
use <../stand-center.scad>
use <../v-slot/v-slot.scad>

module leg_assembly (l) {
  color("silver") v_slot(l);
  translate([ 0, 0, leg_hold_h ]) mirror([ 0, 0, 1 ]) leg_pad();
}

module legs_assembly (e = 0, legs_l = 300) {
  stand_center();

  pin_bolt_offset = leg_hinge_pin_offset(leg_hinge_clearance);

  stand_center_to_legs() {
    rotate([ 0, -0, 0 ])
      translate([ pin_bolt_offset, 0, -leg_hold_h - t - pin_bolt_offset ]) {
      leg_hinge_mount();
      translate([ 0, 0, -legs_l ]) leg_assembly(legs_l);
    }
  }
}

legs_assembly();
