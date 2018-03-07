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

class Icosahedron {

  private final float PHI_HALF = ( (1.0 + sqrt(5)) / 2.0 ) / 2.0;

  private final int NUM_VERTICES = 12;

  private final int[][] faces =
    {
      { 0,  1,  3}, { 0,  3,  7}, { 0,  7,  4}, { 0,  4,  2}, { 0,  2,  1}, 
      { 1,  2,  5}, { 1,  5,  6}, { 1,  6,  3}, { 3,  9,  7}, { 3,  6,  9}, 
      { 2,  4,  8}, { 2,  8,  5}, {11, 10,  8}, {11,  8,  5}, {11,  5,  6}, 
      {11,  6,  9}, {11,  9, 10}, {10,  9,  7}, {10,  7,  4}, {10,  4,  8}
    };

  // private float edgeLength;
  private float edgeLengthHalf;
  // private float phiHalf;
  // private float radius2Minor;
  // private float radius2Major;
  // private float hgt;
  // private float hgtHalf;
  // private float hgtThreeHalves;

  private PVector[] vertexCoords;  // Stores the coordinates of all the vertices

  public Icosahedron (float edgeLen) {
    vertexCoords = new PVector[NUM_VERTICES];  // Stores the coordinates of all the vertices

    edgeLengthHalf = edgeLen / 2;          // 0.5

    vertexCoords[0]  =  new PVector(-edgeLengthHalf,             0.0,        PHI_HALF);
    vertexCoords[1]  =  new PVector( edgeLengthHalf,             0.0,        PHI_HALF);
    vertexCoords[2]  =  new PVector(            0.0,       -PHI_HALF,  edgeLengthHalf);
    vertexCoords[3]  =  new PVector(            0.0,        PHI_HALF,  edgeLengthHalf);
    vertexCoords[4]  =  new PVector(      -PHI_HALF, -edgeLengthHalf,             0.0);
    vertexCoords[5]  =  new PVector(       PHI_HALF, -edgeLengthHalf,             0.0);
    vertexCoords[6]  =  new PVector(       PHI_HALF,  edgeLengthHalf,             0.0);
    vertexCoords[7]  =  new PVector(      -PHI_HALF,  edgeLengthHalf,             0.0);
    vertexCoords[8]  =  new PVector(            0.0,       -PHI_HALF, -edgeLengthHalf);
    vertexCoords[9]  =  new PVector(            0.0,        PHI_HALF, -edgeLengthHalf);
    vertexCoords[10] =  new PVector(-edgeLengthHalf,             0.0,       -PHI_HALF);
    vertexCoords[11] =  new PVector( edgeLengthHalf,             0.0,       -PHI_HALF);
  }

/*
  public void generateData(float edgeLen) {
    vertexCoords = new PVector[faces.length];  // Stores the coordinates of all the vertices

    // edgeLength = edgeLen;                   // 1.0
    edgeLengthHalf = edgeLen / 2;          // 0.5
    // radius1 = edgeLength / (2*sqrt(3));     // 0.288 675 134
    // radius2Minor = edgeLength / sqrt(3);    // 0.577 350 269
    // radius2Major = 2 * radius2Minor;        // 1.154 700 538
    // hgt = edgeLength * sqrt(2.0 / 3.0);     // 0.816 496 580
    // hgtHalf = hgt/2.0;                      // 0.408 248 290
    // hgtThreeHalves = 3.0 * hgtHalf;         // 1.224 744 871
    //println("radius1 = ", radius1);
    //println("radius2 = ", radius2);
    //println("hgt = ", hgt);

    vertexCoords[0]  =  new PVector(-edgeLengthHalf,             0.0,        PHI_HALF);
    vertexCoords[1]  =  new PVector( edgeLengthHalf,             0.0,        PHI_HALF);
    vertexCoords[2]  =  new PVector(            0.0,       -PHI_HALF,  edgeLengthHalf);
    vertexCoords[3]  =  new PVector(            0.0,        PHI_HALF,  edgeLengthHalf);
    vertexCoords[4]  =  new PVector(      -PHI_HALF, -edgeLengthHalf,             0.0);
    vertexCoords[5]  =  new PVector(       PHI_HALF, -edgeLengthHalf,             0.0);
    vertexCoords[6]  =  new PVector(       PHI_HALF,  edgeLengthHalf,             0.0);
    vertexCoords[7]  =  new PVector(      -PHI_HALF,  edgeLengthHalf,             0.0);
    vertexCoords[8]  =  new PVector(            0.0,       -PHI_HALF, -edgeLengthHalf);
    vertexCoords[9]  =  new PVector(            0.0,        PHI_HALF, -edgeLengthHalf);
    vertexCoords[10] =  new PVector(-edgeLengthHalf,             0.0,       -PHI_HALF);
    vertexCoords[11] =  new PVector( edgeLengthHalf,             0.0,       -PHI_HALF);
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
    saveJSONArray(facesJsonArray, "data/Icosahedron.json");
  }

}
