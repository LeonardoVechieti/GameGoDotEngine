extends Node

class_name PlayerStats

var shielding: bool = false

var base_health: int = 15
var base_mana: int = 10
var base_attack: int = 1
var base_magic_attack: int = 3
var base_defense: int = 1

var bonus_health: int = 0
var bonus_mana: int = 0
var bonus_attack: int = 0
var bonus_magic_attack: int = 0
var bonus_defense: int = 0

var current_mana: int
var current_health: int

var max_mana: int
var max_health: int 

var current_exp: int = 0

var level: int = 1
var level_dict: Dictionary = {
	"1": 25,
	"2": 33,
	"3": 49
}

func _ready() -> void:
	current_mana = base_mana + bonus_mana
	max_mana = current_mana
	
	current_health = base_health + bonus_health
	max_health = current_health

func update_exp(value: int) -> void:
	current_exp += value
	if current_exp >= level_dict[str(level)] and level < 3:
		var leftover: int = current_exp - level_dict[str(level)]
		current_exp = leftover
		on_level_up()
		level += 1
	elif current_exp >= level_dict[str(level)] and level == 3:
		current_exp = level_dict[str(level)]

func on_level_up() -> void:
	current_mana = base_mana + bonus_mana
	current_health = base_health + bonus_health

func update_health(type: String, value: int) -> void:
	match type:
		"Increase":
			current_health += value
			if current_health >= max_health:
				current_health = max_health
		"Decrease":
			verify_shield(value)
			if current_health <= 0: #Personagem com pouca vida
				pass  #Chama a animação de morrer
			else: 
				pass #Chama a animação de tomar dano
	

func verify_shield(value: int) -> void: #Verifica escudo
	if shielding:
		if (base_defense + bonus_defense) >= value: 
			return
			
		var damage = abs((base_defense + bonus_defense) - value)
		current_health -= damage
	else:
		current_health -= value


func update_mana(type: String, value: int ) -> void:
	match type:
		"Increase":
			current_mana += value
			if current_mana >= max_mana:
				current_mana = max_mana
		"Decrease":
			current_mana -= value












