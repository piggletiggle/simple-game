extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var _animation_tree: AnimationTree = $AnimationTree
@onready var _animation_state_machine: AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")
@onready var _parent_sprite: Sprite2D = $Parent
var rng = RandomNumberGenerator.new()
enum {
    WALK,
    EAT,
    IDLE
}
var action = IDLE
const SPEED = 20
func handle_sprite_direction(direction: float):
    for child_sprite in _parent_sprite.get_children():
        var directionToScaleX = (2 * int(direction < 0)) - 1
        _parent_sprite.scale.x = directionToScaleX


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func move():
    print("move")
    action = WALK
    #_animation_state_machine.travel("walk")
    var direction = rng.randi_range(-1, 1)
    if direction:
        velocity.x = direction * SPEED
        handle_sprite_direction(direction)
    else:
        action = IDLE
        velocity.x = 0
        
    
func eat():
    print("eat")
    velocity.x = 0
    action = EAT
    #_animation_state_machine.travel("eating")
    
func idle():
    print("idle")
    action = IDLE
    velocity.x = 0
    #_animation_state_machine.travel("idle")

var current_time_elapsed = 0
var can_move = true
var last_moved = 0
var actions = [move, eat, idle]


func _physics_process(delta: float) -> void:
    # picks a random direction to move
    # picks a random action to do
    current_time_elapsed += delta
    can_move = (current_time_elapsed - last_moved) > 3
    if not is_on_floor():
        velocity += get_gravity() * delta
    if can_move:
        actions.shuffle()
        
        print("moving")

        actions[0].call()
        last_moved = current_time_elapsed

    move_and_slide()
