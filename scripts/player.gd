extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var num_jumps = 0
@onready var state_chart: StateChart = %StateChart
@onready var animation_manager: AnimationManager = $AnimationManager
@onready var animation_player: AnimationPlayer = %AnimationPlayer

@onready var sprite_2d_attack: Sprite2D = $Sprite2D/Sprite2D_Attack
@onready var sprite_2d_idle: Sprite2D = $Sprite2D/Sprite2D_Idle

@onready var _parent_sprite: Sprite2D = $Sprite2D
var is_on_ground = true
#var is_attacking = false
#var is_attacking2 = false


func _input(event):
    # TODO: probably should use a separate state tree for this and just play the animation when we transition between states
    #is_attacking = event.is_action_pressed("attack")
    #is_attacking2 = event.is_action_pressed("attack2")
    pass

func handle_sprite_direction(direction: float):
    var enumDirection = Enums.Direction.LEFT if direction < 0 else Enums.Direction.RIGHT
    animation_manager.facing(enumDirection)

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
        state_chart.send_event("walk")
        velocity.x = direction * SPEED
        
        # TODO: maybe a global state? Airborne/Grounded doesn't 
        handle_sprite_direction(direction)
    else:
        state_chart.send_event("idle")  
        velocity.x = move_toward(velocity.x, 0, SPEED)
    move_and_slide()
#ENDREGION



# TODO: might make sense to have a file per state


func _on_can_jump_state_physics_processing(delta: float) -> void:
    if Input.is_action_just_pressed("jump"):
        velocity.y = JUMP_VELOCITY
        state_chart.send_event("jump")


func _on_area_2d_hitbox_attack_area_entered(area: Area2D) -> void:
    if area.is_in_group("hurtbox"):
        area.take_damage()


func _on_idle_state_entered() -> void:
    print("idling state")
    animation_manager.play("Animator_Idle")


func _on_walking_state_entered() -> void:
    print("walking state")
    animation_manager.play("Animator_Run")


# Attack states


func _on_attack_1_state_entered() -> void:
    print("attack1 state")
    animation_manager.play("Animator_Attack1")
    pass # Replace with function body.
    




func _on_attack_2_state_entered() -> void:
    print("attack2 state")
    animation_manager.play("Animator_Attack2")
    pass # Replace with function body.


func _on_can_attack_state_physics_processing(delta: float) -> void:
    # TODO: the russian godot tutorial had a better way using a dict
    if Input.is_action_pressed("attack"):
        state_chart.send_event("toAttack1")
        # TODO: after animation_player.current_animation_length seconds, transition back toCanAttack
        # TODO: use a fucking Attacking state so I can actually control this nicely!!!!!
        
    elif Input.is_action_pressed("attack2"):
        state_chart.send_event("toAttack2")
    
