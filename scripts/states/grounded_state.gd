@tool
extends CompoundState

@onready var player: CharacterBody2D = $"../../../.."
@onready var state_chart: StateChart = %StateChart

# Duplicated with Jumped state (for double jumps). Consider abstracting this out to a generic jump if desired.
func _on_state_physics_processing(_delta: float) -> void:
    if Input.is_action_just_pressed("jump"):
        player.velocity.y = player.JUMP_VELOCITY
        state_chart.send_event("jump")
        
