extends "res://Engine/Entity.gd"

const DAMAGE = 1
const SPEED = 40

var move_timer = 0
var move_timer_length = 15


func _ready():
	$Anim.play("Default")
	move_dir = Directions.rand()
	
	
func _physics_process(delta):
	movement_loop()
	damage_loop()
	if move_timer > 0:
		move_timer -= 1
	if move_timer == 0 || is_on_wall():
		move_dir = Directions.rand()
		move_timer = move_timer_length
