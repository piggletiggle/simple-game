extends Area2D

@onready var game_state: Node = %GameState
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		animation_player.play("pickup" )
		game_state.increase_score(1)
