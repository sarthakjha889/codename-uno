// MapNode class with generic type T, to store data of any type
class MapNode<T> {
  // Data stored in the MapNode
  T data;
  // X and Y coordinates of the MapNode
  int x;
  int y;

  // Pointers to adjacent MapNodes
  MapNode<T>? top;
  MapNode<T>? left;
  MapNode<T>? bottom;
  MapNode<T>? right;

  // Constructor to initialize the MapNode with data and coordinates
  MapNode(this.data, this.x, this.y);
}

// MapGraph class to manage the MapNodes
class MapGraph<T> {
  // Map to store the MapNodes with their coordinates as keys
  Map<String, MapNode<T>> mapNodes = {};

  MapNode<T>? getNode(int x, int y) {
    return mapNodes['$x,$y'];
  }

  // Function to add a new MapNode to the MapGraph
  void addMapNode(T data, int x, int y) {
    // Create a new MapNode with the given data and coordinates
    MapNode<T> newMapNode = MapNode<T>(data, x, y);

    // Check for adjacent MapNodes and connect them
    String key;

    // Check for a MapNode on the left
    key = '${x - 1},$y';
    if (mapNodes.containsKey(key)) {
      newMapNode.left = mapNodes[key];
      mapNodes[key]!.right = newMapNode;
    }

    // Check for a MapNode on the right
    key = '${x + 1},$y';
    if (mapNodes.containsKey(key)) {
      newMapNode.right = mapNodes[key];
      mapNodes[key]!.left = newMapNode;
    }

    // Check for a MapNode on the top
    key = '$x,${y - 1}';
    if (mapNodes.containsKey(key)) {
      newMapNode.top = mapNodes[key];
      mapNodes[key]!.bottom = newMapNode;
    }

    // Check for a MapNode on the bottom
    key = '$x,${y + 1}';
    if (mapNodes.containsKey(key)) {
      newMapNode.bottom = mapNodes[key];
      mapNodes[key]!.top = newMapNode;
    }

    // Add the new MapNode to the MapNodes map
    mapNodes['$x,$y'] = newMapNode;
  }
}
