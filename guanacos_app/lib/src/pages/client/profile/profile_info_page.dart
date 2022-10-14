import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/pages/client/profile/profile_info_controller.dart';
import 'package:guanacos_app/src/pages/home/home_controller.dart';
import 'package:guanacos_app/src/widgets/background_profile.dart';

// ignore: must_be_immutable
class ProfileInfoPage extends StatelessWidget {

  ProfileInfoPage({Key? key}) : super(key: key);

  ProfileInfoController profileInfoController = Get.put(ProfileInfoController());
  HomeController hController = Get.put(HomeController());
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
        children: [
          const BackgroundProfile(),
          _imageUser(context),
          _options(context)
        ],
      )),
    );
  }

  Widget _option(String opt){
    if(opt == 'Perfil'){
      return Column(
        children: [
          ListTile(
            onTap: () => profileInfoController.goToUpdatePage(),
            title: Text(opt, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            leading:const Icon(Icons.edit, size: 30),
            trailing:const Icon(Icons.arrow_forward_ios, size: 30),
          ),
          const Divider()
        ],
      );
    }

    if(opt == 'Salir'){
      return Column(
        children: [
          ListTile(
            title: Text(opt, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            leading:const Icon(Icons.logout, size: 30),
            trailing:const Icon(Icons.arrow_forward_ios, size: 30),
            onTap: () => hController.logOut(),
          ),
          const Divider()
        ],
      );
    }
    if(opt == 'Roles'){
      return Column(
        children: [
          ListTile(
            title: Text(opt, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            leading:const Icon(Icons.supervised_user_circle, size: 30),
            trailing:const Icon(Icons.arrow_forward_ios, size: 30),
            onTap: () => profileInfoController.goToRoles()
          ),
          const Divider()
        ],
      );
    }

    return const Text('data');
  }


  Widget _options(BuildContext context){
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
        child: ListView(
          padding:const EdgeInsets.all(0),
          children: [
            ...profileInfoController.options.map(
                (opt) => _option(opt)).toList(),
          ],
        ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: CircleAvatar(
                backgroundImage: profileInfoController.user.value.image != null
                    ? NetworkImage(profileInfoController.user.value.image!)
                    : const AssetImage('assets/img/user_profile.png') as ImageProvider,
                radius: 60,
                backgroundColor: Colors.amber,
              ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
              '${profileInfoController.user.value.name!} ${profileInfoController.user.value.lastName!}',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
          )
        ],
      ),
    );
  }
}
