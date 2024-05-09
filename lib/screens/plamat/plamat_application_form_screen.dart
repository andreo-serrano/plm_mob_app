import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class ApplicantFormPage extends StatefulWidget {
  const ApplicantFormPage({super.key});

  @override
  _ApplicantFormPage createState() => _ApplicantFormPage();
}

class _ApplicantFormPage extends State<ApplicantFormPage> {
  int _activeStepIndex = 0;

  void _goToNextStep() {
    setState(() {
      _activeStepIndex++;
    });
  }

  void _goToPreviousStep() {
    setState(() {
      _activeStepIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget form;

    switch (_activeStepIndex) {
      case 0:
        form = const FirstSectionForm();
        break;
      case 1:
        form = const SecondSectionForm();
        break;
      case 2:
        form = const ThirdSectionForm();
        break;
      default:
        form = Container();
        break;
    }

    return MaterialApp(
      title: 'Application Form',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Application Form'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              form,
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_activeStepIndex > 0)
                    ElevatedButton(
                      onPressed: _goToPreviousStep,
                      child: const Text('Previous'),
                    ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: _goToNextStep,
                    child: Text(_activeStepIndex < 2 ? 'Next' : 'Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstSectionForm extends StatelessWidget {
  const FirstSectionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Personal Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Last Name',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your Last Name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'First Name',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your First Name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Middle Name',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your Middle Name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name Extension',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Maiden Name (if married)',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Birth Date',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your First Name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Sex',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your First Name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Civil Status',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your First Name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Landline',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Cellphone No.',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your contact no.';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Valid E-mail Address',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your e-mail address';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class SecondSectionForm extends StatelessWidget {
  const SecondSectionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Mailing Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'House No./St./Vill./Compound',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your House No./St./Vill./Compound';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Region',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your Region';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Province',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your Province';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'City/Municipality',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your City/Municipality';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Barangay',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your Barangay';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Zip Code',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '*Enter your Zip Code';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class ThirdSectionForm extends StatefulWidget {
  const ThirdSectionForm({super.key});

  @override
  _ThirdSectionFormState createState() => _ThirdSectionFormState();
}

class _ThirdSectionFormState extends State<ThirdSectionForm> {
  List<String> _selectedFiles = [];

  void _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          _selectedFiles = result.paths.map((path) => path!).toList();
        });
      }
    } on PlatformException catch (e) {
      print("Error picking files: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Requirements',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const Expanded(
              child: Text('Grade 11 Report Card:'),
            ),
            ElevatedButton(
              onPressed: _pickFiles,
              child: const Text('Select Files'),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const Expanded(
              child: Text('Grade 12 1st Semester Report Card:'),
            ),
            ElevatedButton(
              onPressed: _pickFiles,
              child: const Text('Select Files'),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const Expanded(
              child: Text('Form 138 (PDF/JPEG):'),
            ),
            ElevatedButton(
              onPressed: _pickFiles,
              child: const Text('Select Files'),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _selectedFiles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_selectedFiles[index]),
            );
          },
        ),
      ],
    );
  }
}
