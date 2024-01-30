import 'package:get/get.dart';
import 'package:quitanda_udemy/src/config/pages_routes.dart';
import 'package:quitanda_udemy/src/constants/storage_keys.dart';
import 'package:quitanda_udemy/src/models/user_model.dart';
import 'package:quitanda_udemy/src/pages/auth/repository/auth_repository.dart';
import 'package:quitanda_udemy/src/pages/auth/result/auth_result.dart';
import 'package:quitanda_udemy/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(Routes.loginRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        logout();
      },
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;

    final result = await authRepository.changePassword(
      email: user.email!,
      currentPassword: currentPassword,
      newPassword: newPassword,
      token: user.token!,
    );

    isLoading.value = false;

    if (result) {
      utilsServices.showToast(
        message: 'A senha foi atualizada com sucesso!',
      );

      logout();
    } else {
      utilsServices.showToast(
        message: 'A senha atual está incorreta',
        isError: true,
      );
    }
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

  Future<void> logout() async {
    // Zerar o user
    user = UserModel();

    // Remover o token localmente
    await utilsServices.removeLocalData(key: StorageKeys.token);

    // Ir para o login
    Get.offAllNamed(Routes.loginRoute);
  }

  void saveTokenAndProceedToBase() {
    // Salvar o token
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    // Ir para a base
    Get.offAllNamed(Routes.baseRoute);
  }

  Future<void> cadastro() async {
    isLoading.value = true;

    AuthResult result = await authRepository.cadastro(user);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.login(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
