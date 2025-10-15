extends Node2D

@export var health = 100
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func take_damage(damage_taken: int):
    animation_player.stop()
    animation_player.play("hit")
    health -= damage_taken
    print("got hit for ", damage_taken)
    print("hp: ", health)
