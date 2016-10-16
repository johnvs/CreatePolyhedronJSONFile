/**
 * This program generates/transfers two sets of data, that define a polyhedron, to
 * a file in the JSON format.
 * First, it generates the coordinates for the vertices of the polyhedron.
 * Then it stores those coordinates and groups of vertices that define the
 * faces of the polyhedron.
 *
 * Here is what the JSON looks like (partial):
 */

private Tetrahedron tetrahedron;
private Cube cube;
private Octahedron octahedron;
private Icosahedron icosahedron;
private Dodecahedron dodecahedron;

void setup() {
  size(100, 100);
  dodecahedron = new Dodecahedron(1.0);
  dodecahedron.createFile();
  // octahedron = new Octahedron(1.0);
  // octahedron.createFile();
  // tetrahedron = new Tetrahedron(1.0);
  // tetrahedron.createFile();
  // cube = new Cube(1.0);
  // cube.createFile();

}

void draw() {
}

/*
void createFile() {

  // Create the outer (faces) JSON array
  JSONArray facesJsonArray = new JSONArray();

  // Write the face vertex data to the file
  for (int i = 0; i < faces.length; ++i) {

    // Create the inner (vertices) JSON array
    JSONArray vertexJSONArray = new JSONArray();

    // For each face vertex, create and fill the JSON coordinate object
    for (int j = 0; j < faces[i].length; ++j) {
      JSONObject coordJSONObj = new JSONObject();

      coordJSONObj.setFloat("x", vertexCoords[faces[i][j]].x);
      coordJSONObj.setFloat("y", vertexCoords[faces[i][j]].y);
      coordJSONObj.setFloat("z", vertexCoords[faces[i][j]].z);

      // Add the coordinate object to the vertex array
      vertexJSONArray.setJSONObject(j, coordJSONObj);
    }

    // Add the vertex array to the faces array
    facesJsonArray.setJSONArray(i, vertexJSONArray);
  }

  // Write the coordinate data to the file.
  String filename = "data/" + polyhedron.getName() + ".json");
  // saveJSONArray(facesJsonArray, "data/Octahedron.json");
  saveJSONArray(facesJsonArray, filename);
}
*/
