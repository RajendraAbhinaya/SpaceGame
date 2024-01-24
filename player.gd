extends RigidBody2D

var speed : float = 0.0
var max_speed : float = 5.0
var boost : float = 1000.0

func _physics_process(delta):
	look_at(get_global_mouse_position())
	var direction = get_global_mouse_position() - global_position
	if(Input.is_action_pressed("thrust")):
		if speed < max_speed:
			speed += delta
		else:
			speed = max_speed
	else:
		if speed > 0:
			speed -= delta * 1.2
		else:
			speed = 0.0
	apply_force(direction * speed)
	
	if(Input.is_action_just_pressed("thrust")):
		if(!%Timer.is_stopped()):
			apply_impulse(direction.normalized() * boost)
			%Timer.stop()
		else:
			%Timer.start()
	
	if(Input.is_action_pressed("brakes")):
		linear_damp = 2
		angular_damp = 2
	else:
		linear_damp = 0.4
		angular_damp = 0.4
