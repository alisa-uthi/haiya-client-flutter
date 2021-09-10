import 'package:haiya_client/shared/models/faq_item.dart';

class ConstantService {
  static List<String> dummyDrugAllergyOptions() {
    return [
      "Penicillin",
      "Antibiotics containing sulfonamides",
      "Anticonvulsants",
      "Aspirin",
      "Chemotherapy drugs",
    ];
  }

  static List<String> dummyCongentialDiseaseOptions() {
    return [
      "Asthma",
      "Cleft lip and cleft palate",
      "Cerebral palsy",
      "Down syndrome",
      "Spina bifida",
      "Cystic fibrosis",
      "Heart conditions",
    ];
  }

  static List<String> dummyIssueType() {
    return [
      "Application",
      "Pharmacy or Product",
      "Order",
      "Delivery",
      "Other",
    ];
  }

  static List<FaqItem> dummyFaqList() {
    return [
      new FaqItem(
        headerItem: "How to change name?",
        discription:
            '1. Click "Account" at the bottom of the screen\n2. Select "Personal Information".\n3. Click "EDIT" beside your name.\n4. Edit your name and click "CONFIRM".',
      ),
      new FaqItem(
        headerItem: "How to change password?",
        discription:
            '1. Click "Account" at the bottom of the screen\n2. Select "Settings".\n3. Change your password and click "SAVE PASSWORD".',
      ),
    ];
  }
}
