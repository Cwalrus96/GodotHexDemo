extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#TODO - create an array of ListNodes, and an array of sets. Each ListNode should contain a hexagon
#Every wall between two nodes should be considered an edge
#Create a set of edges, and loop through them randomly until the set is empty 


#Kruskal's Algorithm - Every small hex is a separate node, with connecting edges between them. 
#Choose a wall at random, and see if the two hexes that it connects are in the same tree (compare the roots) 
#If they are in the same tree, discard the edge 
#If not, remove the wall between them and combine the trees. 

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#pack the "Small hexagon" scene, then instance it in a grid to cover the large hexagon
	var gridSize = 11.0
	var smallHex = preload("res://Small Hexagon.tscn")
	var hexWall = preload("res://Hex Wall.tscn")
	var hexEdge = preload("res://HexEdge.tscn")
	#var hexList = LinkedList.new() 
	var hexList = []  #This will be a 2 dimensional array that holds all the hexagons in their proper positions 
	#var setList = LinkedList.new() 
	var setList = []  #This list will be an array of numbers that represent which set each hexagon belongs to. 
	var edgeSet = []  #This list will hold all of the edges

	var setNum = 0
	for i in range(gridSize): #Generate the hexagon grid with uneven rows 
		var rows = gridSize - abs(((gridSize - 1.0) / 2.0) - i)
		var offset = (rows - 1.0) / -2.0
		var hexRow = []
		var setRow = []
		for j in range(rows): 
			var node = smallHex.instance() #Create, scale, and position all the hexagons 
			add_child(node)
			node.set_scale(Vector3(1.0/gridSize, 1.0 / gridSize, 1.0 / gridSize))
			node.set_translation(Vector3((offset + j) * (40.0 / gridSize), 0.55, ( ((gridSize - 1.0) / -2.0) + i) * (36.0 / gridSize)))
			var wall2 = node.get_node("MeshInstance/Wall2")
			var wall3 = node.get_node("MeshInstance/Wall3")
			var wall1 = node.get_node("MeshInstance/Wall1")
			var wall4 = node.get_node("MeshInstance/Wall4")
			var wall5 = node.get_node("MeshInstance/Wall5")
			var wall6 = node.get_node("MeshInstance/Wall6")
			if((i != 0)):  #These statements will free all unnecessary Walls to prevent doubling up 
				if((i <= ((gridSize - 1.0) / 2.0)) && (j != 0)):
					wall2.queue_free()
				if((i <= ((gridSize - 1.0) / 2.0)) && (j != (rows - 1))): 
					wall3.queue_free()
				if(i > ((gridSize - 1.0) / 2.0)):
					wall2.queue_free()
					wall3.queue_free()
			if(j != 0): 
				wall1.queue_free()
					
			hexRow.append(node)
			setRow.append(setNum)
			setNum = setNum + 1
			
		hexList.append(hexRow)
		setList.append(setRow)

	for i in range(gridSize): 
		var rows = gridSize - abs(((gridSize - 1.0) / 2.0) - i) #Create the list of edges using walls 4, 5 and 6 (if possible) 
		var offset = (rows - 1.0) / -2.0
		for j in range(rows):  
			if(i >= ((gridSize - 1.0) / 2.0)): #Checks if hex is in the bottom half of the map 
				if((j != 0) && (i != gridSize - 1)):  #If it is, should not add edges on outside of grid. 
					var edge = hexEdge.instance()
					edge.wall = hexList[i][j].get_node("MeshInstance/Wall6")
					edge.nodeAY = i
					edge.nodeAX = j
					edge.nodeBY = i + 1
					edge.nodeBX = j - 1
					edgeSet.append(edge)
				if((j != (rows - 1.0)) && (i != gridSize - 1)): 
					var edge = hexEdge.instance()
					edge.wall = hexList[i][j].get_node("MeshInstance/Wall5")
					edge.nodeAY = i
					edge.nodeAX = j
					edge.nodeBY = i + 1
					edge.nodeBX = j
					edgeSet.append(edge)
			else:
				var edge = hexEdge.instance()
				edge.wall = hexList[i][j].get_node("MeshInstance/Wall6")
				edge.nodeAY = i
				edge.nodeAX = j
				edge.nodeBY = i + 1
				edge.nodeBX = j
				edgeSet.append(edge)
				var edge2 = hexEdge.instance()
				edge2.wall = hexList[i][j].get_node("MeshInstance/Wall5")
				edge2.nodeAY = i
				edge2.nodeAX = j
				edge2.nodeBY = i + 1
				edge2.nodeBX = j + 1
				edgeSet.append(edge2)	
			if(j != (rows - 1.0)): 
				var edge = hexEdge.instance()
				edge.wall = hexList[i][j].get_node("MeshInstance/Wall4")
				edge.nodeAY = i
				edge.nodeAX = j
				edge.nodeBY = i
				edge.nodeBX = j + 1
				edgeSet.append(edge)
	var randNum
	while(edgeSet.empty() == false) : #loop through all edges until they are all gone 
		randNum = randi() % edgeSet.size()
		var e = hexEdge.instance()  
		e = edgeSet[randNum]
		var AY = e.nodeAY
		var AX = e.nodeAX
		var BY = e.nodeBY
		var BX = e.nodeBX
		if(setList[AY][AX] == setList[BY][BX]): #This is the case where they already are part of the same set 
			edgeSet.remove(randNum) 
		else: #Case where they are in different sets - free the wall, remove the edge, join the sets 
			e.wall.queue_free()
			var numA = setList[AY][AX] 
			var numB = setList[BY][BX] 
			edgeSet.remove(randNum)
			for i in range(setList.size()): 
				for j in range(setList[i].size()): 
					if (setList[i][j] == numB): 
						setList[i][j] = numA 

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
