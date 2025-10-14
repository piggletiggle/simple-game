extends State
class_name IdleState

@export var player: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

func Enter():
	print("entered idle state")
	
func Update(delta: float):
	animated_sprite.play("idle")
	if (Input.is_action_just_pressed("attack")):
		print("trying to exist idle state into attack state")
		Transitioned.emit(self, "AttackState")
func Physics_Update(delta: float):
	pass

func Exit():
	pass
