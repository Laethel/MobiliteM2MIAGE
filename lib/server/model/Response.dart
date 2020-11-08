enum RESPONSE_TYPE {
  VALIDE,
  ERROR
}

class Response {

  RESPONSE_TYPE type;
  String description;

  Response(this.type, this.description);
}