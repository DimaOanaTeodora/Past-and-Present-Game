extends 'res://addons/gut/test.gd'

var autoFree = load('res://addons/gut/autofree.gd').new()

func test_free_nodes_in_tree():
	
	var newNode = Node.new()
	add_child(newNode)
	autoFree.add_free(newNode)
	autoFree.free_all()
	assert_freed(newNode, 'node')
