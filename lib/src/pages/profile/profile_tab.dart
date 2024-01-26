import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_udemy/src/pages/shared/box_text_field.dart';
import 'package:quitanda_udemy/src/config/app_data.dart' as appdata;

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          BoxTextField(
            readOnly: true,
            initialValue: appdata.user.email,
            icon: Icons.email,
            label: 'Email',
          ),
          BoxTextField(
            readOnly: true,
            initialValue: appdata.user.name,
            icon: Icons.person,
            label: 'Nome',
          ),
          BoxTextField(
            readOnly: true,
            initialValue: appdata.user.phone,
            icon: Icons.phone,
            label: 'Celular',
          ),
          BoxTextField(
            readOnly: true,
            initialValue: appdata.user.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
            isSenha: true,
          ),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.green,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text('Atualizar senha'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Atualização de senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const BoxTextField(
                      isSenha: true,
                      icon: Icons.lock,
                      label: 'Senha atual',
                    ),
                    const BoxTextField(
                      isSenha: true,
                      icon: Icons.lock_outline,
                      label: 'Nova senha',
                    ),
                    const BoxTextField(
                      isSenha: true,
                      icon: Icons.lock_outline,
                      label: 'Confirmar nova senha',
                    ),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Atualizar'),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
