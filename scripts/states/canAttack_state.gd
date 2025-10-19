@tool
extends AtomicState

@onready var animation_manager: AnimationManager = %AnimationManager
@onready var state_chart: StateChart = %StateChart
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var to_can_attack_1: Transition = %toCanAttack1
@onready var to_can_attack_2: Transition = %toCanAttack2

# Attacks should be finished, so we can hand over animation control to movement state
func _on_state_entered() -> void:
    animation_manager.release_animation_priority()

# TODO: there should be some kind of priority system here for animations
func _on_state_physics_processing(_delta: float) -> void:
    # TODO: the russian godot tutorial had a better way using a dict
    # TODO: how do I buffer?
    if Input.is_action_pressed("attack"):
        state_chart.send_event("toAttack1")
        to_can_attack_1.delay_in_seconds = str(animation_player.current_animation_length)
    elif Input.is_action_pressed("attack2"):
        state_chart.send_event("toAttack2")
        to_can_attack_2.delay_in_seconds = str(animation_player.current_animation_length)
