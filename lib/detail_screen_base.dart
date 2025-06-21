import 'package:flutter/material.dart';

// Detail Screen Base Widget
class DetailScreenBase extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget child;

  const DetailScreenBase({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(20), child: child),
      ),
    );
  }
}
