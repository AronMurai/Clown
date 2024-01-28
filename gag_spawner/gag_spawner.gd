class_name GagSpawner
extends Control

@export var player : Player
@export var activeGagResources : Array[GagResource]
@export var gags : Dictionary
@export var gagButton : PackedScene
@export var throwTime : float
@export var emptyTexture : Texture

var selectedGagResource : GagResource
var activeButtons : Dictionary 
var preview : Sprite2D

func _ready():
	create_buttons(activeGagResources)

func _unhandled_input(_event : InputEvent):
	var mousePosition = get_global_mouse_position()
	$Preview.global_position.x = 32 * round(mousePosition.x / 32)
	$Preview.global_position.y = 32 * round(mousePosition.y / 32)

	if Input.is_action_just_pressed("SPAWN_ITEM"):
		if is_valid_item_spawn(selectedGagResource):
			var selectedGag = gags[selectedGagResource.name].instantiate()
			var gagPosition = Vector2()
			gagPosition.x = 32 * round(mousePosition.x / 32)
			gagPosition.y = 32 * round(mousePosition.y / 32)
			#$GagHolder.add_child(selectedGag)
			throw_gag(selectedGag, gagPosition)
			activeButtons[selectedGagResource.name].activate_cooldown()

func update_buttons(gagResources : Array[GagResource]):
	selectedGagResource = null
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
	$Preview.texture = previewTexture

func is_valid_item_spawn(gagResource : GagResource) -> bool:
	if not selectedGagResource == null and not activeButtons[gagResource.name].is_on_cooldown():
		return true
	return false

func throw_gag(gag : Gag, gagPosition : Vector2):
	var thrownGag = Sprite2D.new()
	thrownGag.position = player.position
	thrownGag.texture = gag.gagResource.icon
	thrownGag.scale = Vector2(2.0, 2.0)
	$GagHolder.add_child(thrownGag)
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(thrownGag, "rotation", 270, throwTime)
	tween.tween_property(thrownGag, "position", gagPosition, throwTime)
	tween.set_parallel(false)
	tween.tween_callback(thrownGag.queue_free)
	tween.tween_callback($GagHolder.add_child.bind(gag))
	gag.position = gagPosition
	$Preview.texture = emptyTexture
	#tween.tween_callback($Sprite.set_modulate.bind(Color.BLUE)).set_delay(2)

