extends KinematicBody2D

const TYPE = "ENEMY"
const SPEED = 0

var move_dir = Directions.center
var knock_dir = Directions.center
var sprite_dir = "down"

var hit_stun = 0
var health = 1


func movement_loop():
	var motion
	if hit_stun == 0:
		motion = move_dir.normalized() * SPEED
	else:
		motion = knock_dir.normalized() * SPEED * 1.5
	
	move_and_slide(motion, Directions.center)
	
	
func sprite_dir_loop():
	match move_dir:
		Directions.left:
			sprite_dir = "left"
		Directions.right:
			sprite_dir = "right"
		Directions.up:
			sprite_dir = "up"
		Directions.down:
			sprite_dir = "down"
	
			
func anim_switch(animation):
	var new_anim = str(animation, sprite_dir)
	if $Anim.current_animation != new_anim:
		$Anim.play(new_anim)


func damage_loop():
	if hit_stun > 0:
		hit_stun -= 1
		
	for body in $Hitbox.get_overlapping_bodies():
		if hit_stun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hit_stun = 10
			knock_dir = transform.origin - body.transform.origin
