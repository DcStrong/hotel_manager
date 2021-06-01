
class MenuItem {
  String? name;
  String? icon;
  String? routePath;
  String? path;
  bool? active;

  MenuItem({this.name, this.icon, this.path, this.active = false, this.routePath});
}