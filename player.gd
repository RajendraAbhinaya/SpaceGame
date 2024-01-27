extends RigidBody2D

var speed : float = 0.0
var max_speed : float = 1000.0
var acceleration : float = 50.0
var boost : float = 1000.0
const BULLET = preload("res://bullet.tscn")

func _physics_process(delta):
	look_at(get_global_mouse_position())
	var direction = get_global_mouse_position() - global_position
	var magnitude = direction.length()
	if(Input.is_action_pressed("thrust")):
		if speed < max_speed:
			speed += magnitude * delta * acceleration
		else:
			speed = max_speed
	else:
		if speed > 0:
			speed -= delta * magnitude* 1.2
		else:
			speed = 0.0
	apply_force(direction.normalized() * speed)
	
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
	
	if Input.is_physical_key_pressed(KEY_A):
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootPoint.global_position
		new_bullet.global_rotation = %ShootPoint.global_rotation
		get_parent().add_child(new_bullet)
