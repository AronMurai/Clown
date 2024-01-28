extends Node

func _on_end_of_game_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file("res://cutscenes/ending_cutscene.tscn")
