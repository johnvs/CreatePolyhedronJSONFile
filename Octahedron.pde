/**
 * This program generates/transfers two sets of data, that define a polyhedron, to
 * a file in the JSON format.
 * First, it generates the coordinates for the vertices of the polyhedron.
 * Then it stores those coordinates and groups of vertices that define the
 * faces of the polyhedron.
 *
 * Here is what the JSON looks like (partial):
 *

[
  [
    {
      "x": -0.5,
      "y": 0.28867512941360474,
      "z": 0.40824830532073975
    },
    {
      "x": -0.5,
      "y": -0.28867512941360474,
      "z": -0.40824830532073975
    },
    {
      "x": -1,
      "y": 0.5773502588272095,
      "z": -0.40824830532073975
    }
  ],
  [
    {
      "x": -0.5,
      "y": -0.28867512941360474,
      "z": -0.40824830532073975
    },
    {
      "x": 0,
      "y": 0.5773502588272095,
      "z": -0.40824830532073975
    },
    {
      "x": -1,
      "y": 0.5773502588272095,
      "z": -0.40824830532073975
    }
  ]
]

}

*/

class Octahedron {

  private final int NUM_VERTICES = 6;

  private final int[][] faces =
    {
      {0, 1, 2}, {0, 2, 3}, {0, 3, 4}, {0, 4, 1},
      {1, 5, 2}, {2, 5, 3}, {3, 5, 4}, {4, 5, 1}
    };

  private String name = "Octahedron";

  private float edgeLengthHalf;
  private float hgt;
  private float hgtHalf;

  private PVector[] vertexCoords;  // Stores the coordinates of all the vertices

  public Octahedron (float edgeLen) {
    vertexCoords = new PVector[NUM_VERTICES];  // Stores the coordinates of all the vertices

    edgeLengthHalf = edgeLen / 2;          // 0.5
    hgtHalf = edgeLen / sqrt(2.0);

    vertexCoords[0] =  new PVector(            0.0,             0.0,  hgtHalf);
    vertexCoords[1] =  new PVector(-edgeLengthHalf, -edgeLengthHalf,        0);
    vertexCoords[2] =  new PVector( edgeLengthHalf, -edgeLengthHalf,        0);
    vertexCoords[3] =  new PVector( edgeLengthHalf,  edgeLengthHalf,        0);
    vertexCoords[4] =  new PVector(-edgeLengthHalf,  edgeLengthHalf,        0);
    vertexCoords[5] =  new PVector(            0.0,             0.0, -hgtHalf);
  }

/*
  public void generateData(float edgeLen) {
    vertexCoords = new PVector[faces.length];  // Stores the coordinates of all the vertices

    edgeLengthHalf = edgeLen / 2;          // 0.5
    hgtHalf = edgeLen / sqrt(2.0);

    vertexCoords[0] =  new PVector(            0.0,             0.0,  hgtHalf);
    vertexCoords[1] =  new PVector(-edgeLengthHalf, -edgeLengthHalf,        0);
    vertexCoords[2] =  new PVector( edgeLengthHalf, -edgeLengthHalf,        0);
    vertexCoords[3] =  new PVector( edgeLengthHalf,  edgeLengthHalf,        0);
    vertexCoords[4] =  new PVector(-edgeLengthHalf,  edgeLengthHalf,        0);
    vertexCoords[5] =  new PVector(            0.0,             0.0, -hgtHalf);
  }
*/

  public void createFile() {

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
    saveJSONArray(facesJsonArray, "data/Octahedron.json");
  }

}
