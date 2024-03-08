import 'package:flutter/material.dart';

class CalcAge extends StatefulWidget {
  const CalcAge({super.key});

  @override
  State<CalcAge> createState() => _CalcAgeState();
}

class _CalcAgeState extends State<CalcAge> {
  final TextEditingController controller = TextEditingController();
  final TextStyle style = const TextStyle(
    color: Colors.white,
    fontSize: 35,
    fontWeight: FontWeight.bold,
  );
  Color white = Colors.white;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget button() {
    return ElevatedButton(
      onPressed: onSubmit,
      child: const Text('Calculate 🔢'),
    );
  }

  void onSubmit() {
    try {
      var birth = int.parse(controller.text);
      var currentDate = DateTime.now().year;
      var age = currentDate - birth;

      if (birth >= currentDate) {
        _showErrorDialog(
            'The Birth Shouldn\'t be Greater Than Current Year Or Equal it!');
      } else {
        _showAgeDialog(age);
      }
    } catch (e) {
      _showErrorDialog('Invalid input: Please enter a valid year.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error:'),
        content: Text(message),
      ),
    );
  }

  void _showAgeDialog(int age) {
    setState(() {
      showDialog(
        builder: (context) => AlertDialog(
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Your Age Is ', style: TextStyle(color: white)),
                TextSpan(
                  text: '$age',
                  style: style,
                ),
                 TextSpan(
                    text: '.', style: TextStyle(color: white)),
              ],
            ),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        context: context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        controller.clear();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange.shade800,
          centerTitle: true,
          title: Text(
            'Age Calculator App',
            style: TextStyle(color: white),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: TextField(
                    onSubmitted: (value) {
                      Navigator.of(context);
                      onSubmit();
                      controller.clear();
                    },
                    controller: controller,
                    keyboardType: const TextInputType.numberWithOptions(),
                    maxLength: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'For Ex: 1997',
                      labelText: 'Input Your Age',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: button(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
