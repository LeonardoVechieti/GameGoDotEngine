#essa classe herda propiedade do padrao enemy_template
extends EnemyTexture
class_name WhaleTexture

func animate(velocity: Vector2) -> void:
	move_behavior(velocity)
	

func move_behavior(velocity: Vector2) -> void:
	if velocity.x !=0:
		animation.play("run")
	else:
		animation.play("idle")
		

func on_animation_finished(_anim_name: String ) -> void:
	pass 

