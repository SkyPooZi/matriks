import 'package:flutter/material.dart';

class MatrixOperationScreen extends StatefulWidget {
  final int rows;
  final int cols;

  const MatrixOperationScreen({Key? key, required this.rows, required this.cols}) : super(key: key);

  @override
  State<MatrixOperationScreen> createState() => _MatrixOperationScreenState();
}

class _MatrixOperationScreenState extends State<MatrixOperationScreen> {
  List<List<TextEditingController>> matrixAControllers = [];
  List<List<TextEditingController>> matrixBControllers = [];
  List<List<int>> resultMatrix = [];

  void initializeControllers() {
    matrixAControllers = List.generate(
      widget.rows,
          (i) => List.generate(widget.cols, (j) => TextEditingController()),
    );

    matrixBControllers = List.generate(
      widget.rows,
          (i) => List.generate(widget.cols, (j) => TextEditingController()),
    );

    resultMatrix = List.generate(
      widget.rows,
          (i) => List.generate(widget.cols, (j) => 0),
    );
  }

  void performMatrixOperation(String operation) {
    setState(() {
      for (int i = 0; i < matrixAControllers.length; i++) {
        for (int j = 0; j < matrixAControllers[0].length; j++) {
          int valueA = int.tryParse(matrixAControllers[i][j].text) ?? 0;
          int valueB = int.tryParse(matrixBControllers[i][j].text) ?? 0;

          if (operation == 'add') {
            resultMatrix[i][j] = valueA + valueB;
          } else if (operation == 'subtract') {
            resultMatrix[i][j] = valueA - valueB;
          } else if (operation == 'multiply') {
            int sum = 0;
            for (int k = 0; k < matrixAControllers[0].length; k++) {
              int valueMatrixA = int.tryParse(matrixAControllers[i][k].text) ?? 0;
              int valueMatrixB = int.tryParse(matrixBControllers[k][j].text) ?? 0;
              sum += valueMatrixA * valueMatrixB;
            }
            resultMatrix[i][j] = sum;
          }
        }
      }
    });
  }

  void resetMatrices() {
    setState(() {
      for (int i = 0; i < matrixAControllers.length; i++) {
        for (int j = 0; j < matrixAControllers[0].length; j++) {
          matrixAControllers[i][j].text = '';
          matrixBControllers[i][j].text = '';
        }
      }
      resultMatrix = List.generate(
        widget.rows,
            (i) => List.generate(widget.cols, (j) => 0),
      );
    });
  }

  @override
  void dispose() {
    for (int i = 0; i < matrixAControllers.length; i++) {
      for (int j = 0; j < matrixAControllers[0].length; j++) {
        matrixAControllers[i][j].dispose();
        matrixBControllers[i][j].dispose();
      }
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrix Operations', style: TextStyle(color: Colors.white)), // Warna judul AppBar
        backgroundColor: Colors.black, // Warna latar belakang AppBar
      ),
      body: Container(
        color: Colors.black, // Warna latar belakang body
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildMatrixInput(matrixAControllers, 'Matrix A'),
            SizedBox(height: 16),
            _buildMatrixInput(matrixBControllers, 'Matrix B'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => performMatrixOperation('add'),
                  child: Text('+', style: TextStyle(color: Colors.black)), // Warna teks tombol
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Warna latar belakang tombol
                  ),
                ),
                ElevatedButton(
                  onPressed: () => performMatrixOperation('subtract'),
                  child: Text('-', style: TextStyle(color: Colors.black)), // Warna teks tombol
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Warna latar belakang tombol
                  ),
                ),
                ElevatedButton(
                  onPressed: () => performMatrixOperation('multiply'),
                  child: Text('X', style: TextStyle(color: Colors.black)), // Warna teks tombol
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Warna latar belakang tombol
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Result Matrix:',
              style: TextStyle(fontSize: 18, color: Colors.white), // Warna teks
            ),
            _buildMatrix(resultMatrix),
            ElevatedButton(
              onPressed: resetMatrices,
              child: Text('Reset', style: TextStyle(color: Colors.black)), // Warna teks tombol reset
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Warna latar belakang tombol reset
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatrixInput(List<List<TextEditingController>> controllers, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title + ':',
          style: TextStyle(fontSize: 18, color: Colors.white), // Warna teks
        ),
        Column(
          children: controllers.asMap().entries.map((entry) {
            List<TextEditingController> rowControllers = entry.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: rowControllers.asMap().entries.map((entry) {
                TextEditingController controller = entry.value;
                return Container(
                  padding: EdgeInsets.all(8),
                  width: 65,
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white), // Warna teks inputan
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.white), // Warna hint
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMatrix(List<List<int>> matrix) {
    return Column(
      children: matrix.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.map((value) {
            return Container(
              padding: EdgeInsets.all(8),
              child: Text(
                value.toString(),
                style: TextStyle(fontSize: 18, color: Colors.white), // Warna teks
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
