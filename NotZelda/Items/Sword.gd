extends Node2D

const DAMAGE = 1

var TYPE = null
var max_amount = 1


func _ready():
	TYPE = get_parent().TYPE
	$Anim.connect("animation_finished", self, "destroy")
	$Anim.play(str("swing_", get_parent().sprite_dir))
	
	if get_parent().has_method("state_swing"):
		get_parent().state = "swing"
		
	
func destroy(animation):
	if get_parent().has_method("state_swing"):
		get_parent().state = "default"
	
	queue_free()
	