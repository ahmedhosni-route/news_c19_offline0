class AppCategory{
  String id;
  String title;
  String image;

  AppCategory({required this.id , required this.title , required this.image});


  static List<AppCategory> categories = [
    AppCategory(id: "general", title: "General", image: "assets/categoreis/general.png"),
    AppCategory(id: "business", title: "Busniess", image: "assets/categoreis/busniess.png"),
    AppCategory(id: "sports", title: "Sport", image: "assets/categoreis/sport.png"),
    AppCategory(id: "technology", title: "Technology", image: "assets/categoreis/technology.png"),
    AppCategory(id: "entertainment", title: "Entertainment", image: "assets/categoreis/entertainment.png"),
    AppCategory(id: "health", title: "Health", image: "assets/categoreis/helth.png"),
    AppCategory(id: "science", title: "Science", image: "assets/categoreis/science.png"),
  ];
  
}