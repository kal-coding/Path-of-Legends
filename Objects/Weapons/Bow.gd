
extends AnimatedSprite2D

@onready var ArrowScene = preload("res://Particles/arrow.tscn")
@onready var shoot_position = $ShootPosition
func _process(delta):
	self.look_at(get_global_mouse_position())
	if(Input.is_action_just_pressed("attack")):
		shoot(ArrowScene)
		
		
func shoot(projectile: PackedScene): 
	var projectile_instance = projectile.instantiate()
	projectile_instance.position = shoot_position.global_position
	projectile_instance.direction = global_position.direction_to(get_global_mouse_position())
	add_child(projectile_instance)
	
#
#func shoot():
	#var arrow = arrowPath.instantiate();
	#arrow.position = $ArrowMarker.global_position
	#arrow.direction = global_position.direction_to(get_global_mouse_position())
	##arrow.velocity = get_global_mouse_position() - arrow.position
	#
	#print('shooting',self.global_position)
	#get_parent().add_child(arrow)
	#
