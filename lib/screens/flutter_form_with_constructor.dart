import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterFormWithConstructor extends StatefulWidget {
  // ==================== OPTIONAL CONSTRUCTOR PARAMETERS ====================
  final String? initialName;
  final String? initialEmail;
  final String? initialPhone;
  final String? initialPassword;
  final String? initialConfirmPassword;
  final String? initialAge;
  final String? initialWebsite;
  final String? initialComments;
  final bool? initialIsChecked;
  final bool? initialSwitchValue;
  final String? initialSelectedGender;
  final String? initialSelectedCountry;
  final String? initialSelectedEducation;
  final List<String>? initialSelectedHobbies;
  final DateTime? initialSelectedDate;
  final TimeOfDay? initialSelectedTime;
  final DateTime? initialSelectedDateTime;
  final double? initialSliderValue;
  final RangeValues? initialRangeValues;

  const FlutterFormWithConstructor({
    super.key,
    this.initialName,
    this.initialEmail,
    this.initialPhone,
    this.initialPassword,
    this.initialConfirmPassword,
    this.initialAge,
    this.initialWebsite,
    this.initialComments,
    this.initialIsChecked,
    this.initialSwitchValue,
    this.initialSelectedGender,
    this.initialSelectedCountry,
    this.initialSelectedEducation,
    this.initialSelectedHobbies,
    this.initialSelectedDate,
    this.initialSelectedTime,
    this.initialSelectedDateTime,
    this.initialSliderValue,
    this.initialRangeValues,
  });

  @override
  State<FlutterFormWithConstructor> createState() =>
      _FlutterFormWithConstructorState();
}

class _FlutterFormWithConstructorState
    extends State<FlutterFormWithConstructor> {
  // ==================== FORM KEY ====================
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ==================== TEXT CONTROLLERS ====================
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _ageController;
  late final TextEditingController _commentsController;
  late final TextEditingController _websiteController;

  // ==================== BASIC INPUT STATES ====================
  late bool _isChecked;
  late bool _switchValue;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // ==================== SELECTION STATES ====================
  late String? _selectedGender;
  late String? _selectedCountry;
  late String? _selectedEducation;
  late List<String> _selectedHobbies;

  // ==================== DATE & TIME STATES ====================
  late DateTime? _selectedDate;
  late TimeOfDay? _selectedTime;
  late DateTime? _selectedDateTime;

  // ==================== SLIDER STATES ====================
  late double _sliderValue;
  late RangeValues _rangeValues;

  // ==================== DATA LISTS ====================
  final List<String> _hobbies = [
    'Reading',
    'Traveling',
    'Cooking',
    'Gaming',
    'Sports',
    'Music',
    'Photography',
    'Dancing'
  ];

  final List<String> _countries = [
    'USA',
    'Canada',
    'UK',
    'Germany',
    'France',
    'Australia',
    'Japan',
    'India'
  ];

  final List<String> _educationLevels = [
    'High School',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'PhD',
    'Other'
  ];

  @override
  void initState() {
    super.initState();

    // ==================== INITIALIZE CONTROLLERS WITH OPTIONAL VALUES ====================
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _emailController = TextEditingController(text: widget.initialEmail ?? '');
    _phoneController = TextEditingController(text: widget.initialPhone ?? '');
    _passwordController =
        TextEditingController(text: widget.initialPassword ?? '');
    _confirmPasswordController =
        TextEditingController(text: widget.initialConfirmPassword ?? '');
    _ageController = TextEditingController(text: widget.initialAge ?? '');
    _commentsController =
        TextEditingController(text: widget.initialComments ?? '');
    _websiteController =
        TextEditingController(text: widget.initialWebsite ?? '');

    // ==================== INITIALIZE STATES WITH OPTIONAL VALUES ====================
    _isChecked = widget.initialIsChecked ?? false;
    _switchValue = widget.initialSwitchValue ?? false;
    _selectedGender = widget.initialSelectedGender;
    _selectedCountry = widget.initialSelectedCountry;
    _selectedEducation = widget.initialSelectedEducation;
    _selectedHobbies = List<String>.from(widget.initialSelectedHobbies ?? []);
    _selectedDate = widget.initialSelectedDate;
    _selectedTime = widget.initialSelectedTime;
    _selectedDateTime = widget.initialSelectedDateTime;
    _sliderValue = widget.initialSliderValue ?? 50.0;
    _rangeValues = widget.initialRangeValues ?? const RangeValues(20, 80);
  }

  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _ageController.dispose();
    _commentsController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  // ==================== HELPER METHODS ====================
  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
      print("Selected date: $date");
    }
  }

  void _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _selectedTime = time);
      print("Selected time: $time");
    }
  }

  void _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );
      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
        print("Selected date & time: $_selectedDateTime");
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print("\n" + "=" * 50);
      print("    FORM WITH CONSTRUCTOR SUBMISSION DATA");
      print("=" * 50);

      // Personal Information
      print("\n📋 PERSONAL INFORMATION:");
      print("Name: ${_nameController.text}");
      print("Email: ${_emailController.text}");
      print("Phone: ${_phoneController.text}");
      print("Age: ${_ageController.text}");
      print("Website: ${_websiteController.text}");
      print("Gender: $_selectedGender");
      print("Country: $_selectedCountry");
      print("Education: $_selectedEducation");

      // Security
      print("\n🔒 SECURITY:");
      print("Password: ${_passwordController.text}");
      print("Confirm Password: ${_confirmPasswordController.text}");

      // Preferences
      print("\n⚙️ PREFERENCES:");
      print("Hobbies: $_selectedHobbies");
      print("Notifications Enabled: $_switchValue");
      print("Terms Accepted: $_isChecked");

      // Ratings & Ranges
      print("\n📊 RATINGS & RANGES:");
      print("Rating: ${_sliderValue.round()}");
      print(
          "Price Range: \$${_rangeValues.start.round()} - \$${_rangeValues.end.round()}");

      // Dates & Times
      print("\n📅 DATES & TIMES:");
      print("Birth Date: $_selectedDate");
      print("Preferred Time: $_selectedTime");
      print("Appointment: $_selectedDateTime");

      // Additional Info
      print("\n💬 ADDITIONAL INFO:");
      print("Comments: ${_commentsController.text}");

      print("\n" + "=" * 50);
      print("✅ Form with constructor submitted successfully!");
      print("=" * 50 + "\n");

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success!'),
          content: const Text(
              'Form submitted successfully. Check console for details.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==================== PERSONAL INFORMATION SECTION ====================
                _buildSectionHeader('📋 Personal Information'),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name *',
                    hintText: 'Enter your full name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email *',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Phone Field
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Age Field
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Age *',
                    hintText: 'Enter your age',
                    prefixIcon: Icon(Icons.cake),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final age = int.tryParse(value ?? '');
                    if (age == null) return 'Enter a valid age';
                    if (age <= 0 || age > 120)
                      return 'Enter a valid age (1-120)';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Website Field
                TextFormField(
                  controller: _websiteController,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'Website',
                    hintText: 'https://example.com',
                    prefixIcon: Icon(Icons.web),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // ==================== SELECTION SECTION ====================
                _buildSectionHeader('🎯 Selections'),

                // Gender Radio Buttons
                const Text('Gender *',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'Male',
                        groupValue: _selectedGender,
                        onChanged: (value) =>
                            setState(() => _selectedGender = value),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'Female',
                        groupValue: _selectedGender,
                        onChanged: (value) =>
                            setState(() => _selectedGender = value),
                      ),
                    ),
                  ],
                ),
                RadioListTile<String>(
                  title: const Text('Other'),
                  value: 'Other',
                  groupValue: _selectedGender,
                  onChanged: (value) => setState(() => _selectedGender = value),
                ),
                const SizedBox(height: 16),

                // Country Dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Country *',
                    prefixIcon: Icon(Icons.flag),
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedCountry,
                  items: _countries
                      .map((country) => DropdownMenuItem(
                            value: country,
                            child: Text(country),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedCountry = value),
                  validator: (value) =>
                      value == null ? 'Please select a country' : null,
                ),
                const SizedBox(height: 16),

                // Education Dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Education Level',
                    prefixIcon: Icon(Icons.school),
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedEducation,
                  items: _educationLevels
                      .map((education) => DropdownMenuItem(
                            value: education,
                            child: Text(education),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedEducation = value),
                ),
                const SizedBox(height: 16),

                // Hobbies Multi-Select
                const Text('Hobbies (Select multiple)',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ..._hobbies
                    .map((hobby) => CheckboxListTile(
                          title: Text(hobby),
                          value: _selectedHobbies.contains(hobby),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                _selectedHobbies.add(hobby);
                              } else {
                                _selectedHobbies.remove(hobby);
                              }
                            });
                          },
                        ))
                    .toList(),
                const SizedBox(height: 24),

                // ==================== DATE & TIME SECTION ====================
                _buildSectionHeader('📅 Date & Time'),

                // Date Picker
                ListTile(
                  title: Text(
                      'Birth Date: ${_selectedDate?.toString().split(' ')[0] ?? 'Select Date'}'),
                  leading: const Icon(Icons.calendar_today),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: _selectDate,
                  tileColor: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(height: 16),

                // Time Picker
                ListTile(
                  title: Text(
                      'Preferred Time: ${_selectedTime?.format(context) ?? 'Select Time'}'),
                  leading: const Icon(Icons.access_time),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: _selectTime,
                  tileColor: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(height: 16),

                // DateTime Picker
                ListTile(
                  title: Text(
                      'Appointment: ${_selectedDateTime?.toString() ?? 'Select Date & Time'}'),
                  leading: const Icon(Icons.event),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: _selectDateTime,
                  tileColor: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(height: 24),

                // ==================== SLIDERS SECTION ====================
                _buildSectionHeader('📊 Ratings & Ranges'),

                // Rating Slider
                Text('Rating: ${_sliderValue.round()}/100',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: _sliderValue.round().toString(),
                  onChanged: (value) => setState(() => _sliderValue = value),
                ),
                const SizedBox(height: 16),

                // Price Range Slider
                Text(
                    'Price Range: \$${_rangeValues.start.round()} - \$${_rangeValues.end.round()}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                RangeSlider(
                  values: _rangeValues,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  labels: RangeLabels(
                    _rangeValues.start.round().toString(),
                    _rangeValues.end.round().toString(),
                  ),
                  onChanged: (values) => setState(() => _rangeValues = values),
                ),
                const SizedBox(height: 24),

                // ==================== SECURITY SECTION ====================
                _buildSectionHeader('🔒 Security'),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password *',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password *',
                    hintText: 'Confirm your password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => setState(() =>
                          _obscureConfirmPassword = !_obscureConfirmPassword),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // ==================== PREFERENCES SECTION ====================
                _buildSectionHeader('⚙️ Preferences'),

                // Switch
                SwitchListTile(
                  title: const Text('Enable Notifications'),
                  subtitle: const Text('Receive email notifications'),
                  value: _switchValue,
                  onChanged: (value) => setState(() => _switchValue = value),
                  secondary: const Icon(Icons.notifications),
                ),
                const SizedBox(height: 16),

                // Comments Field
                TextFormField(
                  controller: _commentsController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Comments',
                    hintText: 'Enter any additional comments...',
                    prefixIcon: Icon(Icons.comment),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null && value.length > 500) {
                      return 'Comments must be less than 500 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Terms Checkbox
                CheckboxListTile(
                  title: const Text('I agree to the Terms and Conditions *'),
                  value: _isChecked,
                  onChanged: (value) =>
                      setState(() => _isChecked = value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 32),

                // ==================== SUBMIT BUTTONS ====================
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isChecked ? _submitForm : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Submit Form',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                          setState(() {
                            // Reset all values to initial or default
                            _selectedGender = widget.initialSelectedGender;
                            _selectedCountry = widget.initialSelectedCountry;
                            _selectedEducation =
                                widget.initialSelectedEducation;
                            _selectedHobbies = List<String>.from(
                                widget.initialSelectedHobbies ?? []);
                            _selectedDate = widget.initialSelectedDate;
                            _selectedTime = widget.initialSelectedTime;
                            _selectedDateTime = widget.initialSelectedDateTime;
                            _sliderValue = widget.initialSliderValue ?? 50.0;
                            _rangeValues = widget.initialRangeValues ??
                                const RangeValues(20, 80);
                            _switchValue = widget.initialSwitchValue ?? false;
                            _isChecked = widget.initialIsChecked ?? false;
                            _obscurePassword = true;
                            _obscureConfirmPassword = true;
                          });
                          // Reset controllers to initial values
                          _nameController.text = widget.initialName ?? '';
                          _emailController.text = widget.initialEmail ?? '';
                          _phoneController.text = widget.initialPhone ?? '';
                          _passwordController.text =
                              widget.initialPassword ?? '';
                          _confirmPasswordController.text =
                              widget.initialConfirmPassword ?? '';
                          _ageController.text = widget.initialAge ?? '';
                          _commentsController.text =
                              widget.initialComments ?? '';
                          _websiteController.text = widget.initialWebsite ?? '';
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Reset Form',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}
