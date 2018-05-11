extends "res://Engine/Entity.gd"

const SPEED = 70


func _physics_process(delta):
	controls_loop()
	movement_loop()
	spriteDir_loop()
	
	if is_on_wall():
		if spriteDir == "left" and test_move(transform, Directions.left):
			anim_switch("push_")
		if spriteDir == "right" and test_move(transform, Directions.right):
			anim_switch("push_")
		if spriteDir == "up" and test_move(transform, Directions.up):
			anim_switch("push_")
		if spriteDir == "down" and test_move(transform, Directions.down):
			anim_switch("push_")
	elif moveDir != Directions.center:
		anim_switch("walk_")
	else:
		anim_switch("idle_")

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	moveDir.x = -int(LEFT) + int(RIGHT)
	moveDir.y = -int(UP) + int(DOWN)
	