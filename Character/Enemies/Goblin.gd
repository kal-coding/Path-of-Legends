extends CharacterBody2D
@export var resource: Resource


	
@export var move_speed : float = 30
@export var starting_direction:  Vector2 = Vector2(0,1)
@export var player_last_scene_coords:  Vector2;

# parameters/Idle/blend_position
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get('parameters/playback')
@onready var spawn_position;
@onready var health : int;
@onready var attack_damage : int;
@onready var chase_player : bool = false;
@onready var player;


func _ready():
	health = resource.health
	attack_damage = resource.attack_damage
	update_animation_parameters(starting_direction)
	

func _physics_process(_delta):
	 #Anything that moves and runs a certain times per second runs inside _physics_process
	#var input_direction = Vector2(
		#Input.get_action_strength("right") - Input.get_action_strength("left"),
		#Input.get_action_strength("down") - Input.get_action_strength("up")
	#)
	#update_animation_parameters(input_direction)
	#
	#
	## Update Velocity ( direction * speed ) 
	#velocity = input_direction * move_speed
	
	# Move and Slide function uses velocity to make the character slide 
	chase()
	pick_new_character_state()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set('parameters/run/blend_position', move_input)
		animation_tree.set('parameters/idle/blend_position', move_input)
		animation_tree.set('parameters/attack/blend_position', move_input)
		animation_tree.set('parameters/death/blend_position', move_input)
		animation_tree.set('parameters/take_hit/blend_position', move_input)


func pick_new_character_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel('run')
	else: 
		state_machine.travel('idle')



func _on_detection_range_body_entered(body):
	switch_chase_state(body)


func _on_detection_range_body_exited(body):
	switch_chase_state(body)

func switch_chase_state(body):
	if(body.is_in_group("Player")):
		player = body
		chase_player = !chase_player
		if(!chase_player): 
			velocity = Vector2.ZERO
		print("chase_player : ",chase_player)

func chase():
	if(chase_player):
		var player_position = player.position
		var input_direction = (player_position - position).normalized()
		velocity = input_direction * move_speed
		update_animation_parameters(input_direction)
		move_and_slide()
	
	
	# Update Velocity ( direction * speed ) 
