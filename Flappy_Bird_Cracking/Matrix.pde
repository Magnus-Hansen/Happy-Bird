class Matrix{
  int rows, cols;
  float[][] values;

  Matrix(int rows, int cols){
    this.rows = rows;
    this.cols = cols;
    values = new float[this.rows][this.cols];
  }

  Matrix(){
    rows = 1;
    cols = 1;
    values = new float[rows][cols];
  }

  Matrix copy(){
    Matrix result = new Matrix(rows, cols);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        result.values[i][j] = values[i][j];
      }
    }
    return result;
  }

  void multiply(float n){
    for (int i = 0; i < rows; i++){
      for (int j = 0; j < cols; j++){
        values[i][j] *= n;
      }
    }
  }

  void add(float n){
    for (int i = 0; i < rows; i++){
      for (int j = 0; j < cols; j++){
        values[i][j] += n;
      }
    }
  }

  void randomize(){
    for (int i = 0; i < rows; i++){
      for (int j = 0; j < cols; j++){
        values[i][j] = (float) Math.random() * 2 - 1;
      }
    }
  }

  float[] toArray(){
    float[] arr = new float[rows+cols];
    for (int i = 0; i < rows; i++){
      for (int j = 0; j < cols; j++){
        arr[i] = values[i][j];
      }
    }
    return arr;
  }

  void add(Matrix other){
    for (int i = 0; i < rows; i++){
      for (int j = 0; j < cols; j++){
        values[i][j] += other.values[i][j];
      }
    }
  }

  void multiply(Matrix other){
    for (int i = 0; i < rows; i++){
      for (int j = 0; j < cols; j++){
        values[i][j] *= other.values[i][j];
      }
    }
  }
}
