extends Node

@onready var transition = %Transition
var game_level = preload("res://Levels/game_level.tscn")

func _ready():
	Global.goto_scene("res://Levels/game_level.tscn")

