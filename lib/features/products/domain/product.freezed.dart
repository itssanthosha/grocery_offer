// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LatestPrice {

 String get priceId; String get storeId; String get chainId; String get branchName; double get lat; double get lng; int get priceBaisa; bool get isOffer;@NullableTimestampConverter() DateTime? get offerEndDate;@TimestampConverter() DateTime get reportedAt; int get confirmations; bool get verified; bool get hasPhoto; int get flags; String get reportedBy;
/// Create a copy of LatestPrice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatestPriceCopyWith<LatestPrice> get copyWith => _$LatestPriceCopyWithImpl<LatestPrice>(this as LatestPrice, _$identity);

  /// Serializes this LatestPrice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LatestPrice;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatestPrice&&(identical(other.priceId, _this.priceId) || other.priceId == _this.priceId)&&(identical(other.storeId, _this.storeId) || other.storeId == _this.storeId)&&(identical(other.chainId, _this.chainId) || other.chainId == _this.chainId)&&(identical(other.branchName, _this.branchName) || other.branchName == _this.branchName)&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng)&&(identical(other.priceBaisa, _this.priceBaisa) || other.priceBaisa == _this.priceBaisa)&&(identical(other.isOffer, _this.isOffer) || other.isOffer == _this.isOffer)&&(identical(other.offerEndDate, _this.offerEndDate) || other.offerEndDate == _this.offerEndDate)&&(identical(other.reportedAt, _this.reportedAt) || other.reportedAt == _this.reportedAt)&&(identical(other.confirmations, _this.confirmations) || other.confirmations == _this.confirmations)&&(identical(other.verified, _this.verified) || other.verified == _this.verified)&&(identical(other.hasPhoto, _this.hasPhoto) || other.hasPhoto == _this.hasPhoto)&&(identical(other.flags, _this.flags) || other.flags == _this.flags)&&(identical(other.reportedBy, _this.reportedBy) || other.reportedBy == _this.reportedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LatestPrice;
  return Object.hash(runtimeType,_this.priceId,_this.storeId,_this.chainId,_this.branchName,_this.lat,_this.lng,_this.priceBaisa,_this.isOffer,_this.offerEndDate,_this.reportedAt,_this.confirmations,_this.verified,_this.hasPhoto,_this.flags,_this.reportedBy);
}

@override
String toString() {
  final _this = this as LatestPrice;
  return 'LatestPrice(priceId: ${_this.priceId}, storeId: ${_this.storeId}, chainId: ${_this.chainId}, branchName: ${_this.branchName}, lat: ${_this.lat}, lng: ${_this.lng}, priceBaisa: ${_this.priceBaisa}, isOffer: ${_this.isOffer}, offerEndDate: ${_this.offerEndDate}, reportedAt: ${_this.reportedAt}, confirmations: ${_this.confirmations}, verified: ${_this.verified}, hasPhoto: ${_this.hasPhoto}, flags: ${_this.flags}, reportedBy: ${_this.reportedBy})';
}


}

/// @nodoc
abstract mixin class $LatestPriceCopyWith<$Res>  {
  factory $LatestPriceCopyWith(LatestPrice value, $Res Function(LatestPrice) _then) = _$LatestPriceCopyWithImpl;
@useResult
$Res call({
 String priceId, String storeId, String chainId, String branchName, double lat, double lng, int priceBaisa, bool isOffer,@NullableTimestampConverter() DateTime? offerEndDate,@TimestampConverter() DateTime reportedAt, int confirmations, bool verified, bool hasPhoto, int flags, String reportedBy
});




}
/// @nodoc
class _$LatestPriceCopyWithImpl<$Res>
    implements $LatestPriceCopyWith<$Res> {
  _$LatestPriceCopyWithImpl(this._self, this._then);

  final LatestPrice _self;
  final $Res Function(LatestPrice) _then;

/// Create a copy of LatestPrice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? priceId = null,Object? storeId = null,Object? chainId = null,Object? branchName = null,Object? lat = null,Object? lng = null,Object? priceBaisa = null,Object? isOffer = null,Object? offerEndDate = freezed,Object? reportedAt = null,Object? confirmations = null,Object? verified = null,Object? hasPhoto = null,Object? flags = null,Object? reportedBy = null,}) {
  return _then(LatestPrice(
priceId: null == priceId ? _self.priceId : priceId // ignore: cast_nullable_to_non_nullable
as String,storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,branchName: null == branchName ? _self.branchName : branchName // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,priceBaisa: null == priceBaisa ? _self.priceBaisa : priceBaisa // ignore: cast_nullable_to_non_nullable
as int,isOffer: null == isOffer ? _self.isOffer : isOffer // ignore: cast_nullable_to_non_nullable
as bool,offerEndDate: freezed == offerEndDate ? _self.offerEndDate : offerEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,confirmations: null == confirmations ? _self.confirmations : confirmations // ignore: cast_nullable_to_non_nullable
as int,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,hasPhoto: null == hasPhoto ? _self.hasPhoto : hasPhoto // ignore: cast_nullable_to_non_nullable
as bool,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as int,reportedBy: null == reportedBy ? _self.reportedBy : reportedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LatestPrice].
extension LatestPricePatterns on LatestPrice {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatestPrice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatestPrice() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatestPrice value)  $default,){
final _that = this;
switch (_that) {
case _LatestPrice():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatestPrice value)?  $default,){
final _that = this;
switch (_that) {
case _LatestPrice() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String priceId,  String storeId,  String chainId,  String branchName,  double lat,  double lng,  int priceBaisa,  bool isOffer, @NullableTimestampConverter()  DateTime? offerEndDate, @TimestampConverter()  DateTime reportedAt,  int confirmations,  bool verified,  bool hasPhoto,  int flags,  String reportedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatestPrice() when $default != null:
return $default(_that.priceId,_that.storeId,_that.chainId,_that.branchName,_that.lat,_that.lng,_that.priceBaisa,_that.isOffer,_that.offerEndDate,_that.reportedAt,_that.confirmations,_that.verified,_that.hasPhoto,_that.flags,_that.reportedBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String priceId,  String storeId,  String chainId,  String branchName,  double lat,  double lng,  int priceBaisa,  bool isOffer, @NullableTimestampConverter()  DateTime? offerEndDate, @TimestampConverter()  DateTime reportedAt,  int confirmations,  bool verified,  bool hasPhoto,  int flags,  String reportedBy)  $default,) {final _that = this;
switch (_that) {
case _LatestPrice():
return $default(_that.priceId,_that.storeId,_that.chainId,_that.branchName,_that.lat,_that.lng,_that.priceBaisa,_that.isOffer,_that.offerEndDate,_that.reportedAt,_that.confirmations,_that.verified,_that.hasPhoto,_that.flags,_that.reportedBy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String priceId,  String storeId,  String chainId,  String branchName,  double lat,  double lng,  int priceBaisa,  bool isOffer, @NullableTimestampConverter()  DateTime? offerEndDate, @TimestampConverter()  DateTime reportedAt,  int confirmations,  bool verified,  bool hasPhoto,  int flags,  String reportedBy)?  $default,) {final _that = this;
switch (_that) {
case _LatestPrice() when $default != null:
return $default(_that.priceId,_that.storeId,_that.chainId,_that.branchName,_that.lat,_that.lng,_that.priceBaisa,_that.isOffer,_that.offerEndDate,_that.reportedAt,_that.confirmations,_that.verified,_that.hasPhoto,_that.flags,_that.reportedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatestPrice implements LatestPrice {
  const _LatestPrice({required this.priceId, required this.storeId, required this.chainId, required this.branchName, required this.lat, required this.lng, required this.priceBaisa, this.isOffer = false, @NullableTimestampConverter() this.offerEndDate, @TimestampConverter() required this.reportedAt, this.confirmations = 0, this.verified = false, this.hasPhoto = false, this.flags = 0, this.reportedBy = ''});
  factory _LatestPrice.fromJson(Map<String, dynamic> json) => _$LatestPriceFromJson(json);

@override final  String priceId;
@override final  String storeId;
@override final  String chainId;
@override final  String branchName;
@override final  double lat;
@override final  double lng;
@override final  int priceBaisa;
@override@JsonKey() final  bool isOffer;
@override@NullableTimestampConverter() final  DateTime? offerEndDate;
@override@TimestampConverter() final  DateTime reportedAt;
@override@JsonKey() final  int confirmations;
@override@JsonKey() final  bool verified;
@override@JsonKey() final  bool hasPhoto;
@override@JsonKey() final  int flags;
@override@JsonKey() final  String reportedBy;

/// Create a copy of LatestPrice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatestPriceCopyWith<_LatestPrice> get copyWith => __$LatestPriceCopyWithImpl<_LatestPrice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatestPriceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatestPrice&&(identical(other.priceId, priceId) || other.priceId == priceId)&&(identical(other.storeId, storeId) || other.storeId == storeId)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.branchName, branchName) || other.branchName == branchName)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.priceBaisa, priceBaisa) || other.priceBaisa == priceBaisa)&&(identical(other.isOffer, isOffer) || other.isOffer == isOffer)&&(identical(other.offerEndDate, offerEndDate) || other.offerEndDate == offerEndDate)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.confirmations, confirmations) || other.confirmations == confirmations)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.hasPhoto, hasPhoto) || other.hasPhoto == hasPhoto)&&(identical(other.flags, flags) || other.flags == flags)&&(identical(other.reportedBy, reportedBy) || other.reportedBy == reportedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,priceId,storeId,chainId,branchName,lat,lng,priceBaisa,isOffer,offerEndDate,reportedAt,confirmations,verified,hasPhoto,flags,reportedBy);
}

@override
String toString() {
    return 'LatestPrice(priceId: $priceId, storeId: $storeId, chainId: $chainId, branchName: $branchName, lat: $lat, lng: $lng, priceBaisa: $priceBaisa, isOffer: $isOffer, offerEndDate: $offerEndDate, reportedAt: $reportedAt, confirmations: $confirmations, verified: $verified, hasPhoto: $hasPhoto, flags: $flags, reportedBy: $reportedBy)';
}


}

/// @nodoc
abstract mixin class _$LatestPriceCopyWith<$Res> implements $LatestPriceCopyWith<$Res> {
  factory _$LatestPriceCopyWith(_LatestPrice value, $Res Function(_LatestPrice) _then) = __$LatestPriceCopyWithImpl;
@override @useResult
$Res call({
 String priceId, String storeId, String chainId, String branchName, double lat, double lng, int priceBaisa, bool isOffer,@NullableTimestampConverter() DateTime? offerEndDate,@TimestampConverter() DateTime reportedAt, int confirmations, bool verified, bool hasPhoto, int flags, String reportedBy
});




}
/// @nodoc
class __$LatestPriceCopyWithImpl<$Res>
    implements _$LatestPriceCopyWith<$Res> {
  __$LatestPriceCopyWithImpl(this._self, this._then);

  final _LatestPrice _self;
  final $Res Function(_LatestPrice) _then;

/// Create a copy of LatestPrice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? priceId = null,Object? storeId = null,Object? chainId = null,Object? branchName = null,Object? lat = null,Object? lng = null,Object? priceBaisa = null,Object? isOffer = null,Object? offerEndDate = freezed,Object? reportedAt = null,Object? confirmations = null,Object? verified = null,Object? hasPhoto = null,Object? flags = null,Object? reportedBy = null,}) {
  return _then(_LatestPrice(
priceId: null == priceId ? _self.priceId : priceId // ignore: cast_nullable_to_non_nullable
as String,storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,branchName: null == branchName ? _self.branchName : branchName // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,priceBaisa: null == priceBaisa ? _self.priceBaisa : priceBaisa // ignore: cast_nullable_to_non_nullable
as int,isOffer: null == isOffer ? _self.isOffer : isOffer // ignore: cast_nullable_to_non_nullable
as bool,offerEndDate: freezed == offerEndDate ? _self.offerEndDate : offerEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,confirmations: null == confirmations ? _self.confirmations : confirmations // ignore: cast_nullable_to_non_nullable
as int,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,hasPhoto: null == hasPhoto ? _self.hasPhoto : hasPhoto // ignore: cast_nullable_to_non_nullable
as bool,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as int,reportedBy: null == reportedBy ? _self.reportedBy : reportedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Product {

@JsonKey(includeToJson: false) String get id; String? get barcode; String get name; String? get nameAr; String? get brand; String? get size; String? get unit; String get categoryId; String? get imageUrl; String get createdBy; List<String> get searchKeywords; Map<String, LatestPrice> get latestPrices;@NullableTimestampConverter() DateTime? get lastPriceAt;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Product;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.barcode, _this.barcode) || other.barcode == _this.barcode)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.nameAr, _this.nameAr) || other.nameAr == _this.nameAr)&&(identical(other.brand, _this.brand) || other.brand == _this.brand)&&(identical(other.size, _this.size) || other.size == _this.size)&&(identical(other.unit, _this.unit) || other.unit == _this.unit)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.createdBy, _this.createdBy) || other.createdBy == _this.createdBy)&&const DeepCollectionEquality().equals(other.searchKeywords, _this.searchKeywords)&&const DeepCollectionEquality().equals(other.latestPrices, _this.latestPrices)&&(identical(other.lastPriceAt, _this.lastPriceAt) || other.lastPriceAt == _this.lastPriceAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Product;
  return Object.hash(runtimeType,_this.id,_this.barcode,_this.name,_this.nameAr,_this.brand,_this.size,_this.unit,_this.categoryId,_this.imageUrl,_this.createdBy,const DeepCollectionEquality().hash(_this.searchKeywords),const DeepCollectionEquality().hash(_this.latestPrices),_this.lastPriceAt);
}

@override
String toString() {
  final _this = this as Product;
  return 'Product(id: ${_this.id}, barcode: ${_this.barcode}, name: ${_this.name}, nameAr: ${_this.nameAr}, brand: ${_this.brand}, size: ${_this.size}, unit: ${_this.unit}, categoryId: ${_this.categoryId}, imageUrl: ${_this.imageUrl}, createdBy: ${_this.createdBy}, searchKeywords: ${_this.searchKeywords}, latestPrices: ${_this.latestPrices}, lastPriceAt: ${_this.lastPriceAt})';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String id, String? barcode, String name, String? nameAr, String? brand, String? size, String? unit, String categoryId, String? imageUrl, String createdBy, List<String> searchKeywords, Map<String, LatestPrice> latestPrices,@NullableTimestampConverter() DateTime? lastPriceAt
});




}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? barcode = freezed,Object? name = null,Object? nameAr = freezed,Object? brand = freezed,Object? size = freezed,Object? unit = freezed,Object? categoryId = null,Object? imageUrl = freezed,Object? createdBy = null,Object? searchKeywords = null,Object? latestPrices = null,Object? lastPriceAt = freezed,}) {
  return _then(Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,searchKeywords: null == searchKeywords ? _self.searchKeywords : searchKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,latestPrices: null == latestPrices ? _self.latestPrices : latestPrices // ignore: cast_nullable_to_non_nullable
as Map<String, LatestPrice>,lastPriceAt: freezed == lastPriceAt ? _self.lastPriceAt : lastPriceAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String? barcode,  String name,  String? nameAr,  String? brand,  String? size,  String? unit,  String categoryId,  String? imageUrl,  String createdBy,  List<String> searchKeywords,  Map<String, LatestPrice> latestPrices, @NullableTimestampConverter()  DateTime? lastPriceAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.barcode,_that.name,_that.nameAr,_that.brand,_that.size,_that.unit,_that.categoryId,_that.imageUrl,_that.createdBy,_that.searchKeywords,_that.latestPrices,_that.lastPriceAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String? barcode,  String name,  String? nameAr,  String? brand,  String? size,  String? unit,  String categoryId,  String? imageUrl,  String createdBy,  List<String> searchKeywords,  Map<String, LatestPrice> latestPrices, @NullableTimestampConverter()  DateTime? lastPriceAt)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.barcode,_that.name,_that.nameAr,_that.brand,_that.size,_that.unit,_that.categoryId,_that.imageUrl,_that.createdBy,_that.searchKeywords,_that.latestPrices,_that.lastPriceAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String id,  String? barcode,  String name,  String? nameAr,  String? brand,  String? size,  String? unit,  String categoryId,  String? imageUrl,  String createdBy,  List<String> searchKeywords,  Map<String, LatestPrice> latestPrices, @NullableTimestampConverter()  DateTime? lastPriceAt)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.barcode,_that.name,_that.nameAr,_that.brand,_that.size,_that.unit,_that.categoryId,_that.imageUrl,_that.createdBy,_that.searchKeywords,_that.latestPrices,_that.lastPriceAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _Product extends Product {
  const _Product({@JsonKey(includeToJson: false) required this.id, this.barcode, required this.name, this.nameAr, this.brand, this.size, this.unit, required this.categoryId, this.imageUrl, required this.createdBy,  List<String> searchKeywords = const [],  Map<String, LatestPrice> latestPrices = const {}, @NullableTimestampConverter() this.lastPriceAt}): _searchKeywords = searchKeywords,_latestPrices = latestPrices,super._();
  factory _Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

@override@JsonKey(includeToJson: false) final  String id;
@override final  String? barcode;
@override final  String name;
@override final  String? nameAr;
@override final  String? brand;
@override final  String? size;
@override final  String? unit;
@override final  String categoryId;
@override final  String? imageUrl;
@override final  String createdBy;
 final  List<String> _searchKeywords;
@override@JsonKey() List<String> get searchKeywords {
  if (_searchKeywords is EqualUnmodifiableListView) return _searchKeywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchKeywords);
}

 final  Map<String, LatestPrice> _latestPrices;
@override@JsonKey() Map<String, LatestPrice> get latestPrices {
  if (_latestPrices is EqualUnmodifiableMapView) return _latestPrices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_latestPrices);
}

@override@NullableTimestampConverter() final  DateTime? lastPriceAt;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.size, size) || other.size == size)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other.searchKeywords, _searchKeywords)&&const DeepCollectionEquality().equals(other.latestPrices, _latestPrices)&&(identical(other.lastPriceAt, lastPriceAt) || other.lastPriceAt == lastPriceAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,barcode,name,nameAr,brand,size,unit,categoryId,imageUrl,createdBy,const DeepCollectionEquality().hash(_searchKeywords),const DeepCollectionEquality().hash(_latestPrices),lastPriceAt);
}

@override
String toString() {
    return 'Product(id: $id, barcode: $barcode, name: $name, nameAr: $nameAr, brand: $brand, size: $size, unit: $unit, categoryId: $categoryId, imageUrl: $imageUrl, createdBy: $createdBy, searchKeywords: $searchKeywords, latestPrices: $latestPrices, lastPriceAt: $lastPriceAt)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String id, String? barcode, String name, String? nameAr, String? brand, String? size, String? unit, String categoryId, String? imageUrl, String createdBy, List<String> searchKeywords, Map<String, LatestPrice> latestPrices,@NullableTimestampConverter() DateTime? lastPriceAt
});




}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? barcode = freezed,Object? name = null,Object? nameAr = freezed,Object? brand = freezed,Object? size = freezed,Object? unit = freezed,Object? categoryId = null,Object? imageUrl = freezed,Object? createdBy = null,Object? searchKeywords = null,Object? latestPrices = null,Object? lastPriceAt = freezed,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,searchKeywords: null == searchKeywords ? _self._searchKeywords : searchKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,latestPrices: null == latestPrices ? _self._latestPrices : latestPrices // ignore: cast_nullable_to_non_nullable
as Map<String, LatestPrice>,lastPriceAt: freezed == lastPriceAt ? _self.lastPriceAt : lastPriceAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
