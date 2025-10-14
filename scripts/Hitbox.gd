class_name HitBox
extends Area2D

@export var damage: int = 20

# TODO: move this to a library somewhere
func layer_num_to_layer_val(layer_value: int) -> int:
    return (layer_value - 1)**2

func _init():
    print("init hitbox")
    collision_layer = 2 #player_num_to_layer_val(2)
    collision_mask = 0
