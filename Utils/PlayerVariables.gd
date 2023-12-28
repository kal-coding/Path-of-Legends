extends Node

@onready var spawned_door = 'door_to_home'
@onready var Health = 100 
@onready var equipped_weapon = 'Axe'
@onready var weapons = ['Axe','Bow']

func gainHealth(value):
	Health += value;
	PlayerUICanvas.updateHealthBar(Health);

func loseHealth(value):
	Health -= value;
	print(Health)
	PlayerUICanvas.updateHealthBar(Health);
#  $Ex1 RA En2  ||   Ex3 RB $En5  ||  Ex5 RC En6 

func swap_weapon(): 
	if(equipped_weapon == 'Axe'):
		equipped_weapon = 'Bow'
	else:
		equipped_weapon = 'Axe'


# out to in = 1
# in to out = 0 
#  A0 + A1 =  1
# A1 + A0 = 0
