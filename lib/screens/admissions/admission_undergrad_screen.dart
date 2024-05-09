import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../widgets/bulletList.dart';

class UndergradPage extends StatefulWidget {
  const UndergradPage({super.key});

  @override
  State<UndergradPage> createState() => _UndergradPageState();
}

class _UndergradPageState extends State<UndergradPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undergraduate Programs'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Undergraduate Programs',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Color.fromARGB(255, 163, 25, 32),
                    ),
              ),
              SizedBox(height: 30),
              Text('College of Architecture and Sustainable Built Environments',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList(['Bachelor of Science in Architecture - BS Arch']),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Education',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList([
                'Bachelor of Elementary Education (Generalist) - BEEd',
                'Bachelor of Early Childhood Education - BECEd',
                'Bachelor of Special Needs Education (Generalist) - BSNEd',
                'Bachelor of Secondary Education Major in English - BSEd-Eng',
                'Bachelor of Secondary Education Major in Filipino - BSEd-Fil',
                'Bachelor of Secondary Education Major in Mathematics - BSEd-Math',
                'Bachelor of Secondary Education Major in Science - BSEd-Sciences',
                'Bachelor of Secondary Education Major in Social Studies - BSEd-SS',
                'Bachelor of Physical Education - BPE',
              ]),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Engineering and Technology',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList([
                'Bachelor of Science in Chemical Engineering - BSCHE',
                'Bachelor of Science in Civil Engineering - BSCE',
                'Bachelor of Science in Computer Engineering - BSCpE',
                'Bachelor of Science in Electrical Engineering - BSEE',
                'Bachelor of Science in Electronics Engineering - BSECE',
                'Bachelor of Science in Manufacturing Engineering - BSMFGE',
                'Bachelor of Science in Mechanical Engineering - BSME',
              ]),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Humanities, Arts, and Social Sciences',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList([
                'Bachelor of Arts in Communication - BAC',
                'Bachelor of Arts in Communication Major in Public Relations - BAC-PR',
                'Bachelor of Arts in Public Relations - BAPR',
                'Bachelor of Science in Social Work - BSSW',
                'Bachelor of Music in Music Performance - BMMP',
              ]),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Information System and Technology Management',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList([
                'Bachelor of Science in Computer Science - BSCS',
                'Bachelor of Science in Information Technology - BSIT',
              ]),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Nursing',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList([
                'Bachelor of Science in Nursing - BSN',
              ]),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Physical Therapy',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList([
                'Bachelor of Science in Physical Therapy - BSPT',
              ]),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Science',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList([
                'Bachelor of Science in Biology - BS Bio',
                'Bachelor of Science in Chemistry - BS Chem',
                'Bachelor of Science in Mathematics - BS Math',
                'Bachelor of Science in Psychology  - BS PSY',
              ]),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Accountancy',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList([
                'Bachelor of Science in Accountancy - BS ACCTG',
              ]),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Business Administration',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList([
                'Bachelor of Science in Business Administration Major in Business Economics - BSBA-BE',
                'Bachelor of Science in Business Administration Major in Financial Management - BSBA-FM',
                'Bachelor of Science in Business Administration Major in Human Resource Development Management - BSBA-HRM',
                'Bachelor of Science in Business Administration Major in Marketing Management - BSBA-MM',
                'Bachelor of Science in Business Administration Major in Operations Management - BSBA-OM',
                'Bachelor of Science in Entrepreneurship - BS-ENTRE',
              ]),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Tourism and Hospitality Management',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList(
                [
                  'Bachelor of Science in Hospitality - BSHM',
                  'Bachelor of Science in Real Estate Management - BSREM',
                  'Bachelor of Science in Tourism Management - BSTM',
                ]),
              _buildDivider(), // It adds a divider here (horizontal line)
              SizedBox(height: 30),
              Text('College of Public Administration',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              BulletList(
                  [
                    'Bachelor of Science in Public Administration',
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  Widget _buildDivider() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        width: 1500, // Adjust the width as needed
        height: 2,
        color: Colors.grey[300], // Slightly visible gray color
      ),
    );
  }