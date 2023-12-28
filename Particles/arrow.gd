extends AnimatedSprite2D

@export var speed = 300
@export var lifetime = 2
@export var damage = 50
@onready var timer = $Timer

var direction = Vector2.ZERO

func _ready():
	set_as_top_level(true)
	look_at(get_global_mouse_position())
	timer.start(lifetime)

func _physics_process(delta):
	position += direction * speed * delta

func _on_timer_timeout():
	queue_free()


func _on_hitbox_body_entered(body):
	if(body.is_in_group("Enemy")):
		body.loseHealth(damage,position)
		queue_free()
	pass # Replace with function body.
