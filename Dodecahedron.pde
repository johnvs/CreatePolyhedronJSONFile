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

class Dodecahedron {

  private final int NUM_VERTICES = 20;

  private final int[][] faces =
    {
      { 0,  1,  2,  6,  3}, { 0,  3,  9, 10,  4}, { 0,  4,  7,  5,  1}, { 1,  5, 11,  8,  2},
      { 2,  8, 14, 12,  6}, { 3,  6, 12, 15,  9}, { 4, 10, 16, 13,  7}, { 5,  7, 13, 17, 11},
      {12, 14, 18, 19, 15}, { 9, 15, 19, 16, 10}, {13, 16, 19, 18, 17}, { 8, 11, 17, 18, 14}
    };

  private final float PHI = (1.0 + sqrt(5)) / 2.0;
  private final float ONE_OVER_PHI = 1.0 / ((1.0 + sqrt(5)) / 2.0);

  private PVector[] vertexCoords;  // Stores the coordinates of all the vertices

  public Dodecahedron (float edgeLen) {
    vertexCoords = new PVector[NUM_VERTICES];  // Stores the coordinates of all the vertices

    vertexCoords[0]  =  new PVector(-ONE_OVER_PHI,           0.0,           PHI);
    vertexCoords[1]  =  new PVector( ONE_OVER_PHI,           0.0,           PHI);
    vertexCoords[2]  =  new PVector(          1.0,           1.0,           1.0);
    vertexCoords[3]  =  new PVector(         -1.0,           1.0,           1.0);
    vertexCoords[4]  =  new PVector(         -1.0,          -1.0,           1.0);
    vertexCoords[5]  =  new PVector(          1.0,          -1.0,           1.0);
    vertexCoords[6]  =  new PVector(          0.0,           PHI,  ONE_OVER_PHI);
    vertexCoords[7]  =  new PVector(          0.0,          -PHI,  ONE_OVER_PHI);
    vertexCoords[8]  =  new PVector(          PHI,  ONE_OVER_PHI,           0.0);
    vertexCoords[9]  =  new PVector(         -PHI,  ONE_OVER_PHI,           0.0);
    vertexCoords[10] =  new PVector(         -PHI, -ONE_OVER_PHI,           0.0);
    vertexCoords[11] =  new PVector(          PHI, -ONE_OVER_PHI,           0.0);
    vertexCoords[12] =  new PVector(          0.0,           PHI, -ONE_OVER_PHI);
    vertexCoords[13] =  new PVector(          0.0,          -PHI, -ONE_OVER_PHI);
    vertexCoords[14] =  new PVector(          1.0,           1.0,          -1.0);
    vertexCoords[15] =  new PVector(         -1.0,           1.0,          -1.0);
    vertexCoords[16] =  new PVector(         -1.0,          -1.0,          -1.0);
    vertexCoords[17] =  new PVector(          1.0,          -1.0,          -1.0);
    vertexCoords[18] =  new PVector( ONE_OVER_PHI,           0.0,          -PHI);
    vertexCoords[19] =  new PVector(-ONE_OVER_PHI,           0.0,          -PHI);
  }

/*
  public void generateData(float edgeLen) {
    vertexCoords = new PVector[faces.length];  // Stores the coordinates of all the vertices

    // edgeLength = edgeLen;                   // 1.0

    vertexCoords[0]  =  new PVector(-ONE_OVER_PHI,           0.0,           PHI);
    vertexCoords[1]  =  new PVector( ONE_OVER_PHI,           0.0,           PHI);
    vertexCoords[2]  =  new PVector(          1.0,           1.0,           1.0);
    vertexCoords[3]  =  new PVector(         -1.0,           1.0,           1.0);
    vertexCoords[4]  =  new PVector(         -1.0,          -1.0,           1.0);
    vertexCoords[5]  =  new PVector(          1.0,          -1.0,           1.0);
    vertexCoords[6]  =  new PVector(          0.0,           PHI,  ONE_OVER_PHI);
    vertexCoords[7]  =  new PVector(          0.0,          -PHI,  ONE_OVER_PHI);
    vertexCoords[8]  =  new PVector(          PHI,  ONE_OVER_PHI,           0.0);
    vertexCoords[9]  =  new PVector(         -PHI,  ONE_OVER_PHI,           0.0);
    vertexCoords[10] =  new PVector(         -PHI, -ONE_OVER_PHI,           0.0);
    vertexCoords[11] =  new PVector(          PHI, -ONE_OVER_PHI,           0.0);
    vertexCoords[12] =  new PVector(          0.0,           PHI, -ONE_OVER_PHI);
    vertexCoords[13] =  new PVector(          0.0,          -PHI, -ONE_OVER_PHI);
    vertexCoords[14] =  new PVector(          1.0,           1.0,          -1.0);
    vertexCoords[15] =  new PVector(         -1.0,           1.0,          -1.0);
    vertexCoords[16] =  new PVector(         -1.0,          -1.0,          -1.0);
    vertexCoords[17] =  new PVector(          1.0,          -1.0,          -1.0);
    vertexCoords[18] =  new PVector( ONE_OVER_PHI,           0.0,          -PHI);
    vertexCoords[19] =  new PVector(-ONE_OVER_PHI,           0.0,          -PHI);
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
    saveJSONArray(facesJsonArray, "data/Dodecahedron.json");
  }

}
