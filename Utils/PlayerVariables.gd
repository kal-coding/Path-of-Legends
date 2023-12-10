extends Node

var player_global_coords_at_last_door: Vector2 = Vector2(0,0);
var player_global_coords_at_recent_door: Vector2 = Vector2(0,0);

func set_player_global_coords_at_door(coordinates:Vector2):
	player_global_coords_at_door = coordinates
	
func get_player_global_coords_at_door():
	return player_global_coords_at_door;

func update_player_coords_on_transition_to_new_scene():
	
	

#  A0  DA A1    B1 DB B2    C1 DC C2 

# Player needs to know the scene he entered FROM and entered TO 
# Player needs to know DIRECTION he entered

# out to in = 1
# in to out = 0 
#  A0 + A1 =  1
# A1 + A0 = 0
