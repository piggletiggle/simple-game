extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var num_jumps = 0
@onready var state_chart: StateChart = %StateChart
@onready var animation_manager: AnimationManager = $AnimationManager
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _physics_process(delta: float) -> void:
    if !is_on_floor():
        # Enables gravity on my guy
        velocity += get_gravity() * delta
        state_chart.send_event("groundToAir")
        print("air")
    # if we're on the floor, but previous wasn't (i.e. we were in the air)
    if is_on_floor():
        print("floor")
        state_chart.send_event("airToGround")


# Probably controls getting hurt
func _on_area_2d_hitbox_attack_area_entered(area: Area2D) -> void:
    if area.is_in_group("hurtbox"):
        area.take_damage()
