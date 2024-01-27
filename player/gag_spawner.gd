extends Control

@export var gags : Array[Resource]

var currentItemIndex = 0

func _input(event : InputEvent):
	if Input.is_action_just_pressed("SPAWN_ITEM"):
		var newGag = gags[currentItemIndex].instantiate()
		get_parent().get_parent().add_child(newGag)
		newGag.position = get_global_mouse_position()
	if Input.is_action_just_pressed("SCROLL_DOWN"):
		currentItemIndex = 0
	if Input.is_action_just_pressed("SCROLL_UP"):
		currentItemIndex = 1
