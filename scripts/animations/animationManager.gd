class_name AnimationManager
extends Sprite2D

# We use AnimationPlayer as a database for all our animations.
@onready var animation_db: AnimationPlayer = %AnimationPlayer

# TODO: Maybe use an ENUM for these that gets shared across everything so we can reference the 
# enum for animations, states, etc.?

var nameToAnimator = {}
var current_animation: Animator = null
var current_direction: Enums.Direction = Enums.Direction.RIGHT
# TODO: StringName instead?
func play(animator_name: String):
    if current_animation != null && current_animation.name == animator_name:
        return
    
    var animator: Animator = nameToAnimator.get(animator_name)
    if (current_animation != null):
        current_animation.stop()
    animator.play()
    current_animation = animator
    
    
func facing(direction: Enums.Direction):
    self.current_animation.facing(direction)
# This stops the current_animation
# idk why you would need it though. Playing automatically stops the previous one.
func stop() -> void:
    if current_animation != null:
        current_animation.stop()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    print("Animation Manager ready")
    for child in get_children():
        if child is Animator:
            nameToAnimator[child.name] = child
    current_animation = nameToAnimator.get("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
