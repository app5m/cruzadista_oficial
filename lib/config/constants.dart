class WSConstantes {

  static const String URLBASE = "https://cruzadista.com.br/apiv3/user/";
  static const String URL = "https://cruzadista.com.br/";
  static const String URL_VIACEP = "https://viacep.com.br/ws/";
  static const String URL_AVATAR_USER = URL + "usuarios/atualizar_avatar";
  static const String URL_AVATAR = URL + "uploads/avatar/";
  static const String URL_CARRINHO = URL + "uploads/orcamentos/";


  static const String FCM_TYPE_ANDROID = "1";
  static const String FCM_TYPE_IOS = "2";
  static const String TOKEN = "3V5B2vSs";
  /**:::Requests:::**/
  static const String LOGIN = "usuarios/login";
  static const String REGISTRER = "usuarios/cadastro";
  static const String PERFIL_USER = "usuarios/perfil/";
  static const String UPDATE_USER = "usuarios/updateUser";
  static const String UPDATE_PASSWORD = "usuarios/updatepassword";
  static const String RECOVERRY_PASSWORD = "usuarios/recuperarsenha";
  static const String SAVE_FCM = "usuarios/savefcm";
  static const String STATISTICS = "cruzadas/estatisticas";
  static const String NOTIFICATION = "usuarios/Notificacoes";
  static const String LIST_CRUZADISTA = "cruzadas/listCruzadas";
  static const String ZERA_CRUZADA = "cruzadas/zerar";
  static const String CONCLUDE_CRUZADA = "cruzadas/concluir";
  static const String DESATIVE_ACCOUNT = "usuarios/desativarconta";

  /**:::Body:::**/
  static const String EMAIL = "email";
  static const String PASSWORD = "password";
  static const String PHONE = "celular";
  static const String NAME = "nome";
  static const String BIRTH = "data_nascimento";
  static const String ID_USER = "id_user";
  static const String TYPE = "type";
  static const String REGIST_ID = "registration_id";
  static const String ID = "id";
  static const String ID_NIVEL = "id_nivel";
  static const String ID_CRUZADA = "id_cruzada";
  static const String TOKENID = "token";

  /**:::Validações:::**/
  static const String MSG_NOME_INVALIDO = 'Preencha o campo Nome';
  static const String MSG_EMAIL_EMPTY = 'Preencha o campo E-mail';
  static const String MSG_USUARIO_EMPTY = 'Preencha o campo Usuário';
  static const String MSG_EMAIL_INVALIDO = 'Email inválido, tente novamente';
  static const String MSG_ORGAN_INVALIDO = 'Selecione o Orgão';
  static const String MSG_PASSWORD_INVALIDO = 'Senha inválida, tente novamente';
  static const String MSG_PASSWORD_EMPTY = 'Preencha o campo Senha';
  static const String MSG_PHONE_INVALIDO = 'Celular inválido, tente novamente';
  static const String MSG_PHONE_EMPTY = 'Preencha o campo Celular';
  static const String MSG_CO_PASSWORD_INVALIDO = 'As senhas fornecidas não são idênticas, por favor, verifique-as e tente novamente';
  static const String MSG_CO_PASSWORD_EMPTY = 'Preencha o campo Confirmar Senha';

  /**:::INICIA FIREBASE NO IOS:::**/
  static const String API_KEY = 'AIzaSyC29OHcYG-evZDs1_POKS7yjI_eZlWCsDk';
  static const String APP_ID = '1:85702348718:android:b34cc14ebc3330a05d823f';
  static const String MESSGING_SENDER_ID = '85702348718';
  static const String PROJECT_ID = 'cruzadista-eb3ab';

}