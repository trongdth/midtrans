class Product {
  String productId;
  String productName;
  String productDesc;
  String productImageName;
  String productPrice;

  static const PRODUCT_ID = "id";
  static const PRODUCT_NAME = "name";
  static const PRODUCT_DESC = "desc";
  static const PRODUCT_IMAGE_NAME = "image_name";
  static const PRODUCT_PRICE = "price";

  Product({this.productId, this.productName, this.productDesc, this.productImageName, this.productPrice});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      PRODUCT_ID: productId,
      PRODUCT_NAME: productName,
      PRODUCT_DESC: productDesc,
      PRODUCT_IMAGE_NAME: productImageName,
      PRODUCT_PRICE: productPrice,
    };
    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    productId = map[PRODUCT_ID] as String;
    productName = map[PRODUCT_NAME] as String;
    productDesc = map[PRODUCT_DESC] as String;
    productImageName = map[PRODUCT_IMAGE_NAME] as String;
    productPrice = map[PRODUCT_PRICE] as String;
  }
}
