extends Node2D

@onready var state_chart: StateChart = %StateChart
@onready var player: CharacterBody2D = $".."
@onready var animation_manager: AnimationManager = %AnimationManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func _input(_event: InputEvent):
    # TODO: probably should use a separate state tree for this and just play the animation when we transition between states
    #is_attacking = event.is_action_pressed("attack")
    #is_attacking2 = event.is_action_pressed("attack2")
    pass

# TODO: move this into a globals file
func handle_sprite_direction(direction: float):
    var enumDirection = Enums.Direction.LEFT if direction < 0 else Enums.Direction.RIGHT
    animation_manager.facing(enumDirection)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
# REGION: DIRECTIONS
    var left: float = Input.get_action_strength("left") * -1
    var right: float = Input.get_action_strength("right")
    var direction = left + right
    if direction:
        state_chart.send_event("walk")
        player.velocity.x = direction * player.SPEED
        handle_sprite_direction(direction)
    else:
        state_chart.send_event("idle")  
        player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
    player.move_and_slide()
#ENDREGION
