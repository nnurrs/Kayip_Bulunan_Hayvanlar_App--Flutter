import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KayipForm extends StatefulWidget {
  const KayipForm({Key? key}) : super(key: key);

  @override
  _KayipFormState createState() => _KayipFormState();
}

class _KayipFormState extends State<KayipForm> {
  final _formKey = GlobalKey<FormState>();
  String _ad = '';
  String _yas = '';
  String _tur = '';
  String _cins = '';
  String _renk = '';
  String _cinsiyet = '';
  String _il = '';
  String _ekNot = '';
  File? _image;
  DateTime? _selectedDate;

  final adFocusNode = FocusNode();
  final yasFocusNode = FocusNode();
  final turFocusNode = FocusNode();
  final cinsFocusNode = FocusNode();
  final renkFocusNode = FocusNode();
  final cinsiyetFocusNode = FocusNode();
  final ilFocusNode = FocusNode();
  final ekNotFocusNode = FocusNode();

  @override
  void dispose() {
    adFocusNode.dispose();
    yasFocusNode.dispose();
    turFocusNode.dispose();
    cinsFocusNode.dispose();
    renkFocusNode.dispose();
    cinsiyetFocusNode.dispose();
    ekNotFocusNode.dispose();
    ilFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Kayıp Hayvan Bildirim Formu'),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/formArkaPlan.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      const SizedBox(
                        height: 250,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? pickedFile =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'jpeg', 'png'],
                          );

                          setState(() {
                            if (pickedFile != null) {
                              _image = File(pickedFile.files.single.path!);
                            } else {
                              print('Fotoğraf Seçilmedi.');
                            }
                          });
                        },
                        child: const Text('Fotoğraf Seç'),
                      ),
                      if (_image != null)
                        Image.file(
                          _image!,
                          height: 100,
                          width: 100,
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 1.5),
                          color: const Color.fromARGB(
                              255, 249, 243, 253), // Arka plan rengi
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null &&
                                pickedDate != _selectedDate) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                          child: ListTile(
                            title: const Text(
                              'Kaybolduğu Tarih (*)',
                              style: TextStyle(
                                color: Color(0xff783192),
                              ),
                            ),
                            subtitle: _selectedDate == null
                                ? null
                                : Text(
                                    '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: buildTextFormField(
                          labelText: 'Ad (*)',
                          focusNode: adFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen hayvanın adını girin';
                            }
                            if (value.length > 10) {
                              return 'Ad 10 karakterden uzun olamaz';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _ad = value!;
                          },
                          maxLength: 10, // Maximum length of the input
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: buildTextFormField(
                          labelText: 'Yaş (*)',
                          focusNode: yasFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen hayvanın yaşını girin';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _yas = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: buildTextFormField(
                          labelText: 'Tür(*)',
                          focusNode: turFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen hayvanın türünü girin';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _tur = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 0.7),
                          color: const Color.fromARGB(
                              255, 249, 243, 253), // Arka plan rengi
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Cins (*)',
                            labelStyle:
                                const TextStyle(color: Color(0xff783192)),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                          ),
                          focusNode: cinsFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen hayvanın cinsini seçin';
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              _cins = newValue!;
                            });
                          },
                          items: <String>['Köpek', 'Kedi', 'Kuş', 'Diğer']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: buildTextFormField(
                          labelText: 'Renk (*)',
                          focusNode: renkFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen hayvanın rengini girin';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _renk = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 0.7),
                          color: const Color.fromARGB(
                              255, 249, 243, 253), // Arka plan rengi
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Cinsiyet (*)',
                            labelStyle:
                                const TextStyle(color: Color(0xff783192)),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                          ),
                          focusNode: cinsiyetFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen hayvanın cinsiyetini seçin';
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              _cinsiyet = newValue!;
                            });
                          },
                          items: <String>['Dişi', 'Erkek']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: buildTextFormField(
                          labelText: 'Kaybolduğu İl (*)',
                          focusNode: ilFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen hayvanın kaybolduğu ili girin';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _il = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: buildTextFormField(
                          labelText: 'Ek Not (varsa)',
                          focusNode: ekNotFocusNode,
                          onSaved: (value) {
                            _ekNot = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_selectedDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Lütfen kaybolduğu tarihi seçin'),
                                ),
                              );
                              return; // Tarih seçilmemişse formu kaydetmeyi durdur
                            }
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // Form doğrulandı, Firestore'a kaydet
                              await _saveToFirestore();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Form gönderildi')));
                            }
                          },
                          child: const Text('Formu Kaydet'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required String labelText,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    int? maxLength, // New parameter for maximum length
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFCF5FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Color(0xff783192)),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
          textAlign: TextAlign.left,
          focusNode: focusNode,
          validator: validator,
          onSaved: onSaved,
          maxLength: maxLength, // Set the maxLength property
        ),
      ),
    );
  }

  Future<void> _saveToFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        String? imagePath = _image?.path;
        // ignore: unused_local_variable
        DocumentReference docRef =
            await FirebaseFirestore.instance.collection('kayıp').add({
          'ad': _ad,
          'yas': _yas,
          'cins': _cins,
          'tur': _tur,
          'renk': _renk,
          'cinsiyet': _cinsiyet,
          'il': _il,
          'ekNot': _ekNot,
          'kayıptarih': _selectedDate,
          'userId': userId,
          'foto': imagePath,
        });
        print("Hayvan başarıyla Firestore'a eklendi!");

        // Assuming addFoundItem is another function you're calling here
        // await addFoundItem(userId, docRef.id);

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form gönderildi')));
      } else {
        print('Kullanıcı oturumu yok');
      }
    } catch (e) {
      print("Hata: $e");
    }
  }
}
