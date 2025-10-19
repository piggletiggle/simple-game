@tool
extends AtomicState

@onready var animation_manager: AnimationManager = %AnimationManager

func _on_state_entered() -> void:
    animation_manager.play("Animator_DoubleJump", Enums.AnimationPriority.MOVEMENT)
    
