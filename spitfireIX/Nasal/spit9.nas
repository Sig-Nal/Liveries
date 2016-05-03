


#var main_loop = func {

#}

#setlistener("/sim/signals/fdm-initialized",main_loop);

var flaps = func (dir) {
  if (dir == 1 and getprop ("controls/flight/flaps") == 0 ) {
  setprop ("controls/flight/flaps", 1 );
  }
  if (dir == 0 and getprop ("controls/flight/flaps") != 0 ) {
  setprop ("controls/flight/flaps", 0 );
  }
}

aircraft.steering.init();

aircraft.livery.init("Aircraft/spitfireIX/Models/Liveries", "sim/model/livery/name");

var door = aircraft.door.new ("/controls/doors/door/",1.5);

var canopy = aircraft.door.new ("/controls/doors/canopy/",1.5);

var logo_dialog = gui.OverlaySelector.new("Select Logo", "Aircraft/Generic/Logos", "sim/model/logo/name", nil, "sim/multiplay/generic/string");

var config = gui.Dialog.new("/sim/gui/dialogs/appearance/dialog", "Aircraft/spitfireIX/Dialogs/config.xml");
var payload = gui.Dialog.new("/sim/gui/dialogs/payload/dialog", "Aircraft/spitfireIX/Dialogs/payload.xml");

var save_list = ["/combat/enabled",
                "/controls/gear/tailwheel-steerable"];
aircraft.data.add(save_list);


