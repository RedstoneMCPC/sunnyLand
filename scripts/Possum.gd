extends KinematicBody2D
class_name Possum

const GRAVITY = 10 * 60
const SPEED = -40 * 60
var velocity = Vector2()
var direction = 1
var alive = true

func _physics_process(delta):
	if alive == true:
		velocity.x = SPEED * direction * delta
		$AnimatedSprite.play("walk")
		velocity.y += GRAVITY * delta
		velocity = move_and_slide(velocity, Vector2(0, -1))
		
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		if is_on_wall():
			direction *= -1

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "deathAnim":
		queue_free()

func playEnemyDeathAnimation():
	alive = false
	$AnimatedSprite.play("deathAnim")
	$CollisionShape2D.disabled = true
