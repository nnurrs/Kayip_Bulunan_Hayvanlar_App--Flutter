import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/firestore/ilan.dart';

class BulunanForm extends StatefulWidget {
  const BulunanForm({super.key});

  @override
  _BulunanFormState createState() => _BulunanFormState();
}

class _BulunanFormState extends State<BulunanForm> {
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

  // FocusNode'ları tanımla
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
    // FocusNode'ları temizle
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
        title: const Text('Bulunan Hayvan Bildirim Formu'),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.zero, // Kenar boşlukları sıfırla
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
                color: Colors.transparent, // Arka planı kaldır
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      const SizedBox(
                        height: 250, // Fotoğraf seç butonuna üstten boşluk
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
                          borderRadius:
                              BorderRadius.circular(10), // Köşeleri yuvarlama
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
                              'Bulunduğu Tarih (*)',
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
                          labelText: 'Ad',
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
                          labelText: 'Yaş',
                          focusNode: yasFocusNode,
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
                          labelText: 'Tür',
                          focusNode: turFocusNode,
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
                          borderRadius:
                              BorderRadius.circular(10), // Köşeleri yuvarlama
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
                          borderRadius:
                              BorderRadius.circular(10), // Köşeleri yuvarlama
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
                          items: <String>['Dişi', 'Erkek', 'Bilinmiyor']
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
                          labelText: 'Bulunduğu İl (*)',
                          focusNode: ilFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen hayvanın bulunduğu ili girin';
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
                                      Text('Lütfen bulunduğu tarihi seçin'),
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

  // TextFormField'ı oluşturan fonksiyon
  Widget buildTextFormField({
    required String labelText,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    int? maxLength,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFCF5FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 0), // Çerçeve genişliğini artır
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Color(0xff783192)),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20), // İçeriği genişlet, sağa ve sola doğru
          ),
          textAlign: TextAlign.left,
          focusNode: focusNode,
          validator: validator,
          onSaved: onSaved,
          maxLength: maxLength,
        ),
      ),
    );
  }

  Future<void> _saveToFirestore() async {
    try {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lütfen bulunduğu tarihi seçin'),
          ),
        );
        return; // Tarih seçilmemişse formu kaydetmeyi durdur
      }

      // Kullanıcının kimlik bilgilerini al
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Kullanıcının kimlik bilgileri varsa, kullanıcı id'sini al
        String userId = user.uid;
        // Fotoğrafın null olup olmadığını kontrol edin
        String? imagePath = _image?.path;
        // Kayıp koleksiyonuna veri ekle ve kullanıcı id'sini belgeye ekle
        DocumentReference docRef =
            await FirebaseFirestore.instance.collection('bulunan').add({
          'ad': _ad,
          'yas': _yas,
          'cins': _cins,
          'tur': _tur,
          'renk': _renk,
          'cinsiyet': _cinsiyet,
          'il': _il,
          'ekNot': _ekNot,
          'bulunantarih': _selectedDate,
          'createdAt':
              FieldValue.serverTimestamp(), // Belgenin oluşturulma tarihi
          'userId': userId, // Kullanıcı id'sini belgeye ekle
          // Fotoğrafı da ekleyin
          'foto': imagePath,
        });
        print("Hayvan başarıyla Firestore'a eklendi!");

        await addFoundItem(userId, docRef.id);
      } else {
        print('Kullanıcı oturumu yok');
      }
    } catch (e) {
      print("Hata: $e");
    }
  }
}
