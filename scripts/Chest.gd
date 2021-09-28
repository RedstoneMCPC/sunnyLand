extends Node2D
class_name Chest

func doChestThings():
	$AnimatedSprite.play("open")
	$CollisionShape2D.disabled = true
