import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/assets.dart';

import '../../features/order/shopping_cart/models/cart_item.dart';
import '../../features/product/models/sell_type.dart';

const bannersMock = [
  'https://delivery.patao.com.br/arquivos/smd_home_22_09_17_oferta_slider_Spaten1.png?v=637998969138700000',
  'https://delivery.patao.com.br/arquivos/smd_home_22_09_17_oferta_slider_Spaten1.png?v=637998969138700000',
  'https://delivery.patao.com.br/arquivos/smd_home_22_09_17_oferta_slider_Spaten1.png?v=637998969138700000',
  'https://delivery.patao.com.br/arquivos/smd_home_22_09_17_oferta_slider_Spaten1.png?v=637998969138700000',
  'https://delivery.patao.com.br/arquivos/smd_home_22_09_17_oferta_slider_Spaten1.png?v=637998969138700000',
];

const categoriesMock = [
  Category(
    id: 1,
    name: 'Fruits & Vegetables',
    imageUrl: Assets.fruitsAndVegetablesImage,
    iconUrl: Assets.fruitsAndVegetablesIcon,
    color: kGreenColor,
  ),
  Category(
    id: 2,
    name: 'Dairy & Bakery',
    imageUrl: Assets.fruitsAndVegetablesImage,
    iconUrl: Assets.fruitsAndVegetablesIcon,
    color: kLightBrownColor,
  ),
  Category(
    id: 3,
    name: 'Staples',
    imageUrl: Assets.fruitsAndVegetablesImage,
    iconUrl: Assets.fruitsAndVegetablesIcon,
    color: kMediumBrownColor,
  ),
  Category(
    id: 4,
    name: 'Snacks & Branded Foods',
    imageUrl: Assets.fruitsAndVegetablesImage,
    iconUrl: Assets.fruitsAndVegetablesIcon,
    color: kBrownColor,
  ),
  Category(
    id: 5,
    name: 'Beverages',
    imageUrl: Assets.fruitsAndVegetablesImage,
    iconUrl: Assets.fruitsAndVegetablesIcon,
    color: kGreyColor,
  ),
  Category(
    id: 6,
    name: 'Personal Care',
    imageUrl: Assets.fruitsAndVegetablesImage,
    iconUrl: Assets.fruitsAndVegetablesIcon,
    color: kPurpleColor,
  ),
  Category(
    id: 7,
    name: 'Home Care',
    imageUrl: Assets.fruitsAndVegetablesImage,
    iconUrl: Assets.fruitsAndVegetablesIcon,
    color: kBlueColor,
  ),
  Category(
    id: 8,
    name: 'Baby Care',
    imageUrl: Assets.fruitsAndVegetablesImage,
    iconUrl: Assets.fruitsAndVegetablesIcon,
    color: kPinkColor,
  ),
  Category(
    id: 9,
    name: 'Home & Kitchen',
    imageUrl: Assets.fruitsAndVegetablesImage,
    iconUrl: Assets.fruitsAndVegetablesIcon,
    color: kLightGreyColor,
  ),
  Category(
    id: 10,
    name: 'Pet Foods',
    imageUrl: Assets.fruitsAndVegetablesImage,
    iconUrl: Assets.fruitsAndVegetablesIcon,
    color: kWeakBrownColor,
  ),
];

final productsMock = [
  Product(
    id: 1,
    name: 'Broccoli',
    imageUrl:
        'https://toppng.com/uploads/preview/broccoli-11546982769b24nyuwjow.png',
    description: 'A green broccoli made with love from modern farmers',
    value: 85,
    createdAt: DateTime.now(),
    category: categoriesMock[0],
    sellType: SellType.weight,
    isFavorite: true,
    weightInKg: 1,
  ),
  Product(
    id: 2,
    name: 'Delight Nuts Raw Seeds Pumpkin',
    imageUrl:
        'https://www.pngitem.com/pimgs/m/121-1218157_delight-nuts-dry-fruits-all-png-download-delight.png',
    description: 'A Delight Nuts Raw Seeds Pumpkin',
    value: 165,
    createdAt: DateTime.now(),
    category: categoriesMock[2],
    sellType: SellType.weight,
    isFavorite: true,
    weightInKg: 0.75,
  ),
  Product(
    id: 3,
    name: 'Bakery Panini Small Bread Basket',
    imageUrl:
        'https://e7.pngegg.com/pngimages/170/798/png-clipart-bakery-panini-small-bread-basket-bread-material-free-to-pull-baked-goods-free-logo-design-template-thumbnail.png',
    description: 'Bakery Panini Small Bread Basket',
    value: 38,
    createdAt: DateTime.now(),
    category: categoriesMock[1],
    sellType: SellType.weight,
    weightInKg: 1,
    promotionPercent: 15,
  ),
  Product(
    id: 4,
    name: 'Britannia Bourbon Original Cream Biscuits',
    imageUrl: 'https://unidexmobile.com/img/products/E022005.png',
    description: 'A Britannia Bourbon Original Cream Biscuits',
    value: 85,
    createdAt: DateTime.now(),
    category: categoriesMock[3],
    sellType: SellType.weight,
    weightInKg: 0.75,
  ),
];

final cartItemsMock = [
  CartItem(id: 1, product: productsMock[0], quantity: 1),
  CartItem(id: 2, product: productsMock[1], quantity: 2),
  CartItem(id: 3, product: productsMock[2], quantity: 1),
  CartItem(id: 4, product: productsMock[3], quantity: 1),
];

const addressMock = [
  Address(
    id: 1,
    name: 'Home',
    address: 'A/234, Kigs Plazaa, Mithakhali, Ahmedabad, Gujarat',
    phone: '+91 234 567 8900',
  ),
  Address(
    id: 2,
    name: 'Office',
    address: 'B/104, Lawesh Tower, Pondichory, Ahmedabad, Gujarat',
    phone: '+91 567 890 2340',
  ),
];
