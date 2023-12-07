class IntroContent {
  String image;
  String title;
  String description;

  IntroContent({this.image='', this.title='', this.description=''});
}

List<IntroContent> contents = [
  
  IntroContent(
      image: "asset/image/int1.jpeg",
      title: "Track your money",
      description:
          "Discover the power of FinTrack with features designed to simplify your financial life"
   "From tracking daily expenses to setting and achieving your savings goals, we've got you covered "),
  IntroContent(
    image: "asset/image/intro2.jpeg",
    description:"Visualize your financial data like never before"
    " Track income and expenses with interactive charts for "
   " better insights and smarter decsions",
     title: 'Interactive charts',
  ),
  IntroContent(
      image: 'asset/image/manpic.png',
      
      title:
'''  Spend Smarter \n    Save More''')
];
