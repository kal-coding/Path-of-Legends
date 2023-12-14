extends CanvasLayer

@export var HEALTH_BAR_PATH = '/root/PlayerUICanvas/HealthBar/TextureProgressBar'
@onready var HealthBar = get_node(HEALTH_BAR_PATH)

func updateHealthBar(value):
	HealthBar.value += value
	
func gainHealth(value): 
	HealthBar.value += value
	
func loseHealth(value):
	HealthBar.value -= value
