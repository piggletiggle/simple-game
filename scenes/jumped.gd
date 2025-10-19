@tool
extends AtomicState

@onready var animation_manager: AnimationManager = %AnimationManager
@onready var player: CharacterBody2D = $"../../../../.."
@onready var state_chart: StateChart = %StateChart

func _on_state_entered() -> void:
    animation_manager.play("Animator_Jump", Enums.AnimationPriority.MOVEMENT)

# This is duplicated with Grounded state
func _on_state_physics_processing(_delta: float) -> void:
    if Input.is_action_just_pressed("jump"):
        player.velocity.y = player.JUMP_VELOCITY
        # We're currently in the "Air" state really
        state_chart.send_event("doubleJump")
