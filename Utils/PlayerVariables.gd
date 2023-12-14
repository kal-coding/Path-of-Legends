extends Node

@onready var spawned_door = 'door_to_home'
@onready var Health = 100 

func gainHealth(value):
	Health += value;
	PlayerUICanvas.updateHealthBar(Health);

func loseHealth(value):
	Health -= value;
	PlayerUICanvas.updateHealthBar(Health);
#  $Ex1 RA En2  ||   Ex3 RB $En5  ||  Ex5 RC En6 

# Player needs to know the scene he entered FROM and entered TO 
# Player needs to know DIRECTION he entered

# out to in = 1
# in to out = 0 
#  A0 + A1 =  1
# A1 + A0 = 0
