extends AnimatedSprite2D

@export var starting_direction:  Vector2 = Vector2(0,1)

# parameters/Idle/blend_position
@onready var axe_animation_tree = $AxeAnimationTree

@onready var axe_state_machine = axe_animation_tree.get('parameters/playback')
@onready var spawn_position;
@onready var attack_damage = 50;


func _ready():
	# always face Player on spawn
	update_animation_parameters(starting_direction)
	

func _physics_process(_delta):
	# Anything that moves and runs a certain times per second runs inside _physics_process
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	pick_new_axe_state()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		axe_animation_tree.set('parameters/idle/blend_position', move_input)
		axe_animation_tree.set('parameters/attack/blend_position', move_input)


func pick_new_axe_state():
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		axe_state_machine.travel('attack')



func _on_axe_animation_player_animation_finished(anim_name):
	pass


func _on_axe_attack_detection_body_entered(body):
	var axe_state = axe_state_machine.get_current_node()
	var is_attack_state = axe_state == "attack"
	if(body.is_in_group("Enemy") && is_attack_state):
		body.loseHealth(attack_damage,self)
	pass # Replace with function body.
