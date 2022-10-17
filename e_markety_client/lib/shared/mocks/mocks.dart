import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/features/order/address/models/tag.dart';
import 'package:e_markety_client/features/order/models/order.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/assets.dart';

import '../../features/order/models/delivery_tipe.dart';
import '../../features/order/models/order_status.dart';
import '../../features/order/shopping_cart/models/cart_item.dart';
import '../../features/product/models/sell_type.dart';
import '../../features/user/models/user.dart';

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
    price: 85.0,
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
    price: 165,
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
    price: 38,
    createdAt: DateTime.now(),
    category: categoriesMock[1],
    sellType: SellType.weight,
    weightInKg: 1,
    isFavorite: true,
    promotionPercent: 15,
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
    sellType: SellType.weight,
    weightInKg: 0.75,
  ),
];

final cartItemsMock = [
  CartItem(id: 1, product: productsMock[0], quantity: 1),
  CartItem(id: 2, product: productsMock[1], quantity: 2),
  CartItem(id: 3, product: productsMock[2], quantity: 1),
  CartItem(id: 4, product: productsMock[3], quantity: 5),
];

const addressMock = [
  Address(
    id: 1,
    tag: Tag.home,
    address: 'A/234, Kigs Plaza',
    district: 'Mithakhali',
    city: 'Ahmedabad',
    zipcode: '380009',
    name: 'Lucy Martin',
    isDefault: true,
    phone: '+91 234 567 8900',
  ),
  Address(
    id: 2,
    tag: Tag.office,
    address: 'B/104, Lawesh Tower',
    name: 'John Martin',
    phone: '+91 567 890 2340',
    city: 'Ahmedabad',
    zipcode: '382415',
    district: 'Pondichory',
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
  status: OrderStatus.placed,
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
    status: OrderStatus.shipped,
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
  )
];

const userMock = User(
  id: 1,
  name: 'Lucy Martin',
  email: 'lucymartin@gmail.com',
  avatarUrl: 'https://avatars.githubusercontent.com/u/45719696',
);
