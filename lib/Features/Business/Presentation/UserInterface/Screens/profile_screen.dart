import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getcities_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getuser_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../AppCores/CoreWidgets/appbartitle.dart';
import '../../../Domain/Entities/user_entity.dart';
import '../../StateMangement/Blocs/updateuser_bloc.dart';
import '../CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _shippingAddressController;
  late TextEditingController _mobileNumberController;
  late TextEditingController _personalAddressController;
  late TextEditingController _dateOfBirthController;
  File? _profileImage;
  File? _cnicFrontImage;
  File? _cnicBackImage;
  String? _selectedCity;

  final List<String> _cities = [
    // Add more cities as needed
  ];

  @override
  void initState() {
    super.initState();
    var cities = BlocProvider.of<GetcitiesBloc>(context).getCitiesLocal();
    _cities.addAll(cities.map((city) => city.cityName).toList());

    var userEntity = BlocProvider.of<GetUserBloc>(context).getUserLocal();
    _selectedCity = userEntity.cityName;

    _nameController = TextEditingController(text: userEntity.name);
    _shippingAddressController =
        TextEditingController(text: userEntity.shippingAddress);
    _mobileNumberController = TextEditingController(text: userEntity.mobileNo);
    _personalAddressController =
        TextEditingController(text: userEntity.personalAddress);
    _dateOfBirthController = TextEditingController(text: userEntity.cityName);
    _selectedCity = userEntity.cityName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _shippingAddressController.dispose();
    _mobileNumberController.dispose();
    _personalAddressController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, String type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (type == 'profile') {
          _profileImage = File(pickedFile.path);
        } else if (type == 'cnicFront') {
          _cnicFrontImage = File(pickedFile.path);
        } else if (type == 'cnicBack') {
          _cnicBackImage = File(pickedFile.path);
        }
      });
    }
  }

  // String? _imageToBase64(File? image) {
  //   if (image == null) return null;
  //   final bytes = image.readAsBytesSync();
  //   return base64Encode(bytes);
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTtile(),
        elevation: 0,
        actions: const [CartNotificationWidget()],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: size.height * .05),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery, 'profile'),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const NetworkImage(
                                'https://tse1.mm.bing.net/th?id=OIP.11DqAwY1SQbjr6PEVpTEHwHaHa&pid=Api&P=0&h=220')
                            as ImageProvider,
                    child: _profileImage == null
                        ? const Icon(Icons.add_a_photo, size: 50)
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery, 'cnicFront'),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: _cnicFrontImage != null
                        ? Image.file(_cnicFrontImage!, fit: BoxFit.cover)
                        : const Center(
                            child: Text('Tap to add CNIC Front Image'),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery, 'cnicBack'),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: _cnicBackImage != null
                        ? Image.file(_cnicBackImage!, fit: BoxFit.cover)
                        : const Center(
                            child: Text('Tap to add CNIC Back Image'),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _shippingAddressController,
                  decoration: const InputDecoration(
                    labelText: 'Shipping Address',
                    hintText: 'Enter your shipping address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your shipping address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _mobileNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter your mobile number',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedCity,
                  items: _cities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'City Name',
                    hintText: 'Select your city',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your city';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _personalAddressController,
                  decoration: const InputDecoration(
                    labelText: 'Personal Address',
                    hintText: 'Enter your personal address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your personal address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _dateOfBirthController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    hintText: 'Select your date of birth',
                  ),
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      submit(context);
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      var userEntityLocal =
          BlocProvider.of<GetUserBloc>(context).getUserLocal();
      UserEntity userEntity = UserEntity(
          cityName: _selectedCity as String,
          createdAt: userEntityLocal.createdAt,
          email: userEntityLocal.email,
          id: userEntityLocal.id,
          mobileNo: _mobileNumberController.text,
          name: _nameController.text,
          personalAddress: _personalAddressController.text,
          profileImage: "",
          shippingAddress: _shippingAddressController.text,
          updatedAt: DateTime.now());

      BlocProvider.of<UpdateuserBloc>(context).updateUser(userEntity);
    }
  }
}
