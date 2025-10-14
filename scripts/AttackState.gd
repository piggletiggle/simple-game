extends State
class_name AttackState

@export var player: CharacterBody2D
@export var is_attack := false
@export var animated_sprite: AnimatedSprite2D

# TODO: we need multiple FSMs since We can do both Attack + Move at the same time, so they're not part of the same FSM.
# 	e.g. we have an upperbody/lowerbody FSM which are indendent, but within the same FSM they can't be in the same FSM at the sam etime.
func Enter():
	print("entered attack state")
	is_attack = true
	animated_sprite.play("attack")
	print("attacking")
	
func Update(delta: float):
	pass
func Physics_Update(delta: float):
	pass


func _on_animated_sprite_2d_animation_changed() -> void:
	print("triggered animation change")
	if (!is_attack):
		print("finished animation")
		is_attack = false
		Transitioned.emit(self, "IdleState")
	else:
		print("finished animation in else")
		is_attack = true
