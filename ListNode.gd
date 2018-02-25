extends Node

var ID #Each list node needs a numerical identifier
var edges #Edges will be an array of edges that are connected to the node
var hex #This will keep a reference to the hexagon that is being referred to \
var next # This will reference the next node in the list 

func _add_edge(e):
	edges.append(e)
	pass

func _add_child

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
