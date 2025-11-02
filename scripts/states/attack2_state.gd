@tool
extends CompoundState

@onready var animation_manager: AnimationManager = %AnimationManager
@onready var whoosh_fast: AudioStreamPlayer = $"../../../../Jump/whoosh_fast"

func _on_state_entered() -> void:
    animation_manager.play("Animator_Attack2", Enums.AnimationPriority.ATTACK)
    whoosh_fast.play()
