extends Sprite
class_name PlayerTexture

func animate(direction: Vector2) -> void:
	verify_position(direction)
	print(direction)
	
func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false
	elif direction.x < 0: 
		flip_h = true

