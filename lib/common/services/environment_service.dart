class EnvironmentService {
  late EnvConfig config;

  EnvironmentService._();

  static final EnvironmentService instance = EnvironmentService._();

  factory EnvironmentService() {
    return instance;
  }

  void setEnvironment() {
    config = EnvConfig(
      baseUrl: '',
      graphqlUrl: 'https://renewing-hawk-97.hasura.app/v1/graphql',
      websocketUrl: 'wss://renewing-hawk-97.hasura.app/v1/graphql',
    );
  }
}

class EnvConfig {
  final String baseUrl;
  final String graphqlUrl;
  final String websocketUrl;

  EnvConfig({
    required this.baseUrl,
    required this.graphqlUrl,
    required this.websocketUrl,
  });

  EnvConfig copyWith({
    String? baseUrl,
    String? graphqlUrl,
    String? websocketUrl,
  }) {
    return EnvConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      graphqlUrl: graphqlUrl ?? this.graphqlUrl,
      websocketUrl: websocketUrl ?? this.websocketUrl,
    );
  }
}
