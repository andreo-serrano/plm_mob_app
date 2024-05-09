import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../admissions/admission_medtest_screen.dart';
import '../home/home_guest.dart';

class MCATApp extends StatelessWidget {
  const MCATApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OJT',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MCATAppPage(),
    );
  }
}

class MCATAppPage extends StatefulWidget {
  const MCATAppPage({Key? key}) : super(key: key);

  @override
  _MCATAppPage createState() => _MCATAppPage();
}

class _MCATAppPage extends State<MCATAppPage> {
  int _activeStepIndex = -1;
  DateTime? selectedBirthDate;
  DateTime? selectedNmatDate;
  String? _selectedGender;
  String? _selectedCivilStatus;
  String? _selectedRegion;
  String? _selectedNameExt;
  String? _selectedProvince;
  String? _selectedCityMunicipality;

  bool _isSubmitting = false;

  final List<String> _cityMunicipality = [
    'Alaminos',
    'Angeles City',
    'Bacolod',
    'Bacoor',
    'Baguio',
    'Bago',
    'Baguio',
    'Bais',
    'Bayawan',
    'Baybay',
    'Biñan',
    'Bislig',
    'Butuan',
    'Cabadbaran',
    'Cabuyao',
    'Cadiz',
    'Cagayan de Oro',
    'Calamba',
    'Calapan',
    'Calbayog',
    'Caloocan',
    'Candon',
    'Canlaon',
    'Cavite City',
    'Cebu City',
    'Cotabato City',
    'Dagupan',
    'Danao',
    'Dapitan',
    'Dasmariñas',
    'Davao City',
    'Digos',
    'Dipolog',
    'Dumaguete',
    'El Salvador',
    'Escalante',
    'Gapan',
    'General Santos',
    'Gingoog',
    'Himamaylan',
    'Iligan',
    'Iloilo City',
    'Imus',
    'Iriga',
    'Island Garden City of Samal',
    'Kabankalan',
    'Kidapawan',
    'Koronadal',
    'La Carlota',
    'Lamitan',
    'Laoag',
    'Lapu-Lapu City',
    'Las Piñas',
    'Legazpi',
    'Ligao',
    'Lipa',
    'Lapu-Lapu City',
    'Makati',
    'Malabon',
    'Malaybalay',
    'Malolos',
    'Mandaluyong',
    'Mandaue',
    'Manila',
    'Marawi',
    'Marikina',
    'Masinloc',
    'Mati',
    'Meycauayan',
    'Muntinlupa',
    'Naga',
    'Navotas',
    'Naga',
    'Olongapo',
    'Ormoc',
    'Oroquieta',
    'Ozamiz',
    'Pagadian',
    'Palayan',
    'Panabo',
    'Parañaque',
    'Pasay',
    'Pasig',
    'Passi',
    'Puerto Princesa',
    'Quezon City',
    'Rosales',
    'Roxas',
    'San Carlos',
    'San Carlos',
    'San Fernando',
    'San Fernando',
    'San Francisco',
    'San Jose',
    'San Jose del Monte',
    'San Juan',
    'San Juan',
    'San Pablo',
    'San Pedro',
    'San Jose del Monte',
    'Santiago',
    'Santiago',
    'Santo Tomas',
    'Silay',
    'Sipalay',
    'Sorsogon City',
    'Surigao City',
    'Surigao City',
    'Tabaco',
    'Tabuk',
    'Tacloban',
    'Tacurong',
    'Tagaytay',
    'Tagbilaran',
    'Tagum',
    'Talisay',
    'Talisay',
    'Tanauan',
    'Tangub',
    'Tanjay',
    'Tarlac City',
    'Tayabas',
    'Trece Martires',
    'Tuguegarao',
    'Tugdan (Boracay)',
    'Urdaneta',
    'Valencia',
    'Valenzuela',
    'Victorias',
    'Vigan',
    'Zamboanga City'
  ];
  final List<String> _civilStatusOptions = [
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];
  final List<String> _nameExtList = [
    'Jr.',
    'Sr.',
    'I',
    'II',
    'III',
  ];
  final List<String> _regionList = [
    'Ilocos Region',
    'Cagayan Valley',
    'Central Luzon',
    'CALABARZON',
    'MIMAROPA Region',
    'Bicol Region',
    'Western Visayas',
    'Central Visayas',
    'Eastern Visayas',
    'Zamboanga Peninsula',
    'Northern Mindanao',
    'Davao Region',
    'SOCCSKSARGEN',
    'Caraga',
    'National Capital Region',
    'Cordillera Administrative Region',
    'Bangsamoro Autonomous Region in Muslim Mindanao',
  ];
  final List<String> _provinceList = [
    'Abra',
    'Agusan del Norte',
    'Agusan del Sur',
    'Aklan',
    'Albay',
    'Antique',
    'Apayao',
    'Aurora',
    'Basilan',
    'Bataan',
    'Batanes',
    'Batangas',
    'Benguet',
    'Biliran',
    'Bohol',
    'Bukidnon',
    'Bulacan',
    'Cagayan',
    'Camarines Norte',
    'Camarines Sur',
    'Camiguin',
    'Capiz',
    'Catanduanes',
    'Cavite',
    'Cebu',
    'Compostela Valley',
    'Cotabato',
    'Davao del Norte',
    'Davao del Sur',
    'Davao Occidental',
    'Davao Oriental',
    'Dinagat Islands',
    'Eastern Samar',
    'Guimaras',
    'Ifugao',
    'Ilocos Norte',
    'Ilocos Sur',
    'Iloilo',
    'Isabela',
    'Kalinga',
    'La Union',
    'Laguna',
    'Lanao del Norte',
    'Lanao del Sur',
    'Leyte',
    'Maguindanao',
    'Marinduque',
    'Masbate',
    'Metro Manila',
    'Misamis Occidental',
    'Misamis Oriental',
    'Mountain Province',
    'Negros Occidental',
    'Negros Oriental',
    'Northern Samar',
    'Nueva Ecija',
    'Nueva Vizcaya',
    'Occidental Mindoro',
    'Oriental Mindoro',
    'Palawan',
    'Pampanga',
    'Pangasinan',
    'Quezon',
    'Quirino',
    'Rizal',
    'Romblon',
    'Samar',
    'Sarangani',
    'Siquijor',
    'Sorsogon',
    'South Cotabato',
    'Southern Leyte',
    'Sultan Kudarat',
    'Sulu',
    'Surigao del Norte',
    'Surigao del Sur',
    'Tarlac',
    'Tawi-Tawi',
    'Zambales',
    'Zamboanga del Norte',
    'Zamboanga del Sur',
    'Zamboanga Sibugay',
  ];
  final List<String?> _fileNameList = List.filled(6, null);
  final List<TextEditingController> controllers =
  List.generate(18, (_) => TextEditingController());

  List<Step> stepList() {
    return [
      Step(
        state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 0,
        title: const Text('Personal Information'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            _buildTextField('Last Name', controllers[0]),
            const SizedBox(height: 10),
            _buildTextField('First Name', controllers[1]),
            const SizedBox(height: 10),
            _buildTextField('Middle Name', controllers[2]),
            const SizedBox(height: 10),
            Center(
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Select Name Extension',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedNameExt,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedNameExt = newValue;
                      });
                    },
                    items: _nameExtList.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Center(
                          // Center the text within the DropdownMenuItem
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    hint: Text('Select Name Extension'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField('Maiden Name (If Married)', controllers[4]),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => _selectBirthDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Birth Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  selectedBirthDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedBirthDate!)
                      : 'Click here to select date',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Select Sex',
                  border: OutlineInputBorder(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        const Text('Male'),
                        Radio<String>(
                          value: 'Female',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Select Civil Status',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCivilStatus,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCivilStatus = newValue;
                      });
                    },
                    items: _civilStatusOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Center(
                          // Center the text within the DropdownMenuItem
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    hint: Text('Select Civil Status'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField('Landline', controllers[6]),
            const SizedBox(height: 10),
            _buildTextField('Cellphone Number', controllers[7]),
            const SizedBox(height: 10),
            _buildTextField('Valid Email Address', controllers[8]),
            const SizedBox(height: 10),
          ],
        ),
      ),
      Step(
        state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Mailing Address'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Region - choose:\n'
                  'A) NCR. B) CALABARZON. C) CENTRAL LUZON. D) OTHERS.'
                  '\n\nProvince - choose:\n'
                  'NCR (1st District - City of Manila)\n'
                  'NCR (2nd District - Mandaluyong, Marikina, Pasig, San Juan, Quezon City)\n'
                  'NCR (3rd District - Caloocan, Malabon, Navotas, Valenzuela)\n'
                  'NCR (4th District - Las Pinas, Makati, Muntinlupa, Paranaque, Pasay, Pateros, Taguig)\n'
                  '\nClick the button below to find your zip code.\n',
            ),
            Center(
              child: ElevatedButton(
                onPressed: _launchURL,
                child: const Text('Get Zip Code'),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField('House Number/Street/Village/Subdivision/Compound',
                controllers[9]),
            const SizedBox(height: 10),
            Center(
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Select Region',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedRegion,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRegion = newValue;
                      });
                    },
                    items: _regionList.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Center(
                          // Center the text within the DropdownMenuItem
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    hint: Text('Select Region'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Select Province',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedProvince,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedProvince = newValue;
                      });
                    },
                    items: _provinceList.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Center(
                          // Center the text within the DropdownMenuItem
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    hint: Text('Select Province'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Select City/Municipality',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCityMunicipality,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCityMunicipality = newValue;
                      });
                    },
                    items: _cityMunicipality.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Center(
                          // Center the text within the DropdownMenuItem
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    hint: Text('Select Province'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField('Barangay', controllers[13]),
            const SizedBox(height: 10),
            _buildTextField('Zip Code', controllers[14]),
            const SizedBox(height: 10),
          ],
        ),
      ),
      Step(
        state: _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 2,
        title: const Text('Educational Information'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name and Complete Address of Tertiary School Graduated From and Course Obtained\n',
            ),
            _buildTextField('Name of College/University', controllers[15]),
            const SizedBox(height: 10),
            _buildTextField('Address', controllers[16]),
            const SizedBox(height: 10),
            _buildTextField('Course', controllers[17]),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => _selectNmatDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select date when NMAT was taken',
                ),
                child: Text(
                  selectedNmatDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedNmatDate!)
                      : '',
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField('NMAT Score', controllers[17]),
            const SizedBox(height: 10),
            _buildTextField(
                'GWA obtained from Bachelors Degree', controllers[17]),
          ],
        ),
      ),
      Step(
        state: _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 3,
        title: const Text('Requirements'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The total size of ALL files to be uploaded must not exceed 15 MB (Megabytes).\n',
            ),
            _buildFilePicker(
                'Official Transcript of Records/Certification of Grades (PDF/JPG)\n',
                0),
            const SizedBox(height: 8),
            _buildFilePicker(
                'Certificate of General Weighted Average/GWA of Subjects (PDF/JPG)\n',
                1),
            const SizedBox(height: 8),
            _buildFilePicker('NMAT Result (PDF/JPG)', 2),
            const SizedBox(height: 8),
            _buildFilePicker(
                'Form 137 (For undergraduates who have taken Grade 11 & 12) (PDF/JPG)\n',
                3),
            const SizedBox(height: 8),
            _buildFilePicker(
                'Voters Certification of Registration with voting history (For Manileño Only) (PDF/JPG)\n',
                4),
            const SizedBox(height: 8),
            _buildFilePicker('Vaccination Card - 2 Doses (PDF/JPG)\n', 5),
          ],
        ),
      ),
      Step(
        state: _activeStepIndex <= 4 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 4,
        title: const Text('Certification'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'I hereby certify that the information provided above is true and correct'
                    ' based on my personal knowledge and available records. Providing false and innacurate'
                    ' information may be ground for disqualification from the University.'),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _isSubmitting,
                  onChanged: (value) {
                    setState(() {
                      _isSubmitting = value!;
                    });
                  },
                ),
                const Text('I Submit'),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
                'By clicking the "Continue" button, you have fully understood and agreed to the Data Privacy Act 10173. '
                    'You will proceed to confirmation step to verify data inputted is correct.'
                    '\n\nFor any inquiry, email at: mcat@plm.edu.ph'),
          ],
        ),
      ),
      Step(
        state: StepState.complete,
        isActive: _activeStepIndex >= 5,
        title: const Text('Confirmation'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: controllers
              .map(
                (controller) => _buildText(controller),
          )
              .toList(),
        ),
      ),
    ];
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return SizedBox(
      height: 56,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  Widget _buildSelectionContainer(String label, Widget child) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildFilePicker(String label, int index) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextButton.icon(
                  onPressed: () => _uploadFile(index),
                  icon: const Icon(Icons.upload),
                  label: Text(
                    _fileNameList[index] ?? 'Select a file',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(TextEditingController controller) {
    return Text(controller.text);
  }

  void _uploadFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg'],
    );

    if (result != null) {
      File file = File(result.files.first.path!);
      int fileSize = await file.length();

      if (fileSize <= 15 * 1024 * 1024) {
        setState(() {
          _fileNameList[index] = result.files.first.name;
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('File Size Limit Exceeded'),
              content: const Text('The file size exceeds the limit of 15 MB.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      setState(() {
        _fileNameList[index] = null;
      });
    }
  }

  void _selectBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedBirthDate = pickedDate;
      });
    }
  }

  void _selectNmatDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedNmatDate = pickedDate;
      });
    }
  }

  void _launchURL() async {
    const url =
        'https://www.philippineszipcode.com/'; // Replace with your desired URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MCAT Admission')),
      body: _activeStepIndex == -1 ? _buildWelcomeScreen() : _buildStepper(),
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Welcome to MCAT!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _activeStepIndex = 0;
              });
            },
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    if (_activeStepIndex == stepList().length) {
      // Final step reached, display the "Thank you" page
      return _buildThankYouPage();
    } else {
      // Render the stepper with the steps
      return Stepper(
        type: StepperType.vertical,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < stepList().length - 1) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            // Final step completed, show "Thank you" page
            setState(() {
              _activeStepIndex += 1;
            });
          }
        },
        onStepCancel: () {
          if (_activeStepIndex > 0) {
            setState(() {
              _activeStepIndex -= 1;
            });
          } else {
            setState(() {
              _activeStepIndex = -1;
            });
          }
        },
      );
    }
  }

  Widget _buildThankYouPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Thank you for filling up!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MedTestPage()));
            },
            child: const Text('Go to Dashboard'),
          ),
        ],
      ),
    );
  }
}