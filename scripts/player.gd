extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var num_jumps = 0
@onready var state_chart: StateChart = $StateChart
@onready var animation_manager: AnimationManager = $AnimationManager

#@onready var _animation_tree: AnimationTree = $AnimationTree
#@onready var _animation_state_machine: AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d_attack: Sprite2D = $Sprite2D/Sprite2D_Attack
@onready var sprite_2d_idle: Sprite2D = $Sprite2D/Sprite2D_Idle

@onready var _parent_sprite: Sprite2D = $Sprite2D
var is_on_ground = true
var is_attacking = false
var is_attacking2 = false


func _input(event):
    # TODO: probably should use a separate state tree for this and just play the animation when we transition between states
    is_attacking = event.is_action_pressed("attack")
    is_attacking2 = event.is_action_pressed("attack2")


func handle_sprite_direction(direction: float):
    # TODO: move this shit to the animator
    for child_sprite in _parent_sprite.get_children():
        if direction < 0 and _parent_sprite.scale.x > 0:
            _parent_sprite.scale.x *= -1
        elif direction > 0 and _parent_sprite.scale.x < 0:
            _parent_sprite.scale.x *= -1
        #var directionToScaleX = (2 * int(direction > 0)) - 1
         #= directionToScaleX


func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity += get_gravity() * delta

    # REGION: JUMP
    if !is_on_floor() and is_on_ground:
        is_on_ground = false
        #state_chart.send_event("jump")
        
    if is_on_floor():
        #num_jumps = 0
        # if we're on the floor, but previous wasn't (i.e. we were in the air)
        if !is_on_ground:
            state_chart.send_event("airToGround")
            is_on_ground = true
#ENDREGION

# REGION: DIRECTIONS
    var direction := Input.get_axis("ui_left", "ui_right")
    if direction:
        animation_manager.play("Animator_Run")
        velocity.x = direction * SPEED
        handle_sprite_direction(direction)
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
    move_and_slide()
#ENDREGION

func _on_can_jump_state_physics_processing(delta: float) -> void:
    if Input.is_action_just_pressed("jump"):
        
        velocity.y = JUMP_VELOCITY
        state_chart.send_event("jump")


func _on_area_2d_hitbox_attack_area_entered(area: Area2D) -> void:
    if area.is_in_group("hurtbox"):
        area.take_damage()


func _on_grounded_state_entered() -> void:
    print("idling state")
    animation_manager.play("Animator_Idle")
