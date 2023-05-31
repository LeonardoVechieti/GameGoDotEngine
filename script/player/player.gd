extends KinematicBody2D
class_name Player

onready var player_sprite: Sprite  = get_node("Texture")

var velocity: Vector2
#Variaveis para ainimações
var jump_count: int = 0
var landing: bool = false
#Definindo as variaveis de atack (Estados)
var attacking: boll = false
var defending: boll = false
var chouching: boll = false
#Definindo as variaveis de atack (Logica)
var can_track_input: boll = true #Impede de realizar outros movimentos

#Variaveis de movimentação
export(int) var speed
export(int) var jump_speed
export(int) var player_gravity

func _physics_process(delta: float):
	horizontal_movement_env()
	vertical_movement_env()
	action_env()
	gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	player_sprite.animate(velocity)
	
	
func horizontal_movement_env() -> void:
	var input_direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = input_direction * speed
	print(velocity.x)


func vertical_movement_env() -> void: 
	if is_on_floor(): 
		jump_count = 0
		
	if Input.is_action_just_pressed("ui_select") and jump_count < 2:
		jump_count += 1
		velocity.y = jump_speed
		
	
func action_env() -> void:
	attack()
	crouch()
	defense()
	
func attack() -> void:
	#Se o player estiver atancando, defendendo, ou agachado retorna true 
	var attack_condition: boll = not attacking and not crouching and not defending
	if Input.is_action_just_pressed("attack") and attack_condition and is_on_floor():
		#habilita a possibilidade de atacke
		attacking =true

func crouch() -> void:
	if Input.is_action_pressed("crouch") and is_on_floor() and not defending:
		crouching = true
		can_track_input = false
	elif not defending:
		crouching = false
		can_track_input = true
		
func defense() -> void: 
	if Input.is_action_pressed("defense") and is_on_floor() and not crouching:
		defending = true
		can_track_input= false
	elif not crouching:
		defending =false
		can_track_input= true
	
func gravity(delta: float) -> void:
	velocity.y += delta * player_gravity
	if velocity.y >= player_gravity:
		velocity.y = player_gravity
