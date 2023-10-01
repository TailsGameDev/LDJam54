extends Area2D

signal reached

func _on_body_entered(body):
	if body is Ship:
		reached.emit()