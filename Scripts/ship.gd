class_name Ship extends RigidBody2D

@export var force_offset = 2	
@export var force_magnitude = -2000

var left
var right
var input_enabled

func _ready():
	input_enabled = true

func _process(delta):
	self.left = Input.is_action_pressed("left")
	self.right = Input.is_action_pressed("right")

func _physics_process(delta):
	if (input_enabled):
		var force
		if left or right:
			# calculate force pointing to ship's forward direction
			force = global_transform.y.normalized() * force_magnitude
			# calculate point to apply the force
			# it can be applied to center, or have an offset to right or left
			var point = Vector2(0,0)
			var x_axis = global_transform.x.normalized()
			if left:
				point = point + (x_axis * force_offset)
			if right:
				point = point - (x_axis * force_offset)
	
			self.apply_force(force, point)

func apply_external_force(force):
	self.apply_central_force(force)

func get_vel_length():
	return self.linear_velocity.length()

# It's needed to disable input while the ship is inside blocks
# so they can push the ship away
func enable_input(enable):
	self.input_enabled = enable
