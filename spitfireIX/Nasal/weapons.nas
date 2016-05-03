var masterarm = props.globals.getNode("controls/armament/master-arm");
var weapselected = props.globals.getNode ("sim/armament/weapon_selected");
var gun0 = props.globals.getNode("sim/armament/gun[0]/fire");
var gun1 = props.globals.getNode("sim/armament/gun[1]/fire");
var gun2 = props.globals.getNode("sim/armament/gun[2]/fire");
var gun3 = props.globals.getNode("sim/armament/gun[3]/fire");
# var tracergun0 = props.globals.getNode("controls/armament/gun[0]/tracer");
# var tracergun1 = props.globals.getNode("controls/armament/gun[1]/tracer");
# var tracerevery = 20;
#  var times0 = 49;
var cannon0 = props.globals.getNode("sim/armament/cannon[0]/fire");
var cannon1 = props.globals.getNode("sim/armament/cannon[1]/fire");
var statgun0 = props.globals.getNode("sim/armament/gun[0]/serviceable");
var statgun1 = props.globals.getNode("sim/armament/gun[1]/serviceable");
var statgun2 = props.globals.getNode("sim/armament/gun[2]/serviceable");
var statgun3 = props.globals.getNode("sim/armament/gun[3]/serviceable");
var statcannon0 = props.globals.getNode("sim/armament/cannon[0]/serviceable");
var statcannon1 = props.globals.getNode("sim/armament/cannon[1]/serviceable");

setlistener("/controls/armament/trigger", func(n) {
  var stat = n.getValue();
  if	( stat ) {
    if ( masterarm.getValue() )  {
      if (statgun0.getValue() == 1) {
        gun0.setValue (1);
      }
      if (statgun1.getValue() == 1) {
        gun1.setValue (1);
      }
      if (statgun2.getValue() == 1) {
        gun2.setValue (1);
      }
      if (statgun3.getValue() == 1) {
        gun3.setValue (1);
      }
    }
  } else {
    gun0.setValue (0);
    gun1.setValue (0);
    gun2.setValue (0);
    gun3.setValue (0);
  }
});

setlistener("/controls/armament/trigger1", func(n) {
  var stat = n.getValue();
  if 	( stat ) {
    if ( masterarm.getValue() )  {
      if (statcannon0.getValue() == 1) {
        cannon0.setValue (1);
      }
      if (statcannon1.getValue() == 1) {
        cannon1.setValue (1);
      }
    }
  } else {
    cannon0.setValue (0);
    cannon1.setValue (0);
  }
});

var drop_tank = func () {
  print ("dropping Tank");
  setprop ("sim/armament/pylon[1]/release_tank", 1);
  setprop ("sim/armament/pylon[1]/type", 1);
  setprop ("consumables/fuel/tank[1]/capacity-gal_us",0);
  setprop ("consumables/fuel/tank[1]/selected",0);
  setprop ("consumables/fuel/tank[0]/selected",1);
}

var drop_bomb = func () {
  print ("dropping bomb!");
  var packet = getprop ("sim/armament/bombpacket");
  var dropped = 0;
  var timed = getprop ("sim/armament/bombtrain");
  var single = getprop ("sim/armament/bombsingle");

  if ( getprop ("sim/armament/pylon[0]/type") == 2 or getprop ("sim/armament/pylon[0]/type") == 3 ) {
    setprop ("sim/armament/pylon[0]/type", 1);
    setprop ("sim/armament/pylon[0]/release_bomb", 1);
    setprop ("sim/weight[0]/weight-lb",0);
    dropped = dropped+1;
  }
  if ( getprop ("sim/armament/pylon[1]/type") == 5 or getprop ("sim/armament/pylon[1]/type") == 6 ) {
    setprop ("sim/armament/pylon[1]/type", 3);
    setprop ("sim/armament/pylon[1]/release_bomb", 1);
    setprop ("sim/weight[1]/weight-lb",0);
    dropped = dropped+1;
  }  
  if ( getprop ("sim/armament/pylon[2]/type") == 2 or getprop ("sim/armament/pylon[2]/type") == 3 ) {
    setprop ("sim/armament/pylon[2]/type", 1);
    setprop ("sim/armament/pylon[2]/release_bomb", 1);
    setprop ("sim/weight[2]/weight-lb",0);
    dropped = dropped+1;
  } 

  print (dropped);
  if (dropped != 0 and single == 0) { 
    settimer (drop_bomb, timed);
  } else {
    print ("no Bomb left!");
  }
}

setlistener("/controls/armament/trigger2", func(n) {
    var stat = n.getValue();
  if 	( stat ) {
    if ( masterarm.getValue() )  {
      if (weapselected.getValue() == 1 ) {
        drop_bomb();
      }
      if (weapselected.getValue() == 2 ) {
        drop_tank();
      }
      if (weapselected.getValue() == 3 ) {
        fire_rocket();
      }
  	#  	if (weapselected.getValue() == 4 ) {
  	#    	fire_sidewinder();
  	#  	}
  	}
  }
});

setlistener("/ai/submodels/submodel[1]/count", func(n) {
    var count = n.getValue();
  print ( count, " " , times0 * tracerevery);
  tracergun0.setValue(0);
  if (count <= times0 * tracerevery) {
    	print ("tracer at§" , count);
     tracergun0.setValue(1);
    	times0.setValue(times0 -1 );
  }
});

setlistener("sim/model/aircraft/impact/gun", func(n) {
    var impact = n.getValue();
    var solid = getprop(impact ~ "/material/solid");
    
    if (solid) {
#      var long = getprop(impact ~ "/impact/longitude-deg");    
#      var lat = getprop(impact ~ "/impact/latitude-deg");
  	setprop("sim/model/aircraft/impact/splash",0);
    }
  else {
  	setprop("sim/model/aircraft/impact/splash",1);
  }
  });


var cannonflash_trigger = props.globals.getNode("controls/armament/trigger1", 0);
aircraft.light.new("sim/model/cannon/flash", [0.03, 0.044], cannonflash_trigger);

var gunflash0_trigger = props.globals.getNode("controls/armament/trigger", 0);
aircraft.light.new("sim/model/gun0/flash", [0.02, 0.024], gunflash0_trigger);

var gunflash1_trigger = props.globals.getNode("controls/armament/trigger", 0);
aircraft.light.new("sim/model/gun1/flash", [0.025, 0.029], gunflash1_trigger);
