extends Area2D

export var value = 1
var collected = false

func _on_Collectable_body_entered(body):
	if collected == false and body.has_method("addScore"):
		collected = true
		$AnimatedSprite.play("collected")
		body.addScore(value)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "collected":
		queue_free()

