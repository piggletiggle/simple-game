class_name AnimationManager
extends Sprite2D

# We use AnimationPlayer as a database for all our animations.
@onready var animation_db: AnimationPlayer = %AnimationPlayer

# Tracks the priority of the current animation. Higher is higher priority.
# e.g. movement=0, attack=1. If attack animation is playing, movement animations can't play until
# attack has released control (setting this to 0)
var currently_playing_animation_priority = 0
var nameToAnimator = {}

# Deprecated
var current_animation: Animator = null
var current_animation_name = "Animator_Idle"
var current_direction: Enums.Direction = Enums.Direction.RIGHT
# TODO: StringName instead?
func play(new_animator_name: String, new_priority: int = Enums.AnimationPriority.MOVEMENT):
    if (currently_playing_animation_priority > new_priority):
        return 
    else:
        currently_playing_animation_priority = new_priority
    current_animation_name = animation_db.current_animation.get_basename()
    if current_animation_name == new_animator_name:
        return

    print("Current Animation: %s, Transitioning to %s" % [current_animation_name, new_animator_name])
    if current_animation_name != "":
        current_animation = nameToAnimator.get(current_animation_name)
    
    var animator: Animator = nameToAnimator.get(new_animator_name)
    if (current_animation != null):
        current_animation.stop()
        
    animator.play()
    current_animation = animator
    
    
func facing(direction: Enums.Direction):
    self.current_animation.facing(direction)

## This doesn't do anything, but could be used to stop the current_animation
## idk why you would need it though. Playing automatically stops the previous one.
func stop() -> void:
    pass

## Call this when you previously had priority but now don't have any animations left to play
## e.g. You're in the Initial State for a Root state node (MovementRoot/AttackRoot)
func release_animation_priority():
    currently_playing_animation_priority = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    print("Animation Manager ready")
    for child in get_children():
        if child is Animator:
            nameToAnimator[child.name] = child
    current_animation = nameToAnimator.get("Animator_Idle")
    current_animation.play()
