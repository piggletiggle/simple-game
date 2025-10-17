# Abstract class. Implementations handle anything to do with making an animation happen.
class_name Animator
extends Sprite2D

@onready var animation_manager: AnimationManager = %AnimationManager
@onready var animation_player: AnimationPlayer = %AnimationPlayer
## This is the name you gave to this animation inside the AnimationPlayer
@export var animation_player_name: String
@onready var state_chart: StateChart = %StateChart

func _get_configuration_warning() -> String:
    if get_parent() == null or !get_parent() is AnimationManager:
        return "This node must have an AnimationManager as a parent"
    return ""


## Tell the sprite to face the current Direction. Animators can override this if flipping the
## sprite doesn't make sense
func facing(direction: Enums.Direction):
    # TODO: what happens if we face left on walking, but then switch to idle? It'll be facing the wrong way.
    #   we either need to make sure that before we play, we face the correct direction, or we update everything
    #  to face the correct direction at the same time.
    if direction == Enums.Direction.LEFT && animation_manager.scale.x  > 0:
        animation_manager.scale.x *= -1
    elif direction == Enums.Direction.RIGHT && animation_manager.scale.x <0:
        animation_manager.scale.x *= -1
    #for child_sprite in _parent_sprite.get_children():
        #if direction < 0 and _parent_sprite.scale.x > 0:
            #_parent_sprite.scale.x *= -1
        #elif direction > 0 and _parent_sprite.scale.x < 0:
            #_parent_sprite.scale.x *= -1

## Must be implemented. This should
## - start playing the relevant animation
## - call animation_manager.stop() TODO: implement this - AM should call stop of Animator
func play() -> void:
    self.visible = true
    animation_manager.stop()
    # If you failed here, you probably forgot to add a script to your Animator
    animation_player.play(animation_player_name)

## Must be implemented. This should
## - stop playing the relevant animation
## - queue_free() anything it needs to
## - hide itself
## - stop playing the animation
func stop() -> void:
    self.visible = false
    #animation_player.stop()
