@tool
class_name GLTFVehicleWheel
extends Resource


var radius: float = 0.25
var suspension_stiffness: float = 40.0
var suspension_travel: float = 0.25
var use_for_steering: bool = true
var use_for_traction: bool = true


static func from_node(wheel_node: VehicleWheel3D) -> GLTFVehicleWheel:
	var ret := GLTFVehicleWheel.new()
	ret.radius = wheel_node.wheel_radius
	ret.suspension_stiffness = wheel_node.suspension_stiffness
	ret.suspension_travel = wheel_node.suspension_travel
	ret.use_for_steering = wheel_node.use_as_steering
	ret.use_for_traction = wheel_node.use_as_traction
	return ret


func to_node() -> VehicleWheel3D:
	var ret := VehicleWheel3D.new()
	ret.wheel_radius = radius
	ret.suspension_travel = suspension_travel
	ret.suspension_stiffness = suspension_stiffness
	ret.use_as_steering = use_for_steering
	ret.use_as_traction = use_for_traction
	return ret


static func from_dictionary(dict: Dictionary) -> GLTFVehicleWheel:
	var ret := GLTFVehicleWheel.new()
	if dict.has("radius"):
		ret.radius = dict["radius"]
	if dict.has("suspensionStiffness"):
		ret.suspension_stiffness = dict["suspensionStiffness"]
	if dict.has("suspensionTravel"):
		ret.suspension_travel = dict["suspensionTravel"]
	if dict.has("useForSteering"):
		ret.use_for_steering = dict["useForSteering"]
	if dict.has("useForTraction"):
		ret.use_for_traction = dict["useForTraction"]
	return ret


func to_dictionary() -> Dictionary:
	var ret: Dictionary = {}
	if radius != 0.25:
		ret["radius"] = radius
	if suspension_stiffness != 40.0:
		ret["suspensionStiffness"] = suspension_stiffness
	if suspension_travel != 0.25:
		ret["suspensionTravel"] = suspension_travel
	if use_for_steering != true:
		ret["useForSteering"] = use_for_steering
	if use_for_traction != true:
		ret["useForTraction"] = use_for_traction
	return ret