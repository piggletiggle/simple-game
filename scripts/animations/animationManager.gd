class_name AnimationManager
extends Sprite2D

# We use AnimationPlayer as a database for all our animations.
@onready var animation_db: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d_idle: Sprite2D = $Sprite2D/Sprite2D_Idle
@onready var sprite_2d_run: Sprite2D = $Sprite2D/Sprite2D_Run
@onready var sprite_2d_attack: Sprite2D = $Sprite2D/Sprite2D_Attack
@onready var sprite_2d_attack_2: Sprite2D = $Sprite2D/Sprite2D_Attack2

# TODO: Maybe use an ENUM for these that gets shared across everything so we can reference the 
# enum for animations, states, etc.?

var nameToAnimator = {}
var current_animation: Animator = null

# TODO: StringName instead?
func play(animator_name: String):
    print("playing animation: ", animator_name)
    var animator: Animator = nameToAnimator.get(animator_name)
    current_animation.stop()
    animator.play()
    current_animation = animator
    

# This stops the current_animation
# idk why you would need it though. Playing automatically stops the previous one.
func stop() -> void:
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
