import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/address.dart';
import 'package:haiya_client/shared/models/catalog.dart';
import 'package:haiya_client/shared/models/operation_time.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/models/productCategory.dart';
import 'package:haiya_client/shared/models/productGenericName.dart';
import 'package:haiya_client/shared/models/productImage.dart';
import 'package:haiya_client/shared/models/user_detail.dart';

class ConstantService {
  static UserDetail dummyCurrentUser() {
    return UserDetail(
      id: 1,
      userId: 'PSN00001',
      firstName: "Benimaru",
      lastName: "Shinmon",
      gender: "Male",
      phone: "0804488048",
      dob: "1999-02-24",
      height: 155,
      email: 'example@example.com',
      password: '',
      title: 'Mr.',
      weight: 155,
      address: dummyUserAddress(),
    );
  }

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

  static Address dummyUserAddress() {
    return Address(
      id: 1,
      addrId: 'Addr000001',
      addrDistrict: 'district',
      addrNo: '123/23',
      addrPostalCode: 10120,
      addrProvince: 'bkk',
      addrRoad: 'road',
      addrSubDistrict: 'subdistrict',
      addrLatitude: 1.28210155,
      addrLongitude: 103.8172248,
    );
  }

  static List<Product> dummyProducts() {
    return [
      Product(
        id: 1,
        productId: 'PRD0000004',
        tradeCode: 'ACT06',
        tradeName: 'Actonel Tab. 35 mg',
        companyName: 'Sanofi aventis',
        presReq: 'N',
        genericName: [
          ProductGenericName(productId: 1, genericName: 'Risedronate sodium')
        ],
        category: [ProductCategory(productId: 1, category: 'Drug')],
        image: [ProductImage(productId: 1, image: 'image path')],
        genericAdvice:
            """Take at least 30 min before the 1st food/drink/medication of the day and on the same day each mth. 
                Take with a full glass (180-240 mL) of plain water while in an upright position. Do not lie down for at least 30 min after taking. Swallow whole, do not chew/crush/suck.""",
        qtyUnit: 10,
        detail: """ Osteoporosis due to corticosteroids
          Paget's disease
          Postmenopausal osteoporosis
          Postmenopausal osteoporosis; Prophylaxis
          """,
        catalog: Catalog(
          pharmacyName: "ICT Pharmacy",
          productId: 1,
          lot: 1,
          availQty: 10,
          price: 120,
          exp: '2026-03-22',
        ),
      ),
      Product(
        id: 2,
        productId: 'PRD0000005',
        tradeCode: 'ACT07',
        tradeName: 'Actosmet Tab. 850/15 mg',
        companyName: 'Takeda',
        presReq: 'N',
        genericName: [
          ProductGenericName(
              productId: 1, genericName: 'Metformin, Pioglitazone')
        ],
        category: [ProductCategory(productId: 2, category: 'Drug')],
        image: [ProductImage(productId: 2, image: 'image path')],
        genericAdvice:
            """Take at least 30 min before the 1st food/drink/medication of the day and on the same day each mth. 
                Take with a full glass (180-240 mL) of plain water while in an upright position. Do not lie down for at least 30 min after taking. Swallow whole, do not chew/crush/suck.""",
        qtyUnit: 10,
        detail:
            """ It is used as an adjunct therapy to diet and exercise to help improve the glycemic control.""",
        catalog: Catalog(
          pharmacyName: "Kimmy Pharmacy",
          productId: 2,
          lot: 1,
          availQty: 10,
          price: 150,
          exp: '2026-03-22',
        ),
      ),
      Product(
        id: 3,
        productId: 'PRD0000006',
        tradeCode: 'ADA02',
        tradeName: 'Adalat Cap. 10 mg',
        companyName: 'Bayer Schering Pharma AG',
        presReq: 'Y',
        genericName: [
          ProductGenericName(productId: 3, genericName: 'Nifedipine')
        ],
        category: [ProductCategory(productId: 3, category: 'Drug')],
        image: [ProductImage(productId: 3, image: 'image path')],
        genericAdvice:
            """Take at least 30 min before the 1st food/drink/medication of the day and on the same day each mth. 
                Take with a full glass (180-240 mL) of plain water while in an upright position. Do not lie down for at least 30 min after taking. Swallow whole, do not chew/crush/suck.""",
        qtyUnit: 10,
        detail: """ 1.Angina and hypertension
          2.Pulmonary hypertension
        """,
        catalog: Catalog(
          pharmacyName: "ICT Pharmacy",
          productId: 3,
          lot: 1,
          availQty: 10,
          price: 110,
          exp: '2026-03-22',
        ),
      ),
      Product(
        id: 4,
        productId: 'PRD0000007',
        tradeCode: 'ADA01',
        tradeName: 'Addi-K Tab.',
        companyName: 'LEO Pharma',
        presReq: 'Y',
        genericName: [
          ProductGenericName(
              productId: 4, genericName: 'Potassium chloride (KCl)')
        ],
        category: [ProductCategory(productId: 4, category: 'Drug')],
        image: [ProductImage(productId: 4, image: 'image path')],
        genericAdvice:
            """Take at least 30 min before the 1st food/drink/medication of the day and on the same day each mth. 
                Take with a full glass (180-240 mL) of plain water while in an upright position. Do not lie down for at least 30 min after taking. Swallow whole, do not chew/crush/suck.""",
        qtyUnit: 10,
        detail: """ Treatment of prevention of hypokalemia""",
        catalog: Catalog(
          pharmacyName: "Kimmy Pharmacy",
          productId: 4,
          lot: 1,
          availQty: 10,
          price: 220,
          exp: '2026-03-22',
        ),
      ),
      Product(
        id: 5,
        productId: 'PRD0000052',
        tradeName: 'Centrum Women Multivitamins and Minerals 30 Tablets',
        companyName: 'Pfizer Consumer Healthcare Ltd',
        presReq: 'N',
        category: [ProductCategory(productId: 5, category: 'Supplementary')],
        image: [ProductImage(productId: 5, image: 'image path')],
        qtyUnit: 30,
        detail: "Multivitamin-multimineral food supplement for adults under 50",
        catalog: Catalog(
          pharmacyName: "Kimmy Pharmacy",
          productId: 5,
          lot: 1,
          availQty: 10,
          price: 170,
          exp: '2026-03-22',
        ),
      ),
      Product(
        id: 6,
        productId: 'PRD0000060',
        tradeName:
            'Centrum Fruity Chewables - 30 citrus berry flavoured tablets with sweetener',
        companyName: 'Pfizer Consumer Healthcare Ltd',
        presReq: 'N',
        category: [ProductCategory(productId: 6, category: 'Supplementary')],
        image: [ProductImage(productId: 6, image: 'image path')],
        qtyUnit: 180,
        detail:
            "Food Supplement with vitamins and minerals for adults, with sugar & sweeteners",
        catalog: Catalog(
          pharmacyName: "ICT Pharmacy",
          productId: 6,
          lot: 1,
          availQty: 10,
          price: 120,
          exp: '2026-03-22',
        ),
      ),
      Product(
        id: 7,
        productId: 'PRD0000074',
        tradeName: 'DIOR Capture Totale Super Potent Face Serum 50ml',
        companyName: 'LVMH',
        presReq: 'N',
        category: [ProductCategory(productId: 7, category: 'Cosmeceutical')],
        image: [ProductImage(productId: 7, image: 'image path')],
        qtyUnit: 180,
        detail:
            "The serum's formula incorporates a next-generation hyaluronic acid",
        catalog: Catalog(
          pharmacyName: "Kimmy Pharmacy",
          productId: 7,
          lot: 1,
          availQty: 10,
          price: 160,
          exp: '2026-03-22',
        ),
      ),
      Product(
        id: 8,
        productId: 'PRD0000075',
        tradeName: 'Farmologie Moisturiser Pink Grapefruit 400ml',
        companyName: 'Farmologie',
        presReq: 'N',
        category: [ProductCategory(productId: 8, category: 'Cosmeceutical')],
        image: [ProductImage(productId: 8, image: 'image path')],
        qtyUnit: 180,
        detail:
            "Moisturise with confidence! This deeply hydrating and fast-absorbing moisturiser by Farmologie soothes and nourishes your skin.",
        catalog: Catalog(
          pharmacyName: "ICT Pharmacy",
          productId: 8,
          lot: 1,
          availQty: 10,
          price: 320,
          exp: '2026-03-22',
        ),
      ),
      Product(
        id: 9,
        productId: 'PRD0000088',
        tradeName: 'DNA Clinics Paternity DNA Test Kit',
        companyName: 'DNAClinic',
        presReq: 'N',
        category: [ProductCategory(productId: 9, category: 'Equipment')],
        image: [ProductImage(productId: 9, image: 'image path')],
        qtyUnit: 180,
        detail: "Paternity DNA Test Kit",
        catalog: Catalog(
          pharmacyName: "Kimmy Pharmacy",
          productId: 9,
          lot: 1,
          availQty: 10,
          price: 170,
          exp: '2026-03-22',
        ),
      ),
      Product(
        id: 10,
        productId: 'PRD0000089',
        tradeName:
            'Boots Protective FFP2 NR Face Masks 5 Single Use Respirators',
        companyName: 'The Boots Company PLC',
        presReq: 'N',
        category: [ProductCategory(productId: 5, category: 'Equipment')],
        image: [ProductImage(productId: 1, image: 'image path')],
        qtyUnit: 180,
        detail: "Protective Face Mask",
        catalog: Catalog(
          pharmacyName: "ICT Pharmacy",
          productId: 10,
          lot: 1,
          availQty: 10,
          price: 120,
          exp: '2026-03-22',
        ),
      ),
    ];
  }

  static Pharmacy dummySelectedPharmacy() {
    return Pharmacy(
      id: 2,
      pharmacyId: 'PCY0000014',
      name: 'ICT Pharmacy',
      email: 'ictpharma2021@gmail.com',
      phone: '0802849832',
      image: "C://image/pharmax",
      address: Address(
        id: 2,
        addrId: 'Addr000002',
        addrDistrict: 'ICT Pharmacy District',
        addrNo: '134/29',
        addrPostalCode: 14803,
        addrProvince: 'bkk',
        addrRoad: 'ICT Pharmacy Road',
        addrSubDistrict: 'ICT Pharmacy Subdistrict',
        addrLatitude: 3.28210155,
        addrLongitude: 109.8172248,
      ),
      products: dummyProducts(),
      distanceFromCurrentLoc: '1.00 km',
      operationTime: OperationTime(
        openHr: '09.00 AM',
        closeHr: '11.00 PM',
        isOpen: true,
      ),
    );
  }

  static List<Pharmacy> dummyPharmacies() {
    return [
      Pharmacy(
        id: 1,
        pharmacyId: 'PCY0000013',
        name: 'Kimmy Pharmacy',
        email: 'kimmypharma2021@gmail.com',
        phone: '0851345824',
        image: "C://image/pharmax",
        address: Address(
          id: 3,
          addrId: 'Addr000003',
          addrDistrict: 'Kimmy Pharmacy District',
          addrNo: '134/29',
          addrPostalCode: 14803,
          addrProvince: 'bkk',
          addrRoad: 'Kimmy Pharmacy Road',
          addrSubDistrict: 'Kimmy Pharmacy Subdistrict',
          addrLatitude: 8.28210155,
          addrLongitude: 116.8172248,
        ),
        products: dummyProducts(),
        distanceFromCurrentLoc: '1.00 km',
        operationTime: OperationTime(
          openHr: '08.00 AM',
          closeHr: '09.00 PM',
          isOpen: true,
        ),
      ),
      Pharmacy(
        id: 2,
        pharmacyId: 'PCY0000014',
        name: 'ICT Pharmacy',
        email: 'ictpharma2021@gmail.com',
        phone: '0802849832',
        image: "C://image/pharmax",
        address: Address(
          id: 2,
          addrId: 'Addr000002',
          addrDistrict: 'ICT Pharmacy District',
          addrNo: '134/29',
          addrPostalCode: 14803,
          addrProvince: 'bkk',
          addrRoad: 'ICT Pharmacy Road',
          addrSubDistrict: 'ICT Pharmacy Subdistrict',
          addrLatitude: 3.28210155,
          addrLongitude: 109.8172248,
        ),
        products: dummyProducts(),
        distanceFromCurrentLoc: '1.50 km',
        operationTime: OperationTime(
          openHr: '08.00 AM',
          closeHr: '09.00 PM',
          isOpen: false,
        ),
      ),
    ];
  }
}
