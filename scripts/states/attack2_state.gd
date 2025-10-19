@tool
extends CompoundState

@onready var animation_manager: AnimationManager = %AnimationManager

func _on_state_entered() -> void:
    animation_manager.play("Animator_Attack2", Enums.AnimationPriority.ATTACK)
