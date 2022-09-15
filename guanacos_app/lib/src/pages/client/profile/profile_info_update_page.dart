import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/pages/client/profile/profile_info_update_controller.dart';
import 'package:gunanacos_app/src/widgets/background_profile.dart';

// ignore: must_be_immutable
class ProfileUpdatePage extends StatelessWidget {
  ProfileUpdatePage({Key? key}) : super(key: key);

  ProfileUpdateController profileUpdateController =
      Get.put(ProfileUpdateController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundProfile(), 
          _buttonBack(), 
          imageUser(context),
          _formUpdate(context)
        ],
      ),
    );
  }


  Widget _formUpdate(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.30, left: 25, right: 25
          ),
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.height * 3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                  _txtYourInfo(),
                  _txtFieldName(),
                  const SizedBox(height: 20,),
                  _txtFieldApellido(),
                  const SizedBox(height: 20,),
                  _txtFieldPhone(),
                  const SizedBox(height: 20,),
                  _buttonRegister(context)
              ],
            ),
          ),
    );
  }

  Widget _txtYourInfo() {
    return Container(
        margin:const EdgeInsets.only(top: 20, bottom: 20),
        child:const Text('Actualizar Datos',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)));
  }

   Widget _txtFieldName() {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: profileUpdateController.nameController,
        keyboardType: TextInputType.text,
        decoration:
            const InputDecoration(hintText: 'Nombre', prefixIcon: Icon(Icons.person)),
      ),
    );
  }

  Widget _txtFieldApellido() {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: profileUpdateController.lastNameController,
        keyboardType: TextInputType.text,
        decoration:const InputDecoration(
            hintText: 'Apellido', prefixIcon: Icon(Icons.person_outline)),
      ),
    );
  }

  Widget _txtFieldPhone() {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: profileUpdateController.phoneController,
        keyboardType: TextInputType.phone,
        decoration:const InputDecoration(
            hintText: 'Telefono', prefixIcon: Icon(Icons.phone)),
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(left: 20),
      child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          )),
    ));
  }

  Widget _buttonRegister(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ElevatedButton(
          onPressed: () => profileUpdateController.updateUser(context),
          style: ElevatedButton.styleFrom(
              padding:const EdgeInsets.symmetric(vertical: 15)),
          child:const Text(
            'Actualizar',
            style: TextStyle(
                color: Color(0xff61481C), fontWeight: FontWeight.bold, fontSize: 15),
          ),

          
          ),
    );
  }

  Widget imageUser(BuildContext context) {
    ProfileUpdateController updateUserController =
        Get.put(ProfileUpdateController());
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(top: 40),
        child: GestureDetector(
          onTap: () => updateUserController.showAlertDialog(context),
          child: GetBuilder<ProfileUpdateController>(
            builder: (value) => CircleAvatar(
              backgroundImage: updateUserController.imgFile != null
                  ? FileImage(updateUserController.imgFile!)
                  :updateUserController.user.image != null ?
                    NetworkImage(updateUserController.user.image!) :
                   const AssetImage('assets/img/user_profile.png')
                      as ImageProvider,
              radius: 60,
              backgroundColor: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
