class_name HurtBox
extends Area2D


# TODO: move this to a library somewhere
func layer_num_to_layer_val(layer_value: int) -> int:
    return 2**(layer_value - 1)

func _init():
    print("init hurtbox")
    collision_layer = 0
    collision_mask = 2 #layer_num_to_layer_val(2)


func _ready():
    connect("area_entered", self._on_area_entered)


func _on_area_entered(hitbox: HitBox):
    if hitbox == null:
        print("hitbox was null")
        return
    if owner.has_method("take_damage"):
        print("calling damage")
        owner.take_damage(hitbox.damage)
