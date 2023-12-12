extends CharacterBody2D
@export var resource: Resource

@onready var health;
@onready var attack_damage;

func _ready():
	health = resource.health
	attack_damage = attack_damage.health
	
