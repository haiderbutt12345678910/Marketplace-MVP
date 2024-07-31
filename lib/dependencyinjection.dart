import 'package:flutter_application_ebay_ecom/Features/Authentication/Data/DataSources/remotedatasource.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Data/authrepositoryimpl.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Domain/Usecases/loginusecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Domain/repository.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/StateMangemnet/Bloc/login_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/RemoteDataSource/apidatasource.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/repository_impl.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/cart_usecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/cities_usecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/getcategories_usecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/getitems_usecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/getsingleitem_usecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/getsubcategories_usecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/getuser_usecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/recentvieweditem_usecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/saveditems_usecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/updateuser_usecase.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/repository.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/cart_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getcategories_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getcities_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getitems_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getrecentlyviewed_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getsaveditems_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getsingleitem_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getsubcategories_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getuser_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/updateuser_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
//bloc
//AuthBlocs
  sl.registerFactory<LogInCubit>(() => LogInCubit(logInUseCase: sl.call()));

  //BusinessFeaturesBlocs
  sl.registerFactory<GetCategoriesBloc>(
      () => GetCategoriesBloc(getCategoriesUsecase: sl.call()));
  sl.registerFactory<GetSubCategoriesBloc>(
      () => GetSubCategoriesBloc(getSubCategoriesUsecase: sl.call()));

  sl.registerFactory<GetitemsBloc>(
      () => GetitemsBloc(getItemsUseCase: sl.call()));

  sl.registerFactory<GetUserBloc>(() => GetUserBloc(getUserUsecase: sl.call()));

  sl.registerFactory<UpdateuserBloc>(
      () => UpdateuserBloc(updateUserUsecase: sl.call()));

  sl.registerFactory<GetcitiesBloc>(
      () => GetcitiesBloc(getCitiesUseCase: sl.call()));

  sl.registerFactory<GetRecentlyViewditemsBloc>(() =>
      GetRecentlyViewditemsBloc(getRecentlyViewedItemsUseCase: sl.call()));

  sl.registerFactory<GetsaveditemsBloc>(
      () => GetsaveditemsBloc(getSavedItemsUseCase: sl.call()));
  sl.registerFactory<GetCartBloc>(() => GetCartBloc(getCartUseCase: sl.call()));
  sl.registerFactory<GetsingleitemBloc>(
      () => GetsingleitemBloc(getSingleItemUseCase: sl.call()));

  //Usecases

  //AuthUseCases
  sl.registerLazySingleton<AuthLoginUseCase>(
      () => AuthLoginUseCase(repository: sl.call()));

  //BusinessFeaturesUseCases
  sl.registerLazySingleton<GetCategoriesUsecase>(
      () => GetCategoriesUsecase(repository: sl.call()));

  sl.registerLazySingleton<GetSubCategoriesUsecase>(
      () => GetSubCategoriesUsecase(repository: sl.call()));

  sl.registerFactory<GetitemsUsecase>(
      () => GetitemsUsecase(repository: sl.call()));

  sl.registerFactory<GetUserUsecase>(
      () => GetUserUsecase(repository: sl.call()));
  sl.registerFactory<UpdateUserUsecase>(
      () => UpdateUserUsecase(repository: sl.call()));

  sl.registerFactory<GetCitiesUseCase>(
      () => GetCitiesUseCase(repository: sl.call()));

  sl.registerFactory<GetSavedItemsUseCase>(
      () => GetSavedItemsUseCase(repository: sl.call()));
  sl.registerFactory<GetRecentlyViewedItemsUseCase>(
      () => GetRecentlyViewedItemsUseCase(repository: sl.call()));

  sl.registerFactory<GetCartUseCase>(
      () => GetCartUseCase(repository: sl.call()));

  sl.registerFactory<GetSingleItemUseCase>(
      () => GetSingleItemUseCase(repository: sl.call()));

//repository
  //authrepo
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: sl.call()));

//business
  sl.registerLazySingleton<Repository>(
      () => RepositoryImpl(apidatasource: sl.call()));

//datasource

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(httpClient: sl.call(), prefs: sl.call()),
  );

  //Business

  sl.registerLazySingleton<Apidatasource>(
    () => ApiDataSourceImpl(httpClient: sl.call(), prefs: sl.call()),
  );

  //externel
  final http.Client httpClient = http.Client();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => httpClient);
  sl.registerLazySingleton(() => sharedPreferences);
}
