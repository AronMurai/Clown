extends Control

@export var activeGagResources : Array[GagResource]
@export var gags : Dictionary
@export var gagButton : PackedScene

var selectedGagResource : GagResource
var activeButtons : Dictionary 
var preview : Sprite2D

func _ready():
	create_buttons(activeGagResources)

func _unhandled_input(event : InputEvent):
	if event is InputEventMouseMotion:
		if is_valid_item_spawn(selectedGagResource):
			if not preview == null:
				preview.global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("SPAWN_ITEM"):
		if is_valid_item_spawn(selectedGagResource):
			var selectedGag = gags[selectedGagResource.name].instantiate()
			$GagHolder.add_child(selectedGag)
			selectedGag.position = get_global_mouse_position()
			activeButtons[selectedGagResource.name].activate_cooldown()
			preview.queue_free()

func update_buttons(gagResources : Array[GagResource]):
	remove_buttons()
	create_buttons(gagResources)

func create_buttons(gagResources : Array[GagResource]):
	for gagResource in gagResources:
		create_button(gagResource)

func create_button(gagResource : GagResource):
	var newGagButton = gagButton.instantiate()
	newGagButton.gagResource = gagResource
	activeButtons[gagResource.name] = newGagButton
	newGagButton.get_node("GagIcon").texture = gagResource.icon
	newGagButton.get_node("CooldownBar").max_value = gagResource.spawnCooldown
	newGagButton.get_node("CooldownTimer").wait_time = gagResource.spawnCooldown
	newGagButton.gag_selected.connect(set_selected_gag)
	$GagButtonContainer.add_child(newGagButton)

func remove_buttons():
	for button in $GagButtonContainer.get_children():
		button.queue_free()
		activeButtons.clear()

func set_selected_gag(gagResource : GagResource):
	selectedGagResource = gagResource
	var previewTexture = selectedGagResource.icon
	preview = Sprite2D.new()
	preview.texture = previewTexture
	preview.scale = Vector2(2.0, 2.0)
	$GagHolder.add_child(preview)

func is_valid_item_spawn(gagResource : GagResource) -> bool:
	if not selectedGagResource == null and not activeButtons[gagResource.name].is_on_cooldown():
		return true
	return false
	
	
