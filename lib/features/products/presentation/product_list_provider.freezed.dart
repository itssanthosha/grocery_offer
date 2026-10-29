// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_list_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductQuery {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductQuery);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProductQuery()';
}


}

/// @nodoc
class $ProductQueryCopyWith<$Res>  {
$ProductQueryCopyWith(ProductQuery _, $Res Function(ProductQuery) __);
}


/// Adds pattern-matching-related methods to [ProductQuery].
extension ProductQueryPatterns on ProductQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecentQuery value)?  recent,TResult Function( SearchQuery value)?  search,TResult Function( CategoryQuery value)?  category,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecentQuery() when recent != null:
return recent(_that);case SearchQuery() when search != null:
return search(_that);case CategoryQuery() when category != null:
return category(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecentQuery value)  recent,required TResult Function( SearchQuery value)  search,required TResult Function( CategoryQuery value)  category,}){
final _that = this;
switch (_that) {
case RecentQuery():
return recent(_that);case SearchQuery():
return search(_that);case CategoryQuery():
return category(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecentQuery value)?  recent,TResult? Function( SearchQuery value)?  search,TResult? Function( CategoryQuery value)?  category,}){
final _that = this;
switch (_that) {
case RecentQuery() when recent != null:
return recent(_that);case SearchQuery() when search != null:
return search(_that);case CategoryQuery() when category != null:
return category(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  recent,TResult Function( String text)?  search,TResult Function( String categoryId)?  category,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecentQuery() when recent != null:
return recent();case SearchQuery() when search != null:
return search(_that.text);case CategoryQuery() when category != null:
return category(_that.categoryId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  recent,required TResult Function( String text)  search,required TResult Function( String categoryId)  category,}) {final _that = this;
switch (_that) {
case RecentQuery():
return recent();case SearchQuery():
return search(_that.text);case CategoryQuery():
return category(_that.categoryId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  recent,TResult? Function( String text)?  search,TResult? Function( String categoryId)?  category,}) {final _that = this;
switch (_that) {
case RecentQuery() when recent != null:
return recent();case SearchQuery() when search != null:
return search(_that.text);case CategoryQuery() when category != null:
return category(_that.categoryId);case _:
  return null;

}
}

}

/// @nodoc


class RecentQuery implements ProductQuery {
  const RecentQuery();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentQuery);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProductQuery.recent()';
}


}




/// @nodoc


class SearchQuery implements ProductQuery {
  const SearchQuery(this.text);
  

 final  String text;

/// Create a copy of ProductQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchQueryCopyWith<SearchQuery> get copyWith => _$SearchQueryCopyWithImpl<SearchQuery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchQuery&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,text);
}

@override
String toString() {
    return 'ProductQuery.search(text: $text)';
}


}

/// @nodoc
abstract mixin class $SearchQueryCopyWith<$Res> implements $ProductQueryCopyWith<$Res> {
  factory $SearchQueryCopyWith(SearchQuery value, $Res Function(SearchQuery) _then) = _$SearchQueryCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$SearchQueryCopyWithImpl<$Res>
    implements $SearchQueryCopyWith<$Res> {
  _$SearchQueryCopyWithImpl(this._self, this._then);

  final SearchQuery _self;
  final $Res Function(SearchQuery) _then;

/// Create a copy of ProductQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(SearchQuery(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CategoryQuery implements ProductQuery {
  const CategoryQuery(this.categoryId);
  

 final  String categoryId;

/// Create a copy of ProductQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryQueryCopyWith<CategoryQuery> get copyWith => _$CategoryQueryCopyWithImpl<CategoryQuery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryQuery&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,categoryId);
}

@override
String toString() {
    return 'ProductQuery.category(categoryId: $categoryId)';
}


}

/// @nodoc
abstract mixin class $CategoryQueryCopyWith<$Res> implements $ProductQueryCopyWith<$Res> {
  factory $CategoryQueryCopyWith(CategoryQuery value, $Res Function(CategoryQuery) _then) = _$CategoryQueryCopyWithImpl;
@useResult
$Res call({
 String categoryId
});




}
/// @nodoc
class _$CategoryQueryCopyWithImpl<$Res>
    implements $CategoryQueryCopyWith<$Res> {
  _$CategoryQueryCopyWithImpl(this._self, this._then);

  final CategoryQuery _self;
  final $Res Function(CategoryQuery) _then;

/// Create a copy of ProductQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categoryId = null,}) {
  return _then(CategoryQuery(
null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PagedProducts {

 List<Product> get items; bool get hasMore; bool get loadingMore; bool get loadMoreFailed;
/// Create a copy of PagedProducts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagedProductsCopyWith<PagedProducts> get copyWith => _$PagedProductsCopyWithImpl<PagedProducts>(this as PagedProducts, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PagedProducts;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagedProducts&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.loadingMore, _this.loadingMore) || other.loadingMore == _this.loadingMore)&&(identical(other.loadMoreFailed, _this.loadMoreFailed) || other.loadMoreFailed == _this.loadMoreFailed));
}


@override
int get hashCode {
  final _this = this as PagedProducts;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.hasMore,_this.loadingMore,_this.loadMoreFailed);
}

@override
String toString() {
  final _this = this as PagedProducts;
  return 'PagedProducts(items: ${_this.items}, hasMore: ${_this.hasMore}, loadingMore: ${_this.loadingMore}, loadMoreFailed: ${_this.loadMoreFailed})';
}


}

/// @nodoc
abstract mixin class $PagedProductsCopyWith<$Res>  {
  factory $PagedProductsCopyWith(PagedProducts value, $Res Function(PagedProducts) _then) = _$PagedProductsCopyWithImpl;
@useResult
$Res call({
 List<Product> items, bool hasMore, bool loadingMore, bool loadMoreFailed
});




}
/// @nodoc
class _$PagedProductsCopyWithImpl<$Res>
    implements $PagedProductsCopyWith<$Res> {
  _$PagedProductsCopyWithImpl(this._self, this._then);

  final PagedProducts _self;
  final $Res Function(PagedProducts) _then;

/// Create a copy of PagedProducts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? hasMore = null,Object? loadingMore = null,Object? loadMoreFailed = null,}) {
  return _then(PagedProducts(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Product>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,loadMoreFailed: null == loadMoreFailed ? _self.loadMoreFailed : loadMoreFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PagedProducts].
extension PagedProductsPatterns on PagedProducts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PagedProducts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PagedProducts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PagedProducts value)  $default,){
final _that = this;
switch (_that) {
case _PagedProducts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PagedProducts value)?  $default,){
final _that = this;
switch (_that) {
case _PagedProducts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Product> items,  bool hasMore,  bool loadingMore,  bool loadMoreFailed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PagedProducts() when $default != null:
return $default(_that.items,_that.hasMore,_that.loadingMore,_that.loadMoreFailed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Product> items,  bool hasMore,  bool loadingMore,  bool loadMoreFailed)  $default,) {final _that = this;
switch (_that) {
case _PagedProducts():
return $default(_that.items,_that.hasMore,_that.loadingMore,_that.loadMoreFailed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Product> items,  bool hasMore,  bool loadingMore,  bool loadMoreFailed)?  $default,) {final _that = this;
switch (_that) {
case _PagedProducts() when $default != null:
return $default(_that.items,_that.hasMore,_that.loadingMore,_that.loadMoreFailed);case _:
  return null;

}
}

}

/// @nodoc


class _PagedProducts implements PagedProducts {
  const _PagedProducts({required  List<Product> items, required this.hasMore, this.loadingMore = false, this.loadMoreFailed = false}): _items = items;
  

 final  List<Product> _items;
@override List<Product> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  bool hasMore;
@override@JsonKey() final  bool loadingMore;
@override@JsonKey() final  bool loadMoreFailed;

/// Create a copy of PagedProducts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagedProductsCopyWith<_PagedProducts> get copyWith => __$PagedProductsCopyWithImpl<_PagedProducts>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagedProducts&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore)&&(identical(other.loadMoreFailed, loadMoreFailed) || other.loadMoreFailed == loadMoreFailed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),hasMore,loadingMore,loadMoreFailed);
}

@override
String toString() {
    return 'PagedProducts(items: $items, hasMore: $hasMore, loadingMore: $loadingMore, loadMoreFailed: $loadMoreFailed)';
}


}

/// @nodoc
abstract mixin class _$PagedProductsCopyWith<$Res> implements $PagedProductsCopyWith<$Res> {
  factory _$PagedProductsCopyWith(_PagedProducts value, $Res Function(_PagedProducts) _then) = __$PagedProductsCopyWithImpl;
@override @useResult
$Res call({
 List<Product> items, bool hasMore, bool loadingMore, bool loadMoreFailed
});




}
/// @nodoc
class __$PagedProductsCopyWithImpl<$Res>
    implements _$PagedProductsCopyWith<$Res> {
  __$PagedProductsCopyWithImpl(this._self, this._then);

  final _PagedProducts _self;
  final $Res Function(_PagedProducts) _then;

/// Create a copy of PagedProducts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? hasMore = null,Object? loadingMore = null,Object? loadMoreFailed = null,}) {
  return _then(_PagedProducts(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Product>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,loadMoreFailed: null == loadMoreFailed ? _self.loadMoreFailed : loadMoreFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
