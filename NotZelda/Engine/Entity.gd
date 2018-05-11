extends KinematicBody2D

const SPEED = 0
				
var moveDir = Directions.center
var spriteDir = "down"


func movement_loop():
	var motion = moveDir.normalized() * SPEED
	move_and_slide(motion, Directions.center)
	
func spriteDir_loop():
	match moveDir:
		Directions.left:
			spriteDir = "left"
		Directions.right:
			spriteDir = "right"
		Directions.up:
			spriteDir = "up"
		Directions.down:
			spriteDir = "down"
			
func anim_switch(animation):
	var new_anim = str(animation, spriteDir)
	if $Anim.current_animation != new_anim:
		$Anim.play(new_anim)
