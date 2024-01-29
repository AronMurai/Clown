extends Node

@export var player : Player
@export var explosion : PackedScene

func _on_end_of_game_body_entered(body):
	if body is Player:
		end_game()

func end_game():
	var giantExplosion = explosion.instantiate()
	add_child(giantExplosion)
	var tween = get_tree().create_tween()
	giantExplosion.position = $ExplosionPosition.position
	giantExplosion.scale = Vector2(4.0, 4.0)
	tween.set_parallel(true)
	tween.tween_property(player, "rotation", 270, 2)
	tween.tween_property(player, "position", $TentPosition.position, 2)
	tween.tween_property(player, "scale", Vector2(0.1, 0.1), 2)
	tween.set_parallel(false)
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://cutscenes/ending_cutscene.tscn")

func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
