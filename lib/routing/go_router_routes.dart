enum GoRouterRoutes {
  loginScreen(routeName: '/login'),
  recommendationPage(routeName: '/home'),
  searchPage(routeName: '/search'),
  libraryPage(routeName: '/library');

  final String routeName;

  const GoRouterRoutes({required this.routeName});
}
