extends Node2D
class_name Level

onready var player: KinematicBody2D = get_node("Player")

func _ready() -> void:
	#Pega o sinal de morte do pleyer 
	var _game_over: bool = player.get_node("Texture").connect("game_over", self, "on_game_over")
	
	
func on_game_over() -> void:
	#logica de reinicar a fase apos o game_over
	var _reload: bool = get_tree().reload_current_scene()
	
