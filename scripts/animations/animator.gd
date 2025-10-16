# Abstract class. Implementations handle anything to do with making an animation happen.
class_name Animator
extends Sprite2D


@export var animation_manager: AnimationManager
@export var animation_player: AnimationPlayer

## This is the name you gave to this animation inside the AnimationPlayer
var animation_player_name

func _get_configuration_warning() -> String:
    if get_parent() == null or !get_parent() is AnimationManager:
        return "This node must have an AnimationManager as a parent"
    return ""

## Must be implemented. This should
## - start playing the relevant animation
## - call animation_manager.stop() TODO: implement this - AM should call stop of Animator
func play() -> void:
    self.visible = true
    if (animation_manager != null):
        animation_manager.stop()
    if (animation_player != null):
        animation_player.play(animation_player_name)

## Must be implemented. This should
## - stop playing the relevant animation
## - queue_free() anything it needs to
## - hide itself
## - stop playing the animation
func stop() -> void:
    self.visible = false
    print("trying to stop playing: ", animation_player_name)
    print(animation_player)
    animation_player.stop()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    print("animator is ready")
    print(animation_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
