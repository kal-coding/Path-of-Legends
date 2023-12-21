extends AnimatedSprite2D

@export var speed = 100
@export var lifetime = 2

@onready var timer = $Timer

var direction = Vector2.ZERO

func _ready():
	set_as_top_level(true)
	print("position: ",position ,", direction: ",direction)
	look_at(position * direction)
	timer.start(lifetime)

func _physics_process(delta):
	position += direction * speed * delta

func _on_timer_timeout():
	queue_free()
