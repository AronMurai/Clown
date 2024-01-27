extends Button

signal gag_selected(gagResource : GagResource)
var gagResource : Resource
var onCooldown : bool = false

func _process(_delta):
	$CooldownBar.value = $CooldownTimer.time_left

func _on_GagButton_pressed():
	emit_signal("gag_selected", gagResource)

func _on_CooldownTimer_timeout():
	onCooldown = false
	$CooldownTimer.stop()

func activate_cooldown():
	onCooldown = true
	$CooldownTimer.start()

func is_on_cooldown() -> bool:
	return onCooldown
