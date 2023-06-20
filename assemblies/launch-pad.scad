include <../parameters.scad>
use <../v-slot/v-slot.scad>
use <legs.scad>

e = 0;
rail_l = 1000;
legs_l = 300;
stand_z = 250;

module launch_pad_assembly (e = 0, legs_l = 300) {
  leg_assembly(rail_l);
  translate([ 0, 0, stand_z ]) legs_assembly(e, legs_l);
}

launch_pad_assembly(e, legs_l);
