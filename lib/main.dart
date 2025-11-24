import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سفیراپ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const RequestPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'سفیراپ',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'هزینه سفر شما: \nآیا تمایل به ثبت درخواست خود دارید؟',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('لغو'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'تأیید',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('درخواست با موفقیت ثبت شد!'),
                    backgroundColor: Colors.green,
                  ),
                );

                _field1Controller.clear();
                _field2Controller.clear();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سفیراپ'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // TextField(
            //   controller: _field1Controller,
            //   textDirection: TextDirection.rtl,
            //   decoration: InputDecoration(
            //     labelText: 'عنوان درخواست',
            //     hintText: 'مثلاً: درخواست مرخصی',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // ),
            // text box 1
            const SizedBox(height: 20),
            TextField(
              controller: _field2Controller,
              textDirection: TextDirection.rtl,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'مبدا',
                hintText: 'مبدا خود را به این صورت وارد کنید: قم، بلوار عماریاسر، خیابان قدوسی، کوچه 1',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),

            // ## text box 2
            const SizedBox(height: 30),
            TextField(
              controller: _field1Controller,
              textDirection: TextDirection.rtl,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'مقصد',
                hintText: 'مقصد خود را به این صورت وارد کنید: قم، بلوار عماریاسر، خیابان قدوسی، کوچه 1',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),

            const SizedBox(height: 30),
            // ## button ##
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_field1Controller.text.trim().isEmpty ||
                      _field2Controller.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('لطفاً همه فیلدها را پر کنید'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // نمایش دیالوگ تأیید
                  _showConfirmationDialog();
                },
                child: const Text(
                  'ثبت درخواست',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _field1Controller.dispose();
    _field2Controller.dispose();
    super.dispose();
  }
}