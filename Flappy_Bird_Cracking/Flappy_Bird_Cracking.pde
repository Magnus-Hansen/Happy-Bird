ArrayList<bird> population, saved;
ArrayList<pipe> pipes;
float TOTAL;
int Gens;
float counter;
void setup()
{
  size(640, 480);

  TOTAL = 500;
  pipes = new ArrayList<pipe>();
  population = new ArrayList<bird>();
  saved = new ArrayList<bird>();
  for (int i = 0; i < TOTAL; i++)
  {
    population.add(new bird());
  }
  counter = 0;
}

void draw()
{
  background(51);
  if (counter % 75 == 0)
  {
    pipes.add(new pipe());
  }

  for (int i = pipes.size()-1; i >= 0; i--)
  {
    pipe p = pipes.get(i);
    p.update();
    if (p.offscreen())
    {
      pipes.remove(i);
    }

    for (int j = population.size()-1; j >= 0; j--)
    {
      bird b = population.get(j);
      if (p.hit(b) || b.dead())
      {
        saved.add(b);
        population.remove(j);
      }
    }
  }

  if (population.size() == 0)
  {
    counter = 0;
    nextGeneration();
    pipes.clear();
    pipes.add(new pipe());
  }

  for (bird b : population)
  {
    b.show();
    b.update();
    b.think(pipes);
  }

  for (int i = pipes.size()-1; i >= 0; i--)
  {
    pipe p = pipes.get(i);
    p.show();
  }

  counter++;
}

String[][] stringify(Matrix a){
    String[][] result = new String[a.rows][a.cols];
    for (int i = 0; i < a.rows; i++){
      for (int j = 0; j < a.cols; j++){
        result[i][j] = i+" " + j+" " + a.values[i][j]+" ";
      }
    }
    return result;
  }
  
  Matrix random(int rows, int cols){
    Matrix result = new Matrix(rows, cols);
    result.randomize();
    return result;
  }
  
  Matrix subtract(Matrix a, Matrix b){
    Matrix result = new Matrix(a.rows, a.cols);
    for (int i = 0; i < a.rows; i++){
      for (int j = 0; j < a.cols; j++){
        result.values[i][j] = a.values[i][j] - b.values[i][j];
      }
    }

    return result;
  }
  
  Matrix FromArray(float[] arr){
    Matrix result = new Matrix(arr.length, 1);
    for (int i = 0; i < result.rows; i++){
      result.values[i][0] = arr[i];
    }
    return result;
  }
  
  Matrix transpose(Matrix a){
    Matrix result = new Matrix(a.cols, a.rows);
    for (int i = 0; i < a.rows; i++){
      for (int j = 0; j < a.cols; j++){
        result.values[j][i] = a.values[i][j];
      }
    }
    return result;
  }
  
  Matrix Product(Matrix first, Matrix second){
    if (first.cols != second.rows){
      return null;
    } else{
      Matrix a = first;
      Matrix b = second;
      Matrix result = new Matrix(a.rows, b.cols);
      for (int i = 0; i < result.rows; i++){
        for (int j = 0; j < result.cols; j++){
          float sum = 0;
          for (int k = 0; k < a.cols; k++){
            sum += a.values[i][k] * b.values[k][j];
          }
          result.values[i][j] = sum;
        }
      }
      return result;
    }
  }
