import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.idprofissional,
        required this.tipoCadastro,
        required this.nome,
        required this.telefone,
        required this.profissao,
        required this.idprofissao,
    });

    int idprofissional;
    String tipoCadastro;
    String nome;
    int telefone;
    String profissao;
    int idprofissao;
  

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idprofissional: json["idprofissional"],
        tipoCadastro: json["tipo_cadastro"],
        nome: json["nome"],
        telefone: json["telefone"],
        profissao: json["Profissao"],
        idprofissao: json["idprofissao"],
    );

    Map<String, dynamic> toJson() => {
        "idprofissional": idprofissional,
        "tipo_cadastro": tipoCadastro,
        "nome": nome,
        "telefone": telefone,
        "Profissao": profissao,
        "idprofissao": idprofissao,
    };
}