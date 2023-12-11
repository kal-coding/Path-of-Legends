extends AnimationPlayer

const GAME_LEVEL_PATH = "res://Levels/game_level.tscn"
const HOME_LEVEL_PATH = "res://Levels/home_level.tscn"

var next_scene = null;
func transition_scene(next_scene_name, next_door_name):
	next_scene = fetch_path_to_scene(next_scene_name)
	PlayerVariables.spawned_door = next_door_name
	self.play("fade_in")

func _on_animation_finished(animation_name):
	print('animation')
	match animation_name:
		"fade_in":
			# Set last world co ords
			Global.goto_scene(next_scene)
			self.play("fade_out")
		"fade_out":
			print('faded_out')

func fetch_path_to_scene(next_scene_name):
	var scene_path;
	match next_scene_name:
		"to_home": 
			scene_path = HOME_LEVEL_PATH
		"to_world":
			scene_path = GAME_LEVEL_PATH
	return scene_path

# Q: What are the possible scenarios for interacting with a door?
	# 1 Step into door frame
	# 2 Leave through door
	# 3 Re-enter old room 

# Notes : 
#  - We need to know the PREVIOUS room's door co ordinates
#  - We need to know the NEXT room's door co ordinates  
	

