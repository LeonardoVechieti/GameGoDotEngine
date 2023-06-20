extends KinematicBody2D
class_name EnemyTemplate


onready var texture: Sprite = get_node("Texture")
onready var floor_ray: RayCast2D = get_node("FloorRay")
onready var animation: AnimationPlayer = get_node("Animation")

#flags
var can_die: bool = false
var can_hit: bool = false
var can_attack: bool = false

var velocity: Vector2
var player_ref: Player = null

#movimentacão
export(int) var speed #velociade na horizontal
export(int) var gravity_speed #gravidade
export(int) var proximity_threshold #limite de proximidade, ao chegar muito perto o memso pode atacar
