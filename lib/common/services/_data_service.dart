

// abstract class DataService {
//   NetworkInfo get _networkInfo => locator<NetworkInfo>();

//   Future<DataModel<List<T>>> getDataList<T extends IRestApiFreezedBaseModel>({
//     Future<void> Function(List<T>)? saveCache,
//     Future<List<T>> Function()? getCache,
//     IRestApiRequest? request,
//     required T Function() parseModel,
//     String? mockUrl,
//   }) async {
//     if (await _networkInfo.isConnected) {
//       try {
//         final remoteData = await _callList(
//           request!,
//           parseModel,
//           mockUrl,
//         );
//         return Right(remoteData);
//       } on ServerFailure catch (e) {
//         return Left(e);
//       }
//     } else if (getCache != null) {
//       try {
//         final localData = await getCache();
//         return Right(localData);
//       } on CacheFailure {
//         return Left(CacheFailure());
//       }
//     } else {
//       return Left(NetworkFailure());
//     }
//   }

//   Future<DataModel<T>> getData<T extends IRestApiFreezedBaseModel>({
//     Future<void> Function(T)? saveCache,
//     Future<T> Function()? getCache,
//     IRestApiRequest? request,
//     required T Function() parseModel,
//     String? mockUrl,
//   }) async {
//     if (await _networkInfo.isConnected) {
//       try {
//         final remoteData = await _call(
//           request!,
//           parseModel,
//           mockUrl,
//         );
//         return Right(remoteData);
//       } on ServerFailure catch (e) {
//         return Left(e);
//       } catch (others) {
//         return Left(ServerFailure(errorMessage: others.toString()));
//       }
//     } else if (getCache != null) {
//       try {
//         final localData = await getCache();
//         return Right(localData);
//       } on CacheFailure {
//         return Left(CacheFailure());
//       }
//     } else {
//       return Left(NetworkFailure());
//     }
//   }

//   Future<List<T>> _callList<T extends IRestApiFreezedBaseModel>(
//     IRestApiRequest request,
//     T Function() parseModel,
//     String? mockUrl,
//   ) async {
//     if (mockUrl != null && environmentTag == DataType.mock) {
//       return _callMockList<T>(mockUrl, parseModel);
//     } else {
//       return _callHTTPRequestList<T>(request, parseModel);
//     }
//   }

//   Future<T> _call<T extends IRestApiFreezedBaseModel>(
//     IRestApiRequest request,
//     T Function() parseModel,
//     String? mockUrl,
//   ) async {
//     if (mockUrl != null && environmentTag == DataType.mock) {
//       return _callMock<T>(mockUrl, parseModel);
//     } else {
//       return _callHTTPRequest<T>(request, parseModel);
//     }
//   }

//   Future<T> _callHTTPRequest<T extends IRestApiFreezedBaseModel>(
//       IRestApiRequest request, T Function() creator) async {
//     try {
//       return await locator<RestApiHttpService>().requestAndHandle<T>(
//         request,
//         parseModel: (json) => creator().fromJson(json),
//       );
//     } catch (e) {
//       throw ServerFailure(errorMessage: e.toString());
//     }
//   }

//   Future<List<T>> _callHTTPRequestList<T extends IRestApiFreezedBaseModel>(
//       IRestApiRequest request, T Function() creator) async {
//     try {
//       return await locator<RestApiHttpService>().requestAndHandleList<T>(
//         request,
//         parseModel: (json) => creator().fromJson(json),
//       );
//     } catch (e) {
//       throw ServerFailure(errorMessage: e.toString());
//     }
//   }

//   Future<T> _callMock<T extends IRestApiFreezedBaseModel>(
//       String mockUrl, T Function() parseModel) async {
//     final data = await rootBundle.loadString(mockUrl);
//     final json = jsonDecode(data);
//     final campaigns = parseModel().fromJson(json);
//     return campaigns;
//   }

//   Future<List<T>> _callMockList<T extends IRestApiFreezedBaseModel>(
//       String mockUrl, T Function() parseModel) async {
//     final data = await rootBundle.loadString(mockUrl);
//     final json = jsonDecode(data);
//     final campaigns = (json as List)
//         .map<T>((campaign) => parseModel().fromJson(campaign))
//         .toList();
//     return campaigns;
//   }
// }

// typedef DataModel<T> = Either<Failure, T>;
// typedef ModelReturnType<T> = Either<T, List<T>>;
// typedef ReturnType<T> = Either<Failure, ModelReturnType<T>>;

// extension EitherX<L, R> on Either<L, R> {
//   R asRight() => (this as Right).value;
//   L asLeft() => (this as Left).value;
// }
