extends Resource
class_name EnemyResource 

@export var health: int
@export var attack_power: int


func loseHealth(damage_value): 
	health -= damage_value
