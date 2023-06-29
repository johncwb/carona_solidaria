class Usuario {
  final String displayName;
  final String email;
  final bool emailVerified;
  final bool isAnonymous;
  final UsuarioMetadata metadata;
  final String phoneNumber;
  final String photoURL;
  final List<UsuarioInfo> providerData;
  final String refreshToken;
  final String tenantId;
  final String uid;

  Usuario({
    required this.displayName,
    required this.email,
    required this.emailVerified,
    required this.isAnonymous,
    required this.metadata,
    required this.phoneNumber,
    required this.photoURL,
    required this.providerData,
    required this.refreshToken,
    required this.tenantId,
    required this.uid,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    List<UsuarioInfo> providerDataList = (json['providerData'] as List<dynamic>)
        .map((data) => UsuarioInfo.fromJson(data))
        .toList();

    return Usuario(
      displayName: json['displayName'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      isAnonymous: json['isAnonymous'],
      metadata: UsuarioMetadata.fromJson(json['metadata']),
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
      providerData: providerDataList,
      refreshToken: json['refreshToken'],
      tenantId: json['tenantId'],
      uid: json['uid'],
    );
  }
}

class UsuarioMetadata {
  final String creationTime;
  final String lastSignInTime;

  UsuarioMetadata({
    required this.creationTime,
    required this.lastSignInTime,
  });

  factory UsuarioMetadata.fromJson(Map<String, dynamic> json) {
    return UsuarioMetadata(
      creationTime: json['creationTime'],
      lastSignInTime: json['lastSignInTime'],
    );
  }
}

class UsuarioInfo {
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoURL;
  final String providerId;
  final String uid;

  UsuarioInfo({
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.providerId,
    required this.uid,
  });

  factory UsuarioInfo.fromJson(Map<String, dynamic> json) {
    return UsuarioInfo(
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
      providerId: json['providerId'],
      uid: json['uid'],
    );
  }
}
