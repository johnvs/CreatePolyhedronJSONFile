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
  
  private float edgeLength;
  private float edgeLengthHalf;
  private float radius1;
  private float radius2Minor;
  private float radius2Major;
  private float hgt;
  private float hgtHalf;
  private float hgtThreeHalves;
  
  private final int NUM_VERTICES = 14;
  private PVector[] vertexCoords = new PVector[NUM_VERTICES];  // Stores the coordinates of all the vertices
  
  Tetrahedron () {
    
    
  }
  
  private int[][] faces = 
    { 
      { 3, 11,  7}, {11, 10,  7}, {10,  3,  7}, 
      { 2, 10,  9}, {10, 12,  9}, {12,  2,  9}, 
      { 1, 12,  8}, {12, 11,  8}, {11,  1,  8}, 
      { 1,  3,  0}, { 3,  2,  0}, { 2,  1,  0}, 
      {11,  3,  4}, { 3,  1,  4}, { 1, 11,  4}, 
      {12,  1,  5}, { 1,  2,  5}, { 2, 12,  5}, 
      {10,  2,  6}, { 2,  3,  6}, { 3, 10,  6}, 
      {10, 11, 13}, {11, 12, 13}, {12, 10, 13} 
    };

  public void generateData(int edgeLen) {
    
    edgeLength = edgeLen;                   // 1.0
    edgeLengthHalf = edgeLength/2;          // 0.5
    radius1 = edgeLength / (2*sqrt(3));     // 0.288 675 134
    radius2Minor = edgeLength / sqrt(3);    // 0.577 350 269
    radius2Major = 2 * radius2Minor;        // 1.154 700 538
    hgt = edgeLength * sqrt(2.0 / 3.0);     // 0.816 496 580
    hgtHalf = hgt/2.0;                      // 0.408 248 290
    hgtThreeHalves = 3.0 * hgtHalf;         // 1.224 744 871
    //println("radius1 = ", radius1);
    //println("radius2 = ", radius2);
    //println("hgt = ", hgt);
  
    vertexCoords[0] =  new PVector(            0.0,           0.0,  hgtThreeHalves); 
    vertexCoords[1] =  new PVector(            0.0, -radius2Minor,         hgtHalf); 
    vertexCoords[2] =  new PVector( edgeLengthHalf,       radius1,         hgtHalf); 
    vertexCoords[3] =  new PVector(-edgeLengthHalf,       radius1,         hgtHalf); 
    vertexCoords[4] =  new PVector(    -edgeLength, -radius2Minor,         hgtHalf); 
    vertexCoords[5] =  new PVector(     edgeLength, -radius2Minor,         hgtHalf); 
    vertexCoords[6] =  new PVector(            0.0,  radius2Major,         hgtHalf); 
    vertexCoords[7] =  new PVector(    -edgeLength,  radius2Minor,        -hgtHalf); 
    vertexCoords[8] =  new PVector(            0.0, -radius2Major,        -hgtHalf); 
    vertexCoords[9] =  new PVector(     edgeLength,  radius2Minor,        -hgtHalf); 
    vertexCoords[10] = new PVector(            0.0,  radius2Minor,        -hgtHalf); 
    vertexCoords[11] = new PVector(-edgeLengthHalf,      -radius1,        -hgtHalf); 
    vertexCoords[12] = new PVector( edgeLengthHalf,      -radius1,        -hgtHalf); 
    vertexCoords[13] = new PVector(            0.0,           0.0, -hgtThreeHalves); 
  
  }

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
    saveJSONArray(facesJsonArray, "data/tetrahedron.json");
  }

}