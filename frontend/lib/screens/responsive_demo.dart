import 'package:flutter/material.dart';

class ResponsiveDemo extends StatelessWidget {
  const ResponsiveDemo({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Responsive Design Demo"),
        centerTitle: true,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {

          if (screenWidth < 600) {

            // 📱 MOBILE LAYOUT
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.15,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Mobile Card",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.15,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Responsive Box",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );

          } else {

            // 💻 TABLET LAYOUT
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Container(
                  width: screenWidth * 0.35,
                  height: screenHeight * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Tablet Left Panel",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Container(
                  width: screenWidth * 0.35,
                  height: screenHeight * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Tablet Right Panel",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );

          }
        },
      ),
    );
  }
}