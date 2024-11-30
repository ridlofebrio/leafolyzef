import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:leafolyze/blocs/profile/profile_bloc.dart';
import 'package:leafolyze/blocs/profile/profile_event.dart';
import 'package:leafolyze/blocs/profile/profile_state.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  File? _profileImage;
  String _selectedGender = 'male';

  @override
  void initState() {
    super.initState();
    final profileBloc = context.read<ProfileBloc>();
    profileBloc.add(LoadProfile());
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        birthController.text =
            "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    birthController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Information'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ProfileLoaded) {
                  final userDetail = state.user.userDetail;
                  if (userDetail != null) {
                    nameController.text = userDetail.name;
                    birthController.text = userDetail.birth ?? '';
                    _selectedGender = userDetail.gender ?? 'male';
                    addressController.text = userDetail.address ?? '';
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : AssetImage(
                                        'assets/images/profile_placeholder.png')
                                    as ImageProvider,
                          ),
                          TextButton(
                            onPressed: _pickImage,
                            child: const Text(
                              'Edit picture or avatar',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildTextField("Name", nameController),
                    buildTextField(
                      "Birth",
                      birthController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                    ),
                    buildGenderRadioButtons(),
                    buildTextField("Address", addressController),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          final name = nameController.text;
                          final birth = birthController.text;
                          final gender = _selectedGender;
                          final address = addressController.text;

                          context.read<ProfileBloc>().add(UpdateProfile(
                                name: name,
                                birth: birth,
                                gender: gender,
                                address: address,
                                imagePath: _profileImage?.path,
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: const Text("SAVE"),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
    void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildGenderRadioButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Gender"),
          ListTile(
            title: const Text("Male"),
            leading: Radio<String>(
              value: 'male',
              groupValue: _selectedGender,
              onChanged: (String? value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("Female"),
            leading: Radio<String>(
              value: 'female',
              groupValue: _selectedGender,
              onChanged: (String? value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
