extends KinematicBody2D

# Posição de destino
onready var sprite = $AnimatedSprite

# Velocidade do inimigo
var speed = 100

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready():
	pass

func _process(delta):
	# Calcula a distância até a posição de destino
	var player_position = GameManager.player_position
	var distance_to_position = player_position - global_position

	# Verifica se o inimigo já está próximo da posição de destino
	if distance_to_position.length() > 1:  # Ajuste o valor de tolerância conforme necessário
		# Calcula a direção para a posição de destino
		var input_vector = distance_to_position.normalized()

		# Calcula a velocidade desejada
		var target_velocity = input_vector * speed
		
		if input_vector.x > 0:
			sprite.flip_h = false
		elif input_vector.x < 0:
			sprite.flip_h = true

		# Move o inimigo na direção da posição de destino
		move_and_slide(target_velocity)
	else:
		# Opcional: Pare o inimigo ou execute outra lógica quando alcançar a posição de destino
		move_and_slide(Vector2.ZERO)
