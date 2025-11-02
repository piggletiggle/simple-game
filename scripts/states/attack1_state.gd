@tool
extends CompoundState

@onready var animation_manager: AnimationManager = %AnimationManager
@onready var whoosh: AudioStreamPlayer = $"../../../../Jump/whoosh"

func _on_state_entered() -> void:
    print("attack1 state")
    animation_manager.play("Animator_Attack1", Enums.AnimationPriority.ATTACK)
    whoosh.play()
