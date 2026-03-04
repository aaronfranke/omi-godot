class_name TransformInheritor3D
extends Node3D


@export var position_amount := Vector3.ZERO
@export var position_rel_to: Node3D = null
@export var rotation_amount := Basis.IDENTITY
@export var rotation_rel_to: Node3D = null
@export var scale_amount := Vector3.ONE
@export var scale_rel_to: Node3D = null


func _ready() -> void:
	if position_rel_to == null:
		position_amount = position
	else:
		position_amount = position_rel_to.to_local(global_position)
	if rotation_rel_to == null:
		rotation_amount = quaternion
	else:
		var to_local: Basis = rotation_rel_to.global_basis.orthonormalized().transposed()
		rotation_amount = to_local * global_basis.orthonormalized()
	if scale_rel_to == null:
		scale_amount = scale
	else:
		var to_local: Basis = scale_rel_to.global_basis.inverse()
		scale_amount = (to_local * global_basis).get_scale()
	top_level = true


func _process(delta: float) -> void:
	var pos_node: Node3D = position_rel_to if position_rel_to != null else get_parent()
	var rot_node: Node3D = rotation_rel_to if rotation_rel_to != null else get_parent()
	var scl_node: Node3D = scale_rel_to if scale_rel_to != null else get_parent()
	position = pos_node.to_global(position_amount)
	basis = rot_node.global_basis.orthonormalized() * rotation_amount
	scale = (scl_node.global_basis * Basis.from_scale(scale_amount)).get_scale()
