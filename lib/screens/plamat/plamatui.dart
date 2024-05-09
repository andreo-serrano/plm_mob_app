import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PLAMATUIPage());
}

class PLAMATUIPage extends StatelessWidget {
  const PLAMATUIPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OJT',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ApplicantForm(),
    );
  }
}

class ApplicantForm extends StatefulWidget {
  const ApplicantForm({Key? key}) : super(key: key);
  @override
  _ApplicantFormState createState() => _ApplicantFormState();
}

class _ApplicantFormState extends State<ApplicantForm> {
  int _activeStepIndex = -1;
  DateTime? selectedBirthDate;
  DateTime? selectedNmatDate;
  String? _selectedGender;
  String? _selectedCivilStatus;
  String? _selectedRegion;
  String? _selectedNameExt;
  String? _selectedProvince;
  String? _selectedCityMunicipality;
  String? _selectedCoursePreference;

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
  final List<String> _CoursePreference = [
    'Bachelor of Science in Social Work',
    'Bachelor of Science in Entrepreneurship',
    'Bachelor of Science in Accountancy',
    'Bachelor of Science in Mathematics',
    'Bachelor of Science in Chemistry',
    'Bachelor os Science in Psychology',
    'Bachelor of Science in Biology',
    'Bachelor of Secondary Education major in Social Studies',
    'Bachelor of Secondary Education major in Mathematics',
    'Bachelor of Secondary Education major in Science',
    'Bachelor of Secondary Education major in Filipino',
    'Bachelor of Secondary Education major in English',
    'Bachelor of Music in Music Performance',
    'Bachelor of Science in Computer Science',
    'Bachelor of Physical Education',
    'Bachelor of Elementary (Generalist) Education',
    'Bachelor of Science in Hospitality Management',
    'Bachelor of Science in Business Administration Major in Finance and Treasury Management',
    'Bachelor of Science in Business Administration Major in Business Economics',
    'Bachelor of Science in Tourism Management',
    'Bachelor of Arts in Communication',
    'Bachelor of Science in Physical Therapy',
    'Bachelor of Science in Nursing',
    'Bachelor of Science in Business Administration Major in Human Resources',
    'Bachelor of Science in Business Administration Major in Marketing Management',
    'Bachelor of Science in Information Technology',
    'Bachelor of Science in Manufacturing Engineering',
    'Bachelor of Science in Mechanical Engineering',
    'Bachelor of Science in Electrical Engineering',
    'Bachelor of Science in Computer Engineering',
    'Bachelor of Science in Chemical Engineering',
    'Bachelor of Science in Civil Technology',
    'Bachelor of Science in Electronics Engineering',
    'Bachelor of Public Administration',
    'Bachelor of Science in Architecture',
  ];
  final List<String?> _fileNameList = List.filled(7, null);
  final List<TextEditingController> controllers =
  List.generate(32, (_) => TextEditingController());

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
                decoration: const InputDecoration(
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
                    hint: const Text('Select Name Extension'),
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
                decoration: const InputDecoration(
                  labelText: 'Select Gender',
                  border: OutlineInputBorder(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                decoration: const InputDecoration(
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
                    hint: const Text('Select Civil Status'),
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
                decoration: const InputDecoration(
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
                    hint: const Text('Select Region'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: InputDecorator(
                decoration: const InputDecoration(
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
                    hint: const Text('Select Province'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: InputDecorator(
                decoration: const InputDecoration(
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
                    hint: const Text('Select Province'),
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
        title: const Text('School Information'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Do not use special characters\n',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 236, 23, 23)),
            ),
            _buildTextField('Learners Reference No. (LRN)', controllers[15]),
            const SizedBox(height: 10),
            _buildTextField(
                'School/Senior High School Attended', controllers[16]),
            const SizedBox(height: 10),
            _buildTextField('School Provincial Address', controllers[17]),
            const SizedBox(height: 10),
            _buildTextField('School Type', controllers[18]),
            const SizedBox(height: 10),
            _buildTextField('Academic Strand/ALS', controllers[19]),
            const SizedBox(height: 10),
          ],
        ),
      ),
      Step(
        state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 3,
        title: const Text('Guardian'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Father\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            _buildTextField('Last Name', controllers[20]),
            const SizedBox(height: 10),
            _buildTextField('First Name', controllers[21]),
            const SizedBox(height: 10),
            _buildTextField('Middle Name', controllers[22]),
            const SizedBox(height: 10),
            _buildTextField('Address', controllers[23]),
            const SizedBox(height: 10),
            _buildTextField('Contact No. (0 if none)', controllers[24]),
            const SizedBox(height: 10),
            _buildTextField('Occupation', controllers[25]),
            const SizedBox(height: 10),
            const Text(
              'Mother\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            _buildTextField('Last Name', controllers[26]),
            const SizedBox(height: 10),
            _buildTextField('First Name', controllers[27]),
            const SizedBox(height: 10),
            _buildTextField('Middle Name', controllers[28]),
            const SizedBox(height: 10),
            _buildTextField('Address', controllers[29]),
            const SizedBox(height: 10),
            _buildTextField('Contact No. (0 if none)', controllers[30]),
            const SizedBox(height: 10),
            _buildTextField('Occupation', controllers[31]),
            const SizedBox(height: 10),
          ],
        ),
      ),
      Step(
        state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 4,
        title: const Text('Course Preference'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'First Choice',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCoursePreference,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCoursePreference = newValue;
                      });
                    },
                    items: _CoursePreference.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Center(
                          // Center the text within the DropdownMenuItem
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    hint: const Text('Select from the List'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Select Second Choice',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCoursePreference,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCoursePreference = newValue;
                      });
                    },
                    items: _CoursePreference.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Center(
                          // Center the text within the DropdownMenuItem
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    hint: const Text('Select from the List'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Third Choice',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCoursePreference,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCoursePreference = newValue;
                      });
                    },
                    items: _CoursePreference.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Center(
                          // Center the text within the DropdownMenuItem
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    hint: const Text('Select from the List'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Step(
        state: _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 5,
        title: const Text('Requirements'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The total size of ALL files to be uploaded must not exceed 15 MB (Megabytes).\n',
            ),
            _buildFilePicker('PSA Birth Certificate (PDF)\n', 0),
            const SizedBox(height: 8),
          ],
        ),
      ),
      Step(
        state: _activeStepIndex <= 4 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 6,
        title: const Text('Data Privacy Act'),
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
                const Text('I Agree'),
              ],
            ),
          ],
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
        // ignore: use_build_context_synchronously
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
      appBar: AppBar(title: const Text('Application Form')),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Table(
              children: const [
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Prepare the following before filling out this form',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\u2022 '),
                              Expanded(
                                child: Text(
                                  'Application Requirements:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\u2713 '),
                              Expanded(
                                child: Text(
                                  'Scanned copy (PDF/image format) of the following documents:',
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\u2022 PSA Birth Certificate click to view sample',
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  '\u2022 Certified True Copy of Grade 11 Report Card (Form 138) with General Weighted Average (GWA) click to view sample',
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  '\u2022 For Alternative Learning System (ALS) completers and Accreditation & Equivalency (A&E) Passers: Certificate of Completion click to view sample',
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  '\u2022 For Manila Residents (Voter’s ID/Voter\'s Certification from COMELEC of Parent and Proof of Residency for at least Five (5) years) click to view sample',
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\u2022 '),
                              Expanded(
                                child: Text('Reminders:',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\u2713 '),
                              Expanded(
                                child: Text(
                                  'Applicants with deficiencies in the requirements will not be processed.',
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
              // Placeholder button action
            },
            child: const Text('Go to Dashboard (pa link nalang sa main app)'),
          ),
        ],
      ),
    );
  }
}
