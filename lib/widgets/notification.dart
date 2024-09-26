import 'package:flutter/material.dart';
import 'colors.dart';

class NotificationPage extends StatelessWidget {
  final String message;
  final bool isError;

  NotificationPage({required this.message, required this.isError});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isError ? 'Error' : 'Success',
        style: TextStyle(
          color: isError ? AppColors.lightPink : AppColors.tealBlue,
          fontWeight: FontWeight.bold,
          fontSize: 20.0, // Slightly larger font for prominence
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          message,
          style: TextStyle(
            color: AppColors.tealBlue, // Better contrast with the background
            fontSize: 16.0,
          ),
        ),
      ),
      backgroundColor: AppColors.lightYellow, // Softer background for a neutral look
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: isError ? AppColors.lightPink : AppColors.tealBlue,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            'OK',
            style: TextStyle(
              color: isError ? Colors.white : AppColors.lightBlue, // Good contrast for the button text
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // More rounded corners for a modern look
        side: BorderSide(
          color: AppColors.tealBlue, // Border to complement the teal blue theme
          width: 2.0,
        ),
      ),
    );
  }
}
