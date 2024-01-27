extends Area2D

const SPEED = 3000
const RANGE = 5000
var distance_travelled = 0
var rng = RandomNumberGenerator.new()
var spread : float = 0.1
var direction

func _ready():
	direction = Vector2.RIGHT.rotated(rotation + rng.randfn(0, spread)).normalized()

func _physics_process(delta):
	position += direction * SPEED * delta
	
	distance_travelled += SPEED * delta
	if distance_travelled > RANGE:
		queue_free()


func _on_body_entered(body):
	queue_free()
