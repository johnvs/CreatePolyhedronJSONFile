/**
 * This program generates/transfers two sets of data, that define a polyhedron, to
 * a file in the JSON format.
 * First, it generates the coordinates for the verticies of the polyhedron.
 * Then it stores those coordinates and groups of verticies that define the 
 * faces of the polyhedron.
 *
 * Here is what the JSON looks like (partial):
 *
{
  "coordinates": [
    {
      "x": 0.0,
      "y": "0.288742191"
      "z": "0.745624566"
    },
    {
      "x": 0.0,
      "y": "0.288742191"
      "z": "0.745624566"
    }
  ],
  "verticies": [
    {
      "v1": 3,
      "v2": 11,
      "v3": 7
    },
    {
      "v1": 3,
      "v2": 11,
      "v3": 7
    }
  ]
}

{
  "face": [
    {
      "v1": [
        {
          "x": 0.0,
          "y": "0.288742191",
          "z": "0.745624566"
        }
      ],
      "v2": [
        {
          "x": 0.0,
          "y": "0.288742191",
          "z": "0.745624566"
        }
      ],
      "v3": [
        {
          "x": 0.0,
          "y": "0.288742191",
          "z": "0.745624566"
        }
      ]
    }
  ]
}

*/

private float edgeLength;
private float edgeLengthHalf;
private  float radius1;
private  float radius2Minor;
private  float radius2Major;
private  float hgt;
private  float hgtHalf;
private  float hgtThreeHalves;

private final int NUM_VERTICIES = 14;
private PVector[] vertexCoords = new PVector[NUM_VERTICIES];  // Stores the coordinates of all the verticies

private int[][] vertexGroup = 
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

void setup() {
  size(100, 100);
  generateData(1);
  createFile();
}

void draw() {
}

void generateData(int edgeLen) {
  
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

void createFile() {
  
  // Create a new coordinate JSON array
  JSONArray coordJArray = new JSONArray();

  // Create the vertex coordinates JSON objects
  for (int i = 0; i < vertexCoords.length; ++i) {
    JSONObject newCoordinate = new JSONObject();
    newCoordinate.setFloat("x", vertexCoords[i].x);
    newCoordinate.setFloat("y", vertexCoords[i].y);
    newCoordinate.setFloat("z", vertexCoords[i].z);

    coordJArray.setJSONObject(i, newCoordinate);
  }
  
  JSONObject polyhedron = new JSONObject();
  polyhedron.setJSONArray("verticies", coordJArray);

  // Create a new vertex JSON array 
  JSONArray vertexJArray = new JSONArray();
  
  // Write the face vertex data to the file
  for (int i = 0; i < vertexGroup.length; ++i) {
    JSONObject newVertex = new JSONObject();
    newVertex.setInt("v1", vertexGroup[i][0]);
    newVertex.setInt("v2", vertexGroup[i][1]);
    newVertex.setInt("v3", vertexGroup[i][2]);

    vertexJArray.setJSONObject(i, newVertex);
  }

  polyhedron.setJSONArray("faces", vertexJArray);

  // Write the coordinate data to the file.
  saveJSONObject(polyhedron, "data/tetrahedron.json");  
  
}

/*
void loadData() {

  // A JSON object
  JSONObject json;

  // Load JSON file
  // Temporary full path until path problem resolved.
  json = loadJSONObject("data.json");

  JSONArray coordData = json.getJSONArray("coordinates");
  JSONArray vertexData = json.getJSONArray("verticies");

  // The size of the array of Coordinate objects is determined by the total number of  
  // elements named "coordinate"
  coordinates = new Coordinate[coordData.size()]; 

  for (int i = 0; i < coordData.size(); ++i) {
    // Get each object in the array
    JSONObject coordinate = coordData.getJSONObject(i); 
    // Get a coordinate object
    float x = coordinate.getFloat("x");
    float y = coordinate.getFloat("y");
    float z = coordinate.getFloat("z");

    // Put object in array
    coordinates[i] = new Coordinate(x, y, z);
  }
}
*/