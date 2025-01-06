@tool
class_name GLTFEnvironmentSky
extends Resource


var ambient_color := Color.BLACK
var ambient_sky_contribution: float = 1.0
var type: String

var panorama_cubemap_indices := PackedInt32Array()
var panorama_cubemap_textures: Array[Texture2D] = []
var panorama_equirectangular_index: int = -1
var panorama_equirectangular_texture: Texture2D = null

var physical_ground_color := Color(0.3, 0.2, 0.1)
var physical_mie_color := Color.WHITE
var physical_mie_scale: float = 0.000005
var physical_mie_anisotropy: float = 0.8
var physical_rayleigh_color := Color(0.3, 0.5, 1.0)
var physical_rayleigh_scale: float = 0.00003

var procedural_bottom_color := Color(0.2, 0.169, 0.133)
var procedural_bottom_curve: float = 0.02
var procedural_horizon_color := Color(0.646, 0.656, 0.671)
var procedural_top_color := Color(0.385, 0.454, 0.55)
var procedural_top_curve: float = 0.15
var procedural_sun_angle_max: float = 0.5
var procedural_sun_curve: float = 0.15


static func from_dictionary(dict: Dictionary) -> GLTFEnvironmentSky:
	var ret := GLTFEnvironmentSky.new()
	if dict.has("type"):
		ret.type = dict["type"]
	else:
		printerr("GLTFEnvironmentSky: Missing required field 'type'.")
	if dict.has("ambientColor"):
		var ambient_color: Array = dict["ambientColor"]
		ret.ambient_color = Color(ambient_color[0], ambient_color[1], ambient_color[2])
	if dict.has("ambientSkyContribution"):
		ret.ambient_sky_contribution = dict["ambientSkyContribution"]
	if dict.has("panorama"):
		var panorama: Dictionary = dict["panorama"]
		if panorama.has("cubemap"):
			var cubemap_indices: Array = panorama["cubemap"]
			ret.panorama_cubemap_indices.resize(cubemap_indices.size())
			ret.panorama_cubemap_textures.resize(cubemap_indices.size())
			for i in range(cubemap_indices.size()):
				ret.panorama_cubemap_indices.set(i, cubemap_indices[i])
		if panorama.has("equirectangular"):
			ret.panorama_equirectangular_index = panorama["equirectangular"]
	if dict.has("physical"):
		var physical: Dictionary = dict["physical"]
		if physical.has("groundColor"):
			var ground_color: Array = physical["groundColor"]
			ret.physical_ground_color = Color(ground_color[0], ground_color[1], ground_color[2])
		if physical.has("mieAnisotropy"):
			ret.physical_mie_anisotropy = physical["mieAnisotropy"]
		if physical.has("mieColor"):
			var mie_color: Array = physical["mieColor"]
			ret.physical_mie_color = Color(mie_color[0], mie_color[1], mie_color[2])
		if physical.has("mieScale"):
			ret.physical_mie_scale = physical["mieScale"]
		if physical.has("rayleighColor"):
			var rayleigh_color: Array = physical["rayleighColor"]
			ret.physical_rayleigh_color = Color(rayleigh_color[0], rayleigh_color[1], rayleigh_color[2])
		if physical.has("rayleighScale"):
			ret.physical_rayleigh_scale = physical["rayleighScale"]
	if dict.has("procedural"):
		var procedural: Dictionary = dict["procedural"]
		if procedural.has("bottomColor"):
			var bottom_color: Array = procedural["bottomColor"]
			ret.procedural_bottom_color = Color(bottom_color[0], bottom_color[1], bottom_color[2])
		if procedural.has("bottomCurve"):
			ret.procedural_bottom_curve = procedural["bottomCurve"]
		if procedural.has("horizonColor"):
			var horizon_color: Array = procedural["horizonColor"]
			ret.procedural_horizon_color = Color(horizon_color[0], horizon_color[1], horizon_color[2])
		if procedural.has("topColor"):
			var top_color: Array = procedural["topColor"]
			ret.procedural_top_color = Color(top_color[0], top_color[1], top_color[2])
		if procedural.has("topCurve"):
			ret.procedural_top_curve = procedural["topCurve"]
		if procedural.has("sunAngleMax"):
			ret.procedural_sun_angle_max = procedural["sunAngleMax"]
		if procedural.has("sunCurve"):
			ret.procedural_sun_curve = procedural["sunCurve"]
	return ret


func to_dictionary() -> Dictionary:
	var ret: Dictionary = {
		"type": type,
	}
	if ambient_color != Color.BLACK:
		ret["ambientColor"] = [ambient_color.r, ambient_color.g, ambient_color.b]
	if ambient_sky_contribution != 1.0:
		ret["ambientSkyContribution"] = ambient_sky_contribution
	match type:
		"panorama":
			var panorama: Dictionary = {}
			if panorama_cubemap_indices.size() > 0:
				panorama["cubemap"] = panorama_cubemap_indices
			if panorama_equirectangular_index != -1:
				panorama["equirectangular"] = panorama_equirectangular_index
			ret["panorama"] = panorama
		"physical":
			var physical: Dictionary = {}
			if physical_ground_color != Color(0.3, 0.2, 0.1):
				physical["groundColor"] = [physical_ground_color.r, physical_ground_color.g, physical_ground_color.b]
			if physical_mie_anisotropy != 0.8:
				physical["mieAnisotropy"] = physical_mie_anisotropy
			if physical_mie_color != Color.WHITE:
				physical["mieColor"] = [physical_mie_color.r, physical_mie_color.g, physical_mie_color.b]
			if physical_mie_scale != 0.000005:
				physical["mieScale"] = physical_mie_scale
			if physical_rayleigh_color != Color(0.3, 0.5, 1.0):
				physical["rayleighColor"] = [physical_rayleigh_color.r, physical_rayleigh_color.g, physical_rayleigh_color.b]
			if physical_rayleigh_scale != 0.00003:
				physical["rayleighScale"] = physical_rayleigh_scale
			ret["physical"] = physical
		"procedural":
			var procedural = {
				"bottomColor": [procedural_bottom_color.r, procedural_bottom_color.g, procedural_bottom_color.b],
				"horizonColor": [procedural_horizon_color.r, procedural_horizon_color.g, procedural_horizon_color.b],
				"topColor": [procedural_top_color.r, procedural_top_color.g, procedural_top_color.b],
			}
			if procedural_bottom_curve != 0.02:
				procedural["bottomCurve"] = procedural_bottom_curve
			if procedural_top_curve != 0.15:
				procedural["topCurve"] = procedural_top_curve
			if procedural_sun_angle_max != 0.5:
				procedural["sunAngleMax"] = procedural_sun_angle_max
			if procedural_sun_curve != 0.15:
				procedural["sunCurve"] = procedural_sun_curve
			var engine_version: Dictionary = Engine.get_version_info()
			if not (engine_version["major"] == 4 and engine_version["minor"] < 4):
				# HACK: Godot 4.3 and earlier does not have sort().
				procedural.sort()
			ret["procedural"] = procedural
	return ret


static func from_environment(env: Environment) -> GLTFEnvironmentSky:
	var ret := GLTFEnvironmentSky.new()
	ret.ambient_color = env.ambient_light_color
	ret.ambient_sky_contribution = env.ambient_light_sky_contribution
	var sky: Sky = env.sky
	if sky == null:
		return ret
	var sky_material: Material = sky.sky_material
	if sky_material is PanoramaSkyMaterial:
		ret.type = "panorama"
		var panorama_sky: PanoramaSkyMaterial = sky_material
		if panorama_sky.panorama != null and panorama_sky.panorama.resource_name.is_empty():
			panorama_sky.panorama.resource_name = panorama_sky.panorama.resource_path.get_file().get_basename()
		ret.panorama_equirectangular_texture = panorama_sky.panorama
	elif sky_material is PhysicalSkyMaterial:
		ret.type = "physical"
		var physical_sky: PhysicalSkyMaterial = sky_material
		ret.physical_ground_color = physical_sky.ground_color
		ret.physical_mie_anisotropy = physical_sky.mie_eccentricity
		ret.physical_mie_color = physical_sky.mie_color
		ret.physical_mie_scale = physical_sky.mie_coefficient / 1000
		ret.physical_rayleigh_color = physical_sky.rayleigh_color
		ret.physical_rayleigh_scale = physical_sky.rayleigh_coefficient / 100000
	elif sky_material is ProceduralSkyMaterial:
		ret.type = "procedural"
		var procedural_sky: ProceduralSkyMaterial = sky_material
		ret.procedural_bottom_color = procedural_sky.ground_bottom_color
		ret.procedural_bottom_curve = procedural_sky.ground_curve
		ret.procedural_horizon_color = procedural_sky.ground_horizon_color
		ret.procedural_top_color = procedural_sky.sky_top_color
		ret.procedural_top_curve = procedural_sky.sky_curve
		ret.procedural_sun_angle_max = deg_to_rad(procedural_sky.sun_angle_max)
		ret.procedural_sun_curve = procedural_sky.sun_curve
	return ret


func to_environment() -> Environment:
	var ret := Environment.new()
	# Set up the environment with the defaults from the editor environment.
	ret.background_mode = Environment.BG_SKY
	ret.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	ret.glow_enabled = true
	# Set up the environment with the sky settings from this environment.
	ret.ambient_light_color = ambient_color
	ret.ambient_light_sky_contribution = ambient_sky_contribution
	var sky := Sky.new()
	match type:
		"panorama":
			var panorama_sky := PanoramaSkyMaterial.new()
			panorama_sky.panorama = panorama_equirectangular_texture
			sky.sky_material = panorama_sky
		"physical":
			var physical_sky := PhysicalSkyMaterial.new()
			physical_sky.ground_color = physical_ground_color
			physical_sky.mie_eccentricity = physical_mie_anisotropy
			physical_sky.mie_color = physical_mie_color
			physical_sky.mie_coefficient = physical_mie_scale * 1000
			physical_sky.rayleigh_color = physical_rayleigh_color
			physical_sky.rayleigh_coefficient = physical_rayleigh_scale * 100000
			sky.sky_material = physical_sky
		"procedural":
			var procedural_sky := ProceduralSkyMaterial.new()
			procedural_sky.ground_bottom_color = procedural_bottom_color
			procedural_sky.ground_curve = procedural_bottom_curve
			procedural_sky.ground_horizon_color = procedural_horizon_color
			procedural_sky.sky_horizon_color = procedural_horizon_color
			procedural_sky.sky_top_color = procedural_top_color
			procedural_sky.sky_curve = procedural_top_curve
			procedural_sky.sun_angle_max = rad_to_deg(procedural_sun_angle_max)
			procedural_sky.sun_curve = procedural_sun_curve
			sky.sky_material = procedural_sky
	ret.sky = sky
	return ret


static func from_node(node: WorldEnvironment) -> GLTFEnvironmentSky:
	if node != null and node.environment != null:
		return from_environment(node.environment)
	return null


func to_node() -> Node:
	var world_env := WorldEnvironment.new()
	world_env.name = &"WorldEnvironment"
	world_env.environment = to_environment()
	if panorama_cubemap_textures.size() >= 6:
		var cubemap_mi: CubemapSky3D = _make_cubemap_mesh()
		cubemap_mi.set_skybox_textures(panorama_cubemap_textures)
		cubemap_mi.add_child(world_env)
		return cubemap_mi
	return world_env


func _make_cubemap_mesh() -> CubemapSky3D:
	var mesh_instance := CubemapSky3D.new()
	mesh_instance.name = &"CubemapSky3D"
	return mesh_instance
