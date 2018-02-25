extends Node

var ID #Each tree node needs a numerical identifier
var edges #Edges will be an array of edges that are connected to the node

func _add_edge(Edge e):
	edges.append(e)
	pass

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
