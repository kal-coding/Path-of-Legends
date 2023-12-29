extends Node

func play_sound(stream: AudioStreamPlayer, from_position: float = 0):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream
	instance.finished.connect(remove_node.bind(instance))
	add_child(instance)
	instance.play(from_position)
	
func play_sound_2D(stream: AudioStreamPlayer2D, from_position: float = 0):
	var instance = AudioStreamPlayer2D.new()
	instance.stream = stream.stream
	instance.finished.connect(remove_node.bind(instance))
	add_child(instance)
	print("playaudiohit")
	instance.play(from_position)
	
func remove_node(instance: AudioStreamPlayer):
	instance.queue_free()
