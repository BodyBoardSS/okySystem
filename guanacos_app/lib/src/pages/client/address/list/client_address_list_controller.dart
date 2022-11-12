
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/models/address.dart';
import 'package:guanacos_app/src/models/user.dart';
import 'package:guanacos_app/src/providers/address_provider.dart';

class ClientAddressListController extends GetxController{

  AddressProvider addressProvider = AddressProvider();
  List<Address> address = [];

  User user = User.fromJson(GetStorage().read('user') ?? {});

  var radioValue = 0.obs;

  void goToAddressCreate(){
    Get.toNamed('/client/address/create');
  }

  Future<List<Address>> getAddress() async{
    address = await addressProvider.getAllByUser(user.id ?? 0);
    if(GetStorage().read('address') != null && GetStorage().read('address') is List<Address>){
      Address a = GetStorage().read('address');

      int index = address.indexWhere((ad) => ad.id == a.id);

      if(index != -1){
        radioValue.value = index;
      }
    } else {
      GetStorage().write('address', address[0]);
    }


    return address;
  }

  void handleRadioValueChange(int? value){
    radioValue.value = value!;
    GetStorage().write('address', address[value]);
    update();
  }

  void goToPaymentsCreate(){
    Get.toNamed('/client/payments/list');
  }
}