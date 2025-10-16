extends Animator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    animation_player_name = "run"
    print("Ready animation_player_name: ", animation_player_name)
    print(self.animation_player)
    print(self.animation_manager)
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
