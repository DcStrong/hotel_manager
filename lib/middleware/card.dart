class CardMiddleware {
  String getResponseDataType(dynamic data) {
    if (data is! Map) {
      return '';
    }

    final dataMap = data;

    if (!dataMap.containsKey('type')) {
      return '';
    }

    return dataMap['type'];
  }

  String getResponseData(dynamic data) {
    if (data is! Map) {
      return '';
    }

    final dataMap = data;

    if (!dataMap.containsKey('data')) {
      return '';
    }

    return dataMap['data'];
  }
}