@tool
extends AtomicState

@onready var animation_manager: AnimationManager = %AnimationManager
@onready var jump: AudioStreamPlayer = $"../../../../../Jump"

func _on_state_entered() -> void:
    animation_manager.play("Animator_DoubleJump", Enums.AnimationPriority.MOVEMENT)
    jump.play()
