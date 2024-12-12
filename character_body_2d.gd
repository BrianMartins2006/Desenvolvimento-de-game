extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
@onready var anin = $animacao as AnimatedSprite2D
var Pulando = false 
var poder = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		Pulando = true 
		
	if is_on_floor():
		Pulando = false 
		
	else: 
		Pulando = true	
			
	if Input.is_action_just_pressed("ui_accept"):
		poder = true
		anin.play("poder")
		
		
	
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anin.scale.x = direction
		if !Pulando:
			anin.play("Correndo")
		elif Pulando: 
			anin.play("Pulando")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if Pulando: 
			anin.play ("Pulando")
		elif poder:
			anin.play("poder")
		else:
			anin.play ("Parado")
			
			
		
		
		
	if position.y > 800:
		position.y = -60
		

	move_and_slide()
