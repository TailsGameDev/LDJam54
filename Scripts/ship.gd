class_name Ship extends RigidBody2D

@export var x_position_offset = 15
@export var force_magnitude = 100
@export var gravity_magnitude = 100

var left
var right
var input_enabled

#var laser_scene = preload("res://scenes/laser.tscn")
# preloaded_scene.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	input_enabled = true

func _process(delta):
	self.left = Input.is_action_pressed("left")
	self.right = Input.is_action_pressed("right")

func _physics_process(delta):
	if (input_enabled):
		var force
		if left or right:
			force = global_transform.y.normalized()
		else:
			force = Vector2(0,0)

		var position = Vector2(0,0)
		var x_axis = global_transform.x.normalized()
		if left:
			position = position - (x_axis * x_position_offset)
		if right:
			position = position + (x_axis * x_position_offset)

		self.apply_force(force*force_magnitude,position)

	var gravity_direction = (Vector2(400,250) - self.position)
	self.apply_central_force(gravity_magnitude * gravity_direction)

func apply_external_force(force):
	self.apply_central_force(force)

func get_vel_length():
	return self.linear_velocity.length()

func enable_input(enable):
	self.input_enabled = enable
