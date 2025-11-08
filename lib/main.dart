import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(SmartCampusApp());

class SmartCampusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Campus App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: LoginScreen(),
    );
  }
}

// ---------- Student Model ----------
class Student {
  final String name;
  final String id;
  final String password;
  final String dept;
  final String institute;
  final String email;

  Student({
    required this.name,
    required this.id,
    required this.password,
    required this.dept,
    required this.institute,
    required this.email,
  });
}

// ---------- Demo Students ----------
final List<Student> demoStudents = [
  Student(
      name: "Tashik Miah",
      id: "22103310",
      password: "tashik123",
      dept: "CSE",
      institute: "IUBAT",
      email: "tashik@gmail.com"),
  Student(
      name: "Niva Akter Nila",
      id: "22103341",
      password: "nila123",
      dept: "CSE",
      institute: "IUBAT",
      email: "nila@gmail.com"),
  Student(
      name: "Siam Khan",
      id: "221045678",
      password: "siam123",
      dept: "CSE",
      institute: "IUBAT",
      email: "siam@gmail.com"),
];

// ---------- Login Screen ----------
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  String? errorText;

  void login() {
    String inputId = idController.text.trim();
    String inputPass = passwordController.text.trim();

    // Use firstWhereOrNull pattern safely
    Student? student;
    try {
      student = demoStudents.firstWhere(
              (s) => s.id == inputId && s.password == inputPass);
    } catch (e) {
      student = null;
    }

    if (student != null) {
      // Navigate safely, student is non-null here
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => DashboardScreen(student: student!)));
    } else {
      setState(() {
        errorText = "Invalid ID or Password!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent.shade700, Colors.blueAccent.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(25),
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 15, spreadRadius: 5)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.school, size: 80, color: Colors.blueAccent),
                  SizedBox(height: 15),
                  Text(
                    'Smart Campus Login',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      labelText: 'Student ID',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      errorText: errorText,
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Text('Login', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Use your Student ID and Password to login',
                    style: TextStyle(color: Colors.grey[600]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- Dashboard ----------
class DashboardScreen extends StatelessWidget {
  final Student student;
  DashboardScreen({required this.student});

  final List<Map<String, dynamic>> features = [
    {
      'title': 'Class Schedule',
      'icon': Icons.calendar_today,
      'color': Colors.blueAccent
    },
    {'title': 'Attendance', 'icon': Icons.check_circle, 'color': Colors.green},
    {
      'title': 'Fee Payment',
      'icon': Icons.payment,
      'color': Colors.orangeAccent
    },
    {
      'title': 'Notices',
      'icon': Icons.notifications,
      'color': Colors.purpleAccent
    },
    {'title': 'Results', 'icon': Icons.assessment, 'color': Colors.redAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome, ${student.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 5),
                    Text('ID: ${student.id} | Dept: ${student.dept}'),
                    Text(
                        'Institute: ${student.institute} | Email: ${student.email}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: GridView.builder(
                itemCount: features.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemBuilder: (context, index) {
                  Color mainColor = features[index]['color'];
                  Color bgColor = mainColor.withOpacity(0.2);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FeatureScreen(
                                  student: student,
                                  title: features[index]['title'],
                                  color: mainColor)));
                    },
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: bgColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(features[index]['icon'],
                              size: 45, color: mainColor),
                          SizedBox(height: 10),
                          Text(features[index]['title'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Feature Screen ----------
class FeatureScreen extends StatelessWidget {
  final String title;
  final Color color;
  final Student student;

  FeatureScreen(
      {required this.title, required this.color, required this.student});

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [];
    List<DataRow> rows = [];

    switch (title) {
      case 'Class Schedule':
        columns = [
          DataColumn(
              label: Text('Day', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
              Text('Course', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
              Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
        ];
        rows = [
          DataRow(cells: [
            DataCell(Text('Monday')),
            DataCell(Text('CSE101')),
            DataCell(Text('9:00-10:30'))
          ]),
          DataRow(cells: [
            DataCell(Text('Tuesday')),
            DataCell(Text('MAT101')),
            DataCell(Text('10:45-12:15'))
          ]),
          DataRow(cells: [
            DataCell(Text('Wednesday')),
            DataCell(Text('ENG101')),
            DataCell(Text('1:00-2:30'))
          ]),
        ];
        break;

      case 'Attendance':
        columns = [
          DataColumn(
              label:
              Text('Course', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Attendance',
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ];
        rows = [
          DataRow(cells: [DataCell(Text('CSE101')), DataCell(Text('85%'))]),
          DataRow(cells: [DataCell(Text('MAT101')), DataCell(Text('90%'))]),
          DataRow(cells: [DataCell(Text('ENG101')), DataCell(Text('95%'))]),
        ];
        break;

      case 'Fee Payment':
        columns = [
          DataColumn(
              label: Text('Fee Type',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
              Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
              Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
        ];
        rows = [
          DataRow(cells: [
            DataCell(Text('Tuition Fee')),
            DataCell(Text('25,000 BDT')),
            DataCell(Text('Paid'))
          ]),
          DataRow(cells: [
            DataCell(Text('Lab Fee')),
            DataCell(Text('5,000 BDT')),
            DataCell(Text('Due'))
          ]),
        ];
        break;

      case 'Notices':
        columns = [
          DataColumn(
              label:
              Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
              Text('Notice', style: TextStyle(fontWeight: FontWeight.bold))),
        ];
        rows = [
          DataRow(cells: [
            DataCell(Text('20 Nov 2025')),
            DataCell(Text('Semester Exam Starts'))
          ]),
          DataRow(cells: [
            DataCell(Text('15 Nov 2025')),
            DataCell(Text('Cultural Fest Registration Ends'))
          ]),
        ];
        break;

      case 'Results':
        columns = [
          DataColumn(
              label:
              Text('Course', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
              Text('Grade', style: TextStyle(fontWeight: FontWeight.bold))),
        ];
        rows = [
          DataRow(cells: [DataCell(Text('CSE101')), DataCell(Text('A'))]),
          DataRow(cells: [DataCell(Text('MAT101')), DataCell(Text('B+'))]),
        ];
        break;

      default:
        columns = [DataColumn(label: Text('No Data'))];
        rows = [DataRow(cells: [DataCell(Text('-'))])];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(15),
        child: DataTable(
          columns: columns,
          rows: rows,
          headingRowColor:
          MaterialStateColor.resolveWith((states) => color.withOpacity(0.3)),
          dataRowColor:
          MaterialStateColor.resolveWith((states) => Colors.grey[100]!),
        ),
      ),
    );
  }
}