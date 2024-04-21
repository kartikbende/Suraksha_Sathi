class TContact {
  int? _id;
  String? _name;
  String? _number;

  TContact(this._number, this._name);
  TContact.withId(this._id, this._name, this._number);

  // getters for the id name and contact
  int get id => _id!;
  String get name => _name!;
  String get number => _number!;

  @override
  String toString() {
    return 'Contact: {id: $_id, name: $_name, number: $_number}';
  }

  // setters
  set number(String newNumber) => this._number = newNumber;
  set name(String newName) => this._name = newName;

  // convert a contact object to map object

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = this._name;
    map['number'] = this._number;
    return map;
  }

  TContact.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._number = map['number'];
  }
}
