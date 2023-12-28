extends CharacterBody2D
@export var resource: Resource


	
@export var move_speed : float = 50
@export var starting_direction:  Vector2 = Vector2(0,1)
@export var player_last_scene_coords:  Vector2;

# parameters/Idle/blend_position
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get('parameters/playback')
@onready var spawn_position;
@onready var health : int;
@onready var attack_damage : int;
@onready var chase_player_flag : bool = false;
@onready var player;
@onready var damage_source_position;
@onready var particles = $CPUParticles2D ;

@export var is_alive_flag = true;
@export var take_hit_flag = false;


func _ready():
	health = resource.health
	attack_damage = resource.attack_damage
	update_animation_parameters(starting_direction)
	

func _physics_process(_delta):
	pick_new_character_state()
	move_and_slide()
	
func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set('parameters/run/blend_position', move_input)
		animation_tree.set('parameters/idle/blend_position', move_input)
		animation_tree.set('parameters/attack/blend_position', move_input)
		animation_tree.set('parameters/death/blend_position', move_input)
		animation_tree.set('parameters/take_hit/blend_position', move_input)


func pick_new_character_state():
	if(health <= 0 && is_alive_flag):
		state_machine.travel('death')
		var input_direction = (damage_source_position - position).normalized()
		velocity = -input_direction * move_speed*1.2
		update_animation_parameters(input_direction)
		is_alive_flag = false;
		$Timer.start(1.5)
	elif(take_hit_flag && is_alive_flag):
		state_machine.travel('take_hit')
		var input_direction = (damage_source_position - position).normalized()
		velocity = -input_direction * move_speed*1.2
		update_animation_parameters(input_direction)
	elif(chase_player_flag && is_alive_flag):
		state_machine.travel('run')
		var player_position = player.position
		var input_direction = (player_position - position).normalized()
		velocity = input_direction * move_speed
		update_animation_parameters(input_direction)
		var distance_to_player = $".".position.distance_to(player.position)
		if (distance_to_player < 15):
			velocity = Vector2.ZERO
			state_machine.travel('attack')
	elif(!is_alive_flag):
		pass;
	else: 
		state_machine.travel('idle')
		velocity = Vector2.ZERO


func _on_detection_range_body_entered(body):
	switch_chase_flag(body)

func _on_detection_range_body_exited(body):
	switch_chase_flag(body)


func switch_chase_flag(body):
	if(body.is_in_group("Player") && checkIfAlive()):
		player = body
		chase_player_flag = !chase_player_flag
	
func loseHealth(damage_taken,damage_source_p):
	if(checkIfAlive() && !take_hit_flag):
		damage_source_position = damage_source_p
		health -= damage_taken
		take_hit_flag = true;
		particles.set_direction(damage_source_position)
		particles.set_emitting(true)
	
func checkIfAlive():
	return health > 0
	
func checkIfStateIsTakeHit():
	return state_machine.get_current_node() == "take_hit"

func checkIfStateIsDeath():
	return state_machine.get_current_node() == "death"
	
func _on_animation_tree_animation_finished(anim_name):
	match(anim_name):
		"take_hit_left":
			take_hit_flag = false
		"take_hit_right":
			take_hit_flag = false
		"death_right":
			velocity = Vector2.ZERO
		"death_left":
			velocity = Vector2.ZERO


func _on_attack_range_body_entered(body):
	if(body.is_in_group("Player")):
		body.loseHealth(attack_damage,player)


func _on_timer_timeout():
	queue_free()
	pass 
