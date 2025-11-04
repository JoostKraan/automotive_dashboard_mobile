import 'package:automotive_dashboard_mobile/pages/map.dart';
import 'package:flutter/material.dart';

class ActionButtonRowWidget extends StatelessWidget {
  const ActionButtonRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Row(
            children: [
              Container(
                width: 380,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF222222),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color.fromARGB(255, 20, 20, 20),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 15),
                    Icon(
                      Icons
                          .lock_open_outlined, //changes depending on if the car is locked or unlocked
                      color: Color(0xFF8A8A89),
                    ),
                    SizedBox(width: 15),
                    Text('Unlock'),
                    Spacer(),
                    Icon(Icons.chevron_right, color: Color(0xFF8A8A89)),
                    SizedBox(width: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CarMap()),
            );
          },
          child: Container(
            width: 380,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF222222),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 20, 20, 20),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 15),
                Icon(Icons.location_on, color: Color(0xFF8A8A89)),
                SizedBox(width: 15),
                Text('Location'),
                Spacer(),
                Icon(Icons.chevron_right, color: Color(0xFF8A8A89)),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 380,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF222222),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color.fromARGB(255, 20, 20, 20),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 15),
              Icon(Icons.build, color: Color(0xFF8A8A89)),
              SizedBox(width: 15),
              Text('Maintenance History'),
              Spacer(),
              Icon(Icons.chevron_right, color: Color(0xFF8A8A89)),
              SizedBox(width: 15),
            ],
          ),
        ),
      ],
    );
  }
}
