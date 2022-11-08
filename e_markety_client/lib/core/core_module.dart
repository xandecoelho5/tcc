import 'package:dio/dio.dart';
import 'package:e_markety_client/core/services/cache/cache_service.dart';
import 'package:e_markety_client/core/services/cache/shared_preferences_service.dart';
import 'package:e_markety_client/core/services/http/dio_service.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/core/services/snack_bar/asuka_service.dart';
import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/shared/environment/platform.dart';
import 'package:e_markety_client/shared/utils/strings.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => AppPlatform.current, export: true),
    AsyncBind<SharedPreferences>(
      (i) => SharedPreferences.getInstance(),
      export: true,
    ),
    Bind<ICacheService>(
      (i) => SharedPreferencesService(),
      export: true,
    ),
    Bind.singleton<ISnackBarService>(
      (i) => AsukaService(),
      export: true,
    ),
    Bind.singleton<IHttpService>(
      (i) {
        final platform = i.get<AppPlatform>();
        final dio = Dio(
          BaseOptions(baseUrl: platform.baseUrl, connectTimeout: 5000),
        );
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              print('REQUEST[${options.method}] => PATH: ${options.path}');
              final tk =
                  await i.get<ICacheService>().get(Strings.token) as List?;
              if (tk != null) {
                options.headers['Authorization'] = '${tk[0]} ${tk[1]}';
              }
              return handler.next(options);
            },
            onError: (error, handler) async {
              print(error);
              if (error.response?.statusCode == 401) {
                print('Sessão expirada');
                Modular.to.navigate('/');
              }
              return handler.next(error);
            },
          ),
        );
        return DioService(dio);
      },
      export: true,
    ),
    Bind.lazySingleton((i) => Dio(), export: true),
  ];
}
