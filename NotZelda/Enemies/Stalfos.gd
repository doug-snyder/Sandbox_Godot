extends "res://Engine/Entity.gd"

const SPEED = 40

var move_timer_length = 15
var move_timer = 0

func _ready():
	$Anim.play("Default")
	moveDir = Directions.rand()
	
func _physics_process(delta):
	movement_loop()
	if move_timer > 0:
		move_timer -= 1
	if move_timer == 0 || is_on_wall():
		moveDir = Directions.rand()
		move_timer = move_timer_length
