extends Node

#Linked List should have a reference to the head (and tail? ) 
var head 
var tail 

func _add_node(node): 
	if(head == null): 
		head = node
		tail = node
	else: 
		tail.next = node
		tail = node 
	pass 
	
func _add_list(list): 
	tail.next = list.head 
	tail = list.tail 
	pass 
		

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
