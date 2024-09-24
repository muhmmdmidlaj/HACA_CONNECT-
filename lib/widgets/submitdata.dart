import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haca_review_main/models/classIssueData.dart';

class Submitdata extends StatelessWidget {
  const Submitdata({super.key});

  @override
  Widget build(BuildContext context) {
    final issueData = Provider.of<IssueData>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 80, top: 200),
      child: Container(
        height: 155,
        width: 411,
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(blurRadius: 3, spreadRadius: 2)]),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Issue: ${issueData.title}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 5),
              Text('Description: ${issueData.description}',
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
              const SizedBox(height: 5),
              Text('Category: ${issueData.category}',
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
              const SizedBox(height: 5),
              Text('Urgency: ${issueData.urgency}',
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
