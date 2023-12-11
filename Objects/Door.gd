extends StaticBody2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get('parameters/playback')


@export var door_name: String;
@export var next_scene_name: String;
@export var next_door_name: String;
@export var is_transition_area_below: bool;
@onready var player_global_coords_at_door:Vector2;

var is_door_open = false;
var enter_new_scene:bool = false;
var player_in_outside_area = false;
var player_in_inside_area = false;

var entry_vector: Vector2 = Vector2(0,0);
var exit_vector: Vector2 = Vector2(0,0); 

var is_player_at_door = player_in_outside_area || player_in_inside_area;


func _on_body_entered(body):
	if(body.is_in_group("Player")):
		pass

func _on_body_exited(body):
	if(body.is_in_group("Player")):
		pass
			
func _input(event: InputEvent):
	if(event.is_action_pressed("interact")):
		print("is_player_at_door: ",is_player_at_door)
		if(is_door_open):
			state_machine.travel('close')
		else:
			state_machine.travel('open')
		is_door_open = !is_door_open;
				
func _on_inside_area_2d_body_entered(body):
	if(body.is_in_group("Player")):
		player_in_inside_area = true
		
func _on_inside_area_2d_body_exited(body):
	if(body.is_in_group("Player")):
		player_in_inside_area = false
		close_door_if_open()

func _on_outside_area_2d_body_entered(body):
	if(body.is_in_group("Player")):
		player_in_outside_area = true
		entry_vector = body.global_position
		
func _on_outside_area_2d_body_exited(body):
	if(body.is_in_group("Player")):
		player_in_outside_area = false
		exit_vector = body.global_position
		close_door_if_open()
		transition_if_entered_new_scene(body)
		
func transition_if_entered_new_scene(_body):
	var calculated_transition_position= exit_vector > entry_vector
	var player_moved_to_transition_area = calculated_transition_position == is_transition_area_below
	print('player_moved_to_transition_area ',player_moved_to_transition_area)
	if(player_moved_to_transition_area):
		enter_new_scene = true

func close_door_if_open():
	if(is_door_open):
		state_machine.travel('close')
		is_door_open = !is_door_open;
		
func _on_animation_tree_animation_finished(_anim_name):
	if(enter_new_scene): 
		enter_new_scene = !enter_new_scene
		var next_is_transition_area_below = !is_transition_area_below
		Transition.transition_scene(next_scene_name, next_door_name)
