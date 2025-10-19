@tool
extends AtomicState

@onready var animation_manager: AnimationManager = %AnimationManager

func _on_state_physics_processing(_delta: float) -> void:
    animation_manager.play("Animator_Walk")
