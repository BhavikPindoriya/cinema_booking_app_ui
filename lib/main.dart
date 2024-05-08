import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BookingPage(),
    );
  }
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int selectedIndex = DateTime.now().day - 1;

  late DateTime selectedDate = DateTime.now();

  /// Get the current date
  DateTime now = DateTime.now();
  late DateTime firstDayOfMonth;
  late DateTime lastDayOfMonth;

  /// Controls auto scroll to current date
  final _scrollController = ScrollController();

  void _scrollToSelectedIndex() {
    _scrollController.animateTo(
      selectedIndex * 30.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    /// Get the current year and month
    firstDayOfMonth = DateTime(now.year, now.month, 1);
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    // Wait for the widget to be built before scrolling to the selected index
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToSelectedIndex());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff181F21),
                Color(0xff1A1A1A),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(lastDayOfMonth.day, (index) {
                        final currentDate =
                            firstDayOfMonth.add(Duration(days: index));
                        final dayName = DateFormat('E').format(currentDate);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                width: 57,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? const Color(0xffE03B1A)
                                      : const Color(0xFF2A2F30),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 7,
                                      height: 7,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      dayName.substring(0, 3),
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text('${index + 1}',
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            width: 100,
                            height: 25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: index == 2
                                  ? const Color(0xffE03B1A)
                                  : const Color(0xFF2A2F30),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              '10:30 AM',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomPaint(
                    painter: CurvePainter(),
                    child: Container(height: 170),
                  ),
                  Wrap(
                    spacing: 12,
                    children: List.generate(
                      100,
                      (index) {
                        final randomColor = getRandomColor([
                          const Color(0xFF2A2F30),
                          Colors.white,
                          const Color(0xffE03B1A)
                        ]);
                        return Icon(
                          Icons.chair,
                          color: randomColor,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Available",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Taken",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffE03B1A),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Selected",
                              style: TextStyle(color: Color(0xffE03B1A))),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    height: 140,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff292F30),
                        borderRadius: BorderRadius.circular(40)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            Text(
                              "SmartCinema Sky Park",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const Text(
                          "Mykola Ovodova 51,Vinnitsa, Vinnitsa region,2100",
                          style: TextStyle(color: Colors.grey),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(230, 50),
                              backgroundColor: const Color(0xffE03B1A),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Text(
                            "Buy Ticket  \$48.00 ",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getRandomColor(List<Color> colors) {
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = const Color(0xffE03B1A);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    var startPoint = Offset(0, size.height / 2);
    var controlPoint1 = Offset(size.width / 4, size.height / 5);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 5);
    var endPoint = Offset(size.width, size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
