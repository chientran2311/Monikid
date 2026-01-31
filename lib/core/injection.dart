import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart'; // 1. Phải import cái này
import 'injection.config.dart'; // 2. Phải import file này (tên file hiện tại + .config.dart)



final getIt = GetIt.instance;
@InjectableInit(  // 3. BẮT BUỘC phải có annotation này
  initializerName: 'init', 
  preferRelativeImports: true, 
  asExtension: true, 
)
void configureDependencies() => getIt.init(); // Lúc này init() vẫn có thể đỏ, đừng lo