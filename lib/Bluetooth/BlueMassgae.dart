class BleMessage {
  var message = "Do not have Message,";
  double height = 0;
  double distance = 0;
  double axisX = 0;
  double axisY = 0;
  double axisZ = 0;

  void printMessage() {
    print("M => $message");
  }

  // set
  void setMessage(String text) {
    this.message = text;
    var delim = RegExp(r",");

    List massages = text.split(delim);

    double height = double.parse(massages[0]);
    double distance = double.parse(massages[1]);
    double axisX = double.parse(massages[2]);
    double axisY = double.parse(massages[3]);
    double axisZ = double.parse(massages[4]);
    
    this.height = height;
    this.distance = distance;
    this.axisX = axisX;
    this.axisY = axisY;
    this.axisZ = axisZ;
  }

  // get
  String getMessage() {
    return this.message;
  }

  double getHeight() {
    return this.height;
  }

  double getDistance() {
    return this.distance;
  }

  double getAxisX() {
    return this.axisX;
  }

  double getAxisY() {
    return this.axisY;
  }
  double getAxisZ() {
    return this.axisZ;
  }
  
}
