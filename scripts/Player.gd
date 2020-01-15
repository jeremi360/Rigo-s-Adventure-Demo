extends RigidBody2D

export var speed := 200
export var jump_high := 100
export (PackedScene) var bullet_scene
export var bullet_speed := 100 

var bonus_jump_high : = 0
var dright := true # jeśli true to gracz jest skierowany w prawo, jeśli false to w lewo
var normal_scale : Vector2

func _ready():
	normal_scale = $Sprite.scale
	
func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_right"):
		dright = true
		linear_velocity.x += speed * delta
		$Sprite.scale.x = normal_scale.x
	
	if Input.is_action_pressed("ui_left"):
		dright = false
		linear_velocity.x -= speed * delta
		$Sprite.scale.x = -normal_scale.x
	
	if Input.is_action_just_pressed("ui_select"):
		if $RayCast2D.is_colliding():
			linear_velocity.y -= jump_high + bonus_jump_high
	
	if Input.is_action_just_pressed("shoot"):
		var b = bullet_scene.instance()
		b.position = position
		b.linear_velocity.x = bullet_speed
		
		if dright:
			b.position.x += bullet_speed / 2.0

		else:
			b.linear_velocity *= -1
			b.position.x -= bullet_speed / 2.0
		
		get_parent().add_child(b)
		
		
		
		
		