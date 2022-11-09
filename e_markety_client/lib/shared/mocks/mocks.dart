import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/features/order/address/models/district.dart';
import 'package:e_markety_client/features/order/address/models/tag.dart';
import 'package:e_markety_client/features/product/models/measure_unit.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/assets.dart';

import '../../features/order/order/models/delivery_tipe.dart';
import '../../features/order/order/models/order.dart';
import '../../features/order/order/models/order_status.dart';
import '../../features/order/shopping_cart/models/cart_item.dart';
import '../../features/user/models/user.dart';

const bannersMock = [
  'https://delivery.patao.com.br/arquivos/smd_home_22_09_17_oferta_slider_Spaten1.png?v=637998969138700000',
  'https://delivery.patao.com.br/arquivos/smd_home_22_09_17_oferta_slider_Spaten1.png?v=637998969138700000',
  'https://delivery.patao.com.br/arquivos/smd_home_22_09_17_oferta_slider_Spaten1.png?v=637998969138700000',
  'https://delivery.patao.com.br/arquivos/smd_home_22_09_17_oferta_slider_Spaten1.png?v=637998969138700000',
  'https://delivery.patao.com.br/arquivos/smd_home_22_09_17_oferta_slider_Spaten1.png?v=637998969138700000',
];

final categoriesMock = [
  Category(
    id: 1,
    name: 'Fruits & Vegetables',
    imageUrl: Assets.hortifrutiImage,
    iconUrl: Assets.hortifrutiIcon,
    colorString: kGreenColor.toString(),
  ),
  Category(
    id: 2,
    name: 'Dairy & Bakery',
    imageUrl: Assets.hortifrutiImage,
    iconUrl: Assets.hortifrutiIcon,
    colorString: kLightBrownColor.toString(),
  ),
  Category(
    id: 3,
    name: 'Staples',
    imageUrl: Assets.hortifrutiImage,
    iconUrl: Assets.hortifrutiIcon,
    colorString: kMediumBrownColor.toString(),
  ),
  Category(
    id: 4,
    name: 'Snacks & Branded Foods',
    imageUrl: Assets.hortifrutiImage,
    iconUrl: Assets.hortifrutiIcon,
    colorString: kBrownColor.toString(),
  ),
  Category(
    id: 5,
    name: 'Beverages',
    imageUrl: Assets.hortifrutiImage,
    iconUrl: Assets.hortifrutiIcon,
    colorString: kGreyColor.toString(),
  ),
  Category(
    id: 6,
    name: 'Personal Care',
    imageUrl: Assets.hortifrutiImage,
    iconUrl: Assets.hortifrutiIcon,
    colorString: kPurpleColor.toString(),
  ),
  Category(
    id: 7,
    name: 'Home Care',
    imageUrl: Assets.hortifrutiImage,
    iconUrl: Assets.hortifrutiIcon,
    colorString: kBlueColor.toString(),
  ),
  Category(
    id: 8,
    name: 'Baby Care',
    imageUrl: Assets.hortifrutiImage,
    iconUrl: Assets.hortifrutiIcon,
    colorString: kPinkColor.toString(),
  ),
  Category(
    id: 9,
    name: 'Home & Kitchen',
    imageUrl: Assets.hortifrutiImage,
    iconUrl: Assets.hortifrutiIcon,
    colorString: kLightGreyColor.toString(),
  ),
  Category(
    id: 10,
    name: 'Pet Foods',
    imageUrl: Assets.hortifrutiImage,
    iconUrl: Assets.hortifrutiIcon,
    colorString: kWeakBrownColor.toString(),
  ),
];

const measureUnitsMock = [
  MeasureUnit(id: 1, description: 'Unidade', abbreviation: 'UN'),
  MeasureUnit(id: 2, description: 'Quilograma', abbreviation: 'KG'),
  MeasureUnit(id: 3, description: 'Litro', abbreviation: 'LT'),
];

final productsMock = [
  Product(
    id: 1,
    name: 'Broccoli',
    imageUrl:
        'https://toppng.com/uploads/preview/broccoli-11546982769b24nyuwjow.png',
    description: 'A green broccoli made with love from modern farmers',
    price: 85,
    createdAt: DateTime.now(),
    category: categoriesMock[0],
    weightPrice: 1,
    quantitySold: 5,
    stock: 100,
    discountPercent: 0,
    measureUnit: measureUnitsMock[1],
    weightUnit: 0.05,
  ),
  Product(
    id: 2,
    name: 'Delight Nuts Raw Seeds Pumpkin',
    imageUrl:
        'https://www.pngitem.com/pimgs/m/121-1218157_delight-nuts-dry-fruits-all-png-download-delight.png',
    description: 'A Delight Nuts Raw Seeds Pumpkin',
    price: 165,
    createdAt: DateTime.now(),
    category: categoriesMock[2],
    weightPrice: 0.75,
    weightUnit: 0.75,
    quantitySold: 6,
    stock: 20,
    discountPercent: 0,
    measureUnit: measureUnitsMock[1],
  ),
  Product(
    id: 3,
    name: 'Bakery Panini Small Bread Basket',
    imageUrl:
        'https://e7.pngegg.com/pngimages/170/798/png-clipart-bakery-panini-small-bread-basket-bread-material-free-to-pull-baked-goods-free-logo-design-template-thumbnail.png',
    description: 'Bakery Panini Small Bread Basket',
    price: 38,
    createdAt: DateTime.now(),
    category: categoriesMock[1],
    weightPrice: 1,
    weightUnit: 0.5,
    discountPercent: 15,
    quantitySold: 100,
    stock: 17,
    measureUnit: measureUnitsMock[1],
  ),
  Product(
    id: 4,
    name: 'Britannia Bourbon Original Cream Biscuits',
    imageUrl:
        'https://www.bigbasket.com/media/uploads/p/xxl/1201309-2_1-britannia-bourbon-cream-biscuit-chocolate-flavor.jpg',
    description: 'A Britannia Bourbon Original Cream Biscuits',
    price: 85,
    createdAt: DateTime.now(),
    category: categoriesMock[3],
    weightPrice: 0.75,
    weightUnit: 0.75,
    quantitySold: 40,
    stock: 12,
    discountPercent: 0,
    measureUnit: measureUnitsMock[1],
  ),
];

final cartItemsMock = [
  CartItem(product: productsMock[0], quantity: 1),
  CartItem(product: productsMock[1], quantity: 2),
  CartItem(product: productsMock[2], quantity: 1),
  CartItem(product: productsMock[3], quantity: 5),
];

const districsMock = [
  District(id: 1, name: 'Mithakhali'),
  District(id: 2, name: 'Pondichory'),
];

final addressMock = [
  Address(
    id: 1,
    tag: Tag.home,
    street: 'A/234, Kigs Plaza',
    district: districsMock[0],
    name: 'Lucy Martin',
    isDefault: true,
    phone: '+91 234 567 8900',
    reference: 'ASDskaodksaodksasdsadsad sadsa dasdasdsad',
  ),
  Address(
    id: 2,
    tag: Tag.office,
    street: 'B/104, Lawesh Tower',
    name: 'John Martin',
    phone: '+91 567 890 2340',
    district: districsMock[1],
    reference: 'Near to the bus stop',
  ),
];

final orderMock = Order(
  id: 2204,
  createdAt: DateTime.now(),
  deliveryType: DeliveryType.delivery,
  items: cartItemsMock,
  notes: 'Please deliver the order as soon as possible',
  deliveryAddress: addressMock[0],
  deliveryCharge: 0,
  deliveryTime: DateTime.now().add(const Duration(hours: 2)),
  total: 22,
);

final ordersMock = [
  orderMock,
  Order(
    id: 2203,
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    deliveryType: DeliveryType.delivery,
    items: cartItemsMock,
    notes: 'Please deliver the order as soon as possible',
    deliveryAddress: addressMock[0],
    deliveryCharge: 0,
    deliveryTime: DateTime.now().add(const Duration(hours: 2)),
    status: OrderStatus.confirmed,
    total: 32,
  ),
  Order(
    id: 2202,
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    deliveryType: DeliveryType.delivery,
    items: cartItemsMock,
    notes: 'Please deliver the order as soon as possible',
    deliveryAddress: addressMock[0],
    deliveryCharge: 0,
    deliveryTime: DateTime.now().add(const Duration(hours: 2)),
    status: OrderStatus.readyToDeliver,
    total: 35,
  ),
  Order(
    id: 2201,
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    deliveryType: DeliveryType.delivery,
    items: cartItemsMock,
    notes: 'Please deliver the order as soon as possible',
    deliveryAddress: addressMock[0],
    deliveryCharge: 0,
    deliveryTime: DateTime.now().add(const Duration(hours: 2)),
    status: OrderStatus.outForDelivery,
    total: 25,
  ),
  Order(
    id: 2200,
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    deliveryType: DeliveryType.delivery,
    items: cartItemsMock,
    notes: 'Please deliver the order as soon as possible',
    deliveryAddress: addressMock[0],
    deliveryCharge: 0,
    deliveryTime: DateTime.now().add(const Duration(hours: 2)),
    status: OrderStatus.delivered,
    total: 87,
  )
];

const userMock = User(
  id: 1,
  name: 'Lucy Martin',
  email: 'lucymartin@gmail.com',
  avatarUrl: 'https://avatars.githubusercontent.com/u/45719696',
);
