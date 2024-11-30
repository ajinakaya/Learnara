import 'package:flutter/material.dart';

class AddNumbers extends StatefulWidget {
  final TextEditingController? controller;
  const AddNumbers({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  AddNumbersState createState() => AddNumbersState();
}

class AddNumbersState extends State<AddNumbers> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final num1 = TextEditingController();
    final num2 = TextEditingController();
    final tot = TextEditingController();
    int result = 0;
    int sum = 0;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              const Text(
                "Add Two Numbers",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: num1,
                decoration: InputDecoration(
                  labelText: "Number 1",
                  labelStyle:
                  TextStyle(fontSize: 15, color: Colors.grey.shade400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: num2,
                decoration: InputDecoration(
                  labelText: "Number 2",
                  labelStyle:
                  TextStyle(fontSize: 15, color: Colors.grey.shade400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: tot,
                decoration: InputDecoration(
                  labelText: "Total",
                  labelStyle:
                  TextStyle(fontSize: 15, color: Colors.grey.shade400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  sum = int.parse(num1.text) + int.parse(num2.text);
                  result = sum;
                  tot.text = result.toString();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height / 14,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}