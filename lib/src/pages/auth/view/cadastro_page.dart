import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:quitanda_udemy/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda_udemy/src/pages/shared/box_text_field.dart';
import 'package:quitanda_udemy/src/config/custom_colors.dart';
import 'package:quitanda_udemy/src/services/validators.dart';

class CadastroPage extends StatelessWidget {
  CadastroPage({Key? key}) : super(key: key);

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BoxTextField(
                            icon: Icons.email,
                            label: 'Email',
                            onSaved: (value) {
                              authController.user.email = value;
                            },
                            textInputType: TextInputType.emailAddress,
                            validator: emailValidator,
                          ),
                          BoxTextField(
                            icon: Icons.lock,
                            label: 'Senha',
                            onSaved: (value) {
                              authController.user.password = value;
                            },
                            validator: passwordValidator,
                            isSenha: true,
                          ),
                          BoxTextField(
                            icon: Icons.person,
                            label: 'Nome',
                            onSaved: (value) {
                              authController.user.name = value;
                            },
                            validator: nameValidator,
                          ),
                          BoxTextField(
                            icon: Icons.phone,
                            label: 'Celular',
                            validator: phoneValidator,
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                            textInputType: TextInputType.phone,
                            inputFormatters: [phoneFormatter],
                          ),
                          BoxTextField(
                            icon: Icons.file_copy,
                            label: 'CPF',
                            validator: cpfvalidator,
                            onSaved: (value) {
                              authController.user.cpf = value;
                            },
                            textInputType: TextInputType.number,
                            inputFormatters: [cpfFormatter],
                          ),
                          SizedBox(
                            height: 50,
                            child: Obx(() {
                              return ElevatedButton(
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          authController.cadastro();
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Cadastrar usuário',
                                        style: TextStyle(fontSize: 18),
                                      ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
