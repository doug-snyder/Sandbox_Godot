extends "res://Engine/Entity.gd"

const TYPE = "PLAYER"
const SPEED = 70

var state = "default"


func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()
	
	
func state_default():
	controls_loop()
	movement_loop()
	sprite_dir_loop()
	damage_loop()
	
	if is_on_wall():
		if sprite_dir == "left" and test_move(transform, Directions.left):
			anim_switch("push_")
		if sprite_dir == "right" and test_move(transform, Directions.right):
			anim_switch("push_")
		if sprite_dir == "up" and test_move(transform, Directions.up):
			anim_switch("push_")
		if sprite_dir == "down" and test_move(transform, Directions.down):
			anim_switch("push_")
	elif move_dir != Directions.center:
		anim_switch("walk_")
	else:
		anim_switch("idle_")
		
		if Input.is_action_just_pressed("a"):
			use_item(preload("res://items/sword.tscn"))


func state_swing():
	anim_switch("idle_")
	movement_loop()
	damage_loop()
	move_dir = Directions.center


func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	move_dir.x = -int(LEFT) + int(RIGHT)
	move_dir.y = -int(UP) + int(DOWN)
	