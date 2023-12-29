extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction:  Vector2 = Vector2(0,1)
@export var player_last_scene_coords:  Vector2;

# parameters/Idle/blend_position
@onready var cat_animation_tree = $AnimationTree
@onready var cat_state_machine = cat_animation_tree.get('parameters/playback')
@onready var spawn_position;

@onready var isPlayerAlive = true;
@onready var shoot_position = $ShootPosition
@onready var equipped_weapon = Player.equipped_weapon


@onready var AxeScene = preload("res://Objects/Weapons/axe.tscn")
@onready var BowScene = preload("res://Objects/Weapons/Bow.tscn")


func _ready():
	# always face Player on spawn
	update_animation_parameters(starting_direction)
	spawn_into_room()
	ready_weapon()

func ready_weapon():
	if(equipped_weapon == "Axe"):
		var AxeInstance = AxeScene.instantiate()
		add_child(AxeInstance)
	elif(equipped_weapon == "Bow"): 
		var BowInstance = BowScene.instantiate()
		add_child(BowInstance)

func _physics_process(_delta):
	# Anything that moves and runs a certain times per second runs inside _physics_process
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	
	# Update Velocity ( direction * speed ) 
	if(isPlayerAlive):
		velocity = input_direction.normalized() * move_speed
		
	# Move and Slide function uses velocity to make the character slide 
	move_and_slide()
	pick_new_character_state()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		cat_animation_tree.set('parameters/Walk/blend_position', move_input)
		cat_animation_tree.set('parameters/Idle/blend_position', move_input)


func pick_new_character_state():
	var isPlayerMoving = velocity != Vector2.ZERO
	if(isPlayerMoving && isPlayerAlive):
		cat_state_machine.travel('Walk')
	elif(!isPlayerMoving && isPlayerAlive): 
		cat_state_machine.travel('Idle')


#region OnLoad : Player spawn location in Room
func spawn_into_room():
	var player_spawned_door = Player.spawned_door
	var spawned_door_instance = self.get_parent().find_child(player_spawned_door)
	var spawned_door_position = spawned_door_instance.get_position()
	var spawned_door_is_transition_area_below = spawned_door_instance.is_transition_area_below
	var spawned_door_player_position;
	spawned_door_player_position = Vector2(spawned_door_position.x,int(spawned_door_position.y+10))
	if(!spawned_door_is_transition_area_below):
		spawned_door_player_position = Vector2(spawned_door_position.x,spawned_door_position.y+10)
	else:
		spawned_door_player_position = Vector2(spawned_door_position.x,spawned_door_position.y-10)
	self.set_position(spawned_door_player_position)
#endregion

func loseHealth(damage_taken):
	if(Player.Health > 0):
		Player.loseHealth(damage_taken)
	elif(Player.Health <= 0 && isPlayerAlive):
		isPlayerAlive = false;
		cat_state_machine.travel('Death')
		$GameOverAudio.play()
		

	
