extends AnimationPlayer

const GAME_LEVEL_PATH = "res://Levels/game_level.tscn"
const HOME_LEVEL_PATH = "res://Levels/home_level.tscn"

var next_scene = null;
func transition_scene(scene_name):
	next_scene = fetch_path_to_scene(scene_name)
	self.play("fade_in")

func _on_scene_transition_animation_finished(animation_name):
	match animation_name:
		"fade_in": 
			Global.goto_scene(next_scene)
			self.play("fade_out")
		"fade_out":
			print('faded_out')

func fetch_path_to_scene(scene_name):
	match scene_name:
		"to_home": 
			next_scene=HOME_LEVEL_PATH
		"to_world":
			next_scene=GAME_LEVEL_PATH

#func update_global_scen_prev_and_current_name(scene_name)
	#Global.
	

