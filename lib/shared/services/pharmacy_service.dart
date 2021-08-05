import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/services/constant_service.dart';

class PharmacyService {
  Future<Pharmacy> getPharmacyById(int id) async {
    return ConstantService.dummySelectedPharmacy();
  }

  Future<List<Pharmacy>> getAllPharmacies() async {
    return ConstantService.dummyPharmacies();
  }
}
