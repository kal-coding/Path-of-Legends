extends StaticBody2D


@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get('parameters/playback')
@onready var InsideDoorBlock = $InsideDoorBlock

@export var is_door_open = false;
@export var door_name: String;
@onready var player_global_coords_at_door:Vector2;

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
		# compare entry and exit vectors
			# if exit < entry 
				# player has moved into the room
			# if exit == entry 
			#    do nothing
			# if exit > entry
				# player has moved into the room 
		transition_if_entered_new_scene(body)
		
		
		#print("outside area exited at: ",body.global_position, " // in_outside_area: ",player_in_outside_area);

func transition_if_entered_new_scene(body):
	var rounded_exit_y = int(round(exit_vector.y))
	var rounded_entry_y = int(round(entry_vector.y))
	print("rounded_exit_y: ",rounded_exit_y)
	print("rounded_entry_y: ",rounded_entry_y)
	var difference = rounded_exit_y - rounded_exit_y
	print(" exit - entry doifference ", difference)
	
	const is_entered_new_scene = false;

func close_door_if_open():
	if(is_door_open):
		state_machine.travel('close')
		is_door_open = !is_door_open;
#func _on_animation_player_animation_finished(anim_name):
	#match anim_name:
		#"close":
			#if(player_has_passed_through_door):
				#Transition.transition_scene(door_name);
		
# When the player walks up to the door *in any direction, the door knows the player is there
# Door is already closed behaviour : 
	# player cannot pass through
# door is open behaviour : 
	# Player can pass through
	# close when player passes through 


				





