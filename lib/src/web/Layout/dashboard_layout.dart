import 'package:flutter/material.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;
  const DashboardLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  DashboardLayoutState createState() => DashboardLayoutState();
}

class DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // SideMenuProvider.menuController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 300),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      body: Column(
        children: [
          // const Navbar(),
          Expanded(
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(child: widget.child),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
