class User {

  String? user;
  int? user_id;
  int? client_id;
  int? id;
  String? client;
  String? title;
  String? description;
  String? date;
  String? name;
  String? avatar;
  String? email;
  String? password;
  String? fcm;
  String? corporateName;
  String? razName;
  String? quantityTrucks;
  List<User>? historic;
  String? cpf;
  String? cnpj;
  String? birth;
  String? document;
  String? cellphone;
  String? telephone;
  String? tokenPassword;
  String? registrationId;
  String? nomeStatus;
  String? avatarUsuario;
  String? total;
  String? obs;
  String? idStatus;
  String? status;
  String? assuntName;
  String? idProduto;
  String? idCarrinho;
  List<User>? itens;
  String? idItens;
  String? urlCliente;
  String? msg;
  int? rows;


  User({
    this.user,
    this.user_id,
    this.client_id,
    this.id,
    this.client,
    this.title,
    this.description,
    this.date,
    this.name,
    this.avatar,
    this.email,
    this.password,
    this.fcm,
    this.corporateName,
    this.razName,
    this.quantityTrucks,
    this.historic,
    this.cpf,
    this.cnpj,
    this.birth,
    this.document,
    this.cellphone,
    this.telephone,
    this.tokenPassword,
    this.registrationId,
    this.nomeStatus,
    this.avatarUsuario,
    this.total,
    this.obs,
    this.idStatus,
    this.status,
    this.assuntName,
    this.idProduto,
    this.idCarrinho,
    this.itens,
    this.idItens,
    this.msg,
    this.rows,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user: json['user'],
      user_id: json['user_id'],
      id: json['id'],
      client_id: json['client_id'],
      client: json['client'],
      name: json['name'],
      avatar: json['avatar'],
      email: json['email'],
      password: json['password'],
      fcm: json['fcm'],
      corporateName: json['corporateName'],
      razName: json['razName'],
      quantityTrucks: json['quantityTrucks'],
      historic: (json['historic'] as List<dynamic>?)
          ?.map((item) => User.fromJson(item))
          .toList(),
      cpf: json['cpf'],
      cnpj: json['cnpj'],
      birth: json['birth'],
      document: json['document'],
      cellphone: json['cellphone'],
      telephone: json['telephone'],
      tokenPassword: json['tokenPassword'],
      registrationId: json['registrationId'],
      nomeStatus: json['nomeStatus'],
      avatarUsuario: json['avatarUsuario'],
      total: json['total'],
      obs: json['obs'],
      idStatus: json['idStatus'],
      status: json['status'],
      assuntName: json['assuntName'],
      idProduto: json['idProduto'],
      idCarrinho: json['idCarrinho'],
      itens: (json['itens'] as List<dynamic>?)
          ?.map((item) => User.fromJson(item))
          .toList(),
      idItens: json['idItens'],
      msg: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'id': id,
      'avatar': avatar,
      'email': email,
      'password': password,
      'fcm': fcm,
      'corporateName': corporateName,
      'razName': razName,
      'quantityTrucks': quantityTrucks,
      'historic': historic?.map((item) => item.toJson()).toList(),
      'cpf': cpf,
      'cnpj': cnpj,
      'birth': birth,
      'document': document,
      'cellphone': cellphone,
      'telephone': telephone,
      'tokenPassword': tokenPassword,
      'registrationId': registrationId,
      'nomeStatus': nomeStatus,
      'avatarUsuario': avatarUsuario,
      'total': total,
      'obs': obs,
      'idStatus': idStatus,
      'status': status,
      'assuntName': assuntName,
      'idProduto': idProduto,
      'idCarrinho': idCarrinho,
      'itens': itens?.map((item) => item.toJson()).toList(),
      'idItens': idItens,
      'urlCliente': urlCliente,
      'message': msg,
    };
  }

}

