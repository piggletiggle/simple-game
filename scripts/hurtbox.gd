class_name HurtBox
extends Area2D

# This is bad
@onready var dummy: AudioStreamPlayer = $"../../dummy"
@onready var audio_stream_player: AudioStreamPlayer = $"../../AudioStreamPlayer"

# TODO: move this to a library somewhere
func layer_num_to_layer_val(layer_value: int) -> int:
    return 2**(layer_value - 1)

func _init():
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
        dummy.play()
        audio_stream_player.play()
        show_num(randi()% 10000 + 50000, hitbox.position)

func show_num(val: int, pos: Vector2):
    var is_critical = (randi() % 100) > 80
    var number = Label.new()
    number.global_position = position
    number.text = str(val)
    number.z_index = 5
    number.label_settings = LabelSettings.new()
    
    var colour = "#FFF" # white
    if is_critical:
        number.text = str(val * 2) + "!"
        colour = "#B22"
        
    number.label_settings.font_color = colour
    number.label_settings.font_size = 10
    number.label_settings.outline_color = "#000"
    number.label_settings.outline_size = 1
    call_deferred("add_child", number)
    
    await number.resized
    number.pivot_offset = Vector2(number.size / 2)
    var tween  = get_tree().create_tween()
    tween.set_parallel(true)
    tween.tween_property(
        number, "position:y", number.position.y - 24, 0.25
    ).set_ease(Tween.EASE_OUT)
    tween.tween_property(
        number, "position:y", number.position.y - 24, 0.25
    ).set_ease(Tween.EASE_IN).set_delay(0.25)
    
    tween.tween_property(
        number, "scale", Vector2.ZERO, 0.25
    ).set_ease(Tween.EASE_IN).set_delay(0.5)
    
    await tween.finished
    number.queue_free()

    
