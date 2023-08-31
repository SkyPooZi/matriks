import 'package:flutter/material.dart';
import 'package:matriks/MatrixOperationScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int rows = 2; // Nilai default
  int cols = 2; // Nilai default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Matrix Operations',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/matrix.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Masukkan jumlah baris dan kolom:',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kolom:',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  DropdownButton<int>(
                    value: cols,
                    onChanged: (newValue) {
                      setState(() {
                        cols = newValue!;
                      });
                    },
                    dropdownColor: Colors.black, // Ubah warna latar belakang dropdown
                    items: [1, 2, 3, 4, 5].map((value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString(), style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Baris:',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  DropdownButton<int>(
                    value: rows,
                    onChanged: (newValue) {
                      setState(() {
                        rows = newValue!;
                      });
                    },
                    dropdownColor: Colors.black, // Ubah warna latar belakang dropdown
                    items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString(), style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatrixOperationScreen(rows: rows, cols: cols),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                ),
                child: Text('Masuk'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
