extends CharacterBody2D

@export var SPEED = 200.0
@export var JUMP_VELOCITY = -300.0
@onready var state_chart: StateChart = %StateChart

func _physics_process(delta: float) -> void:
    # Enable Gravity
    velocity += get_gravity() * delta
    
    if !is_on_floor():
        state_chart.send_event("groundToAir")
    if is_on_floor():
        state_chart.send_event("airToGround")

# Probably controls getting hurt but I think the signal doesn't exist
func _on_area_2d_hitbox_attack_area_entered(area: Area2D) -> void:
    if area.is_in_group("hurtbox"):
        area.take_damage()
