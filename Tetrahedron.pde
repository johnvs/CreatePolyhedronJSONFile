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

class Tetrahedron {

  private final int NUM_VERTICES = 4;

  private final int[][] faces = { {1, 3, 2}, {0, 1, 2}, {0, 2, 3}, {0, 3, 1} };

  private float edgeLengthHalf;
  private float radiusMinor;
  private float radiusMajor;
  private float hgt;
  private float hgtQuarter;
  private float hgtThreeQtrs;
  private PVector[] vertexCoords;  // Stores the coordinates of all the vertices

  public Tetrahedron (float edgeLen) {
    vertexCoords = new PVector[NUM_VERTICES];  // Stores the coordinates of all the vertices

    edgeLengthHalf = edgeLen / 2;                // 0.5
    radiusMinor    = edgeLen / (2 * sqrt(3));    // 0.577 350 269
    radiusMajor    = edgeLen / sqrt(3);          // 1.154 700 538
    hgt            = edgeLen * sqrt(2.0 / 3.0);  // 0.816 496 580
    hgtQuarter     = hgt / 4.0;                  //
    hgtThreeQtrs   = 3.0 * hgtQuarter;           //

    vertexCoords[0] =  new PVector(            0.0,          0.0, hgtThreeQtrs);
    vertexCoords[1] =  new PVector(-edgeLengthHalf,  radiusMinor,  -hgtQuarter);
    vertexCoords[2] =  new PVector(            0.0, -radiusMajor,  -hgtQuarter);
    vertexCoords[3] =  new PVector( edgeLengthHalf,  radiusMinor,  -hgtQuarter);
  }

/*
  public void generateData(float edgeLen) {
    vertexCoords = new PVector[faces.length];  // Stores the coordinates of all the vertices

    edgeLengthHalf = edgeLen / 2;                // 0.5
    radiusMinor    = edgeLen / (2 * sqrt(3));    // 0.577 350 269
    radiusMajor    = edgeLen / sqrt(3);          // 1.154 700 538
    hgt            = edgeLen * sqrt(2.0 / 3.0);  // 0.816 496 580
    hgtQuarter     = hgt / 4.0;                  //
    hgtThreeQtrs   = 3.0 * hgtQuarter;           //

    vertexCoords[0] =  new PVector(            0.0,          0.0, hgtThreeQtrs);
    vertexCoords[1] =  new PVector(-edgeLengthHalf,  radiusMinor,  -hgtQuarter);
    vertexCoords[2] =  new PVector(            0.0, -radiusMajor,  -hgtQuarter);
    vertexCoords[3] =  new PVector( edgeLengthHalf,  radiusMinor,  -hgtQuarter);
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
    saveJSONArray(facesJsonArray, "data/Tetrahedron.json");
  }

}
