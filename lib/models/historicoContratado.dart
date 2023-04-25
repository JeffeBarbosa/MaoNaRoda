import 'dart:convert';

HistoricoContratado historicoContratadoFromJson(String str) => HistoricoContratado.fromJson(json.decode(str));

String historicoContratadoToJson(HistoricoContratado data) => json.encode(data.toJson());

class HistoricoContratado {
    HistoricoContratado({
        required this.nomecontratado,
        required this.data,
        required this.id,
    });

    String nomecontratado;
    DateTime data;
    int id;

    factory HistoricoContratado.fromJson(Map<String, dynamic> json) => HistoricoContratado(
        nomecontratado: json["nomecontratado"],
        data: DateTime.parse(json["data"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nomecontratado": nomecontratado,
        "data": "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}",
        "id": id,
    };
}
