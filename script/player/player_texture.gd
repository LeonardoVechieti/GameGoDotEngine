extends Sprite
class_name PlayerTexture

var normal_attack: bool = false
var suffix: String = "_right"
var shield_off: bool = false
var crouching_off: bool = false

 #Pega a referencia de um irmão
export(NodePath) onready var animation = get_node(animation) as AnimationPlayer
export(NodePath) onready var player =  get_node(player) as KinematicBody2D

func animate(direction: Vector2) -> void:
	verify_position(direction)
	if player.attacking or player.defending or player.crouching:
		action_behavior()
	elif direction.y != 0:
		vertical_behavior(direction)
	elif player.landing == true:
		animation.play("landing")
		#player.set_physics_process(false)
	else:
		horizontal_behavior(direction)
	#horizontal_behavior(direction)
	#print(direction)
	
func action_behavior() -> void:
	if player.attacking and normal_attack:
		animation.play("attack" + suffix) #concatenação de strings
	elif player.defending and shield_off:
		animation.play("shield")
		shield_off =false
	elif player.crouching and crouching_off:
		animation.play("crouch")
		crouching_off=false

func vertical_behavior(direction: Vector2) -> void:
	if direction.y > 0:
		player.landing = true
		animation.play("fall")
	elif direction.y < 0:
		animation.play("jump")

func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false
		#Modifica o suffix dependendo do posição de ataque
		suffix = "_right"
	elif direction.x < 0: 
		suffix = "_left"
		flip_h = true

func horizontal_behavior(direction: Vector2) -> void:
	if direction.x != 0:
		animation.play("run")
	else:
		animation.play("idle")


func on_animation_finished(anim_name: String):
	match anim_name:
		"landing":
			player.landing = false
			#player.set_physics_process(true)
		"attack_left":
			normal_attack = false
			player.attacking = false
		"attack_right": 
			normal_attack = false
			player.attacking = false 
	
