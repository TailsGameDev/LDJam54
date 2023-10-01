extends Area2D

@export var velocity = Vector2(0,0)
@export var force_multipliers = Vector2(0,1)

var ship_vel
var ship

func _physics_process(delta):
	# push ship away
	if self.ship != null:
		if ship.get_vel_length() < ship_vel.length():
			var force_x = ship_vel.x * force_multipliers.x
			var force_y = ship_vel.y * force_multipliers.y
			var force = Vector2(force_x, force_y)
			ship.apply_external_force(force)
	
	# move block
	self.position = self.position + self.velocity

func _on_body_entered(body):
	#print("enter")
	self.ship = body
	self.ship_vel = body.linear_velocity
	body.enable_input(false)

func _on_body_exited(body):
	self.ship = null
	self.ship_vel = null
	body.enable_input(true)

