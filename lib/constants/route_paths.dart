import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/barber/barber_model.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/admin_screen/admin_screen.dart';
import 'package:flutter_shopping_list/ui/details_screen/details_screen.dart';
import 'package:flutter_shopping_list/ui/home_screen.dart';
import 'package:flutter_shopping_list/ui/login_screen/login_screen.dart';
import 'package:go_router/go_router.dart';

import '../ui/details_screen/variants/mobile/details_screen_mobile.dart';
import '../ui/register_screen/register_screen.dart';

class AppRouter {
  // all the route paths. So that we can access them easily  across the app
  static const root = '/';
  static const login = '/login';
  static const register = '/register';
  static const details = '/shop';
  static const singleArticle = '/article';

  // static const singleArticleWithParams = '/article/:id';
  /// get route name with parameters, here [id] is optional because we need [:id] to define path on [_singleArticleWithParams]
  static singleArticleWithParams([String? id]) => '/article/${id ?? ':id'}';
  static mine([Barbershop? id]) => '/article/${id ?? ':id'}';

  /// private static methods that are accessible only in this class and not from outside
  static Widget _homePageRouteBuilder(BuildContext context, GoRouterState state) =>  HomeScreen();
  static Widget _loginScreenRouteBuilder(BuildContext context, GoRouterState state) =>  LoginScreen();
  static Widget _registerScreenRouteBuilder(BuildContext context, GoRouterState state) =>  registerScreen();
  //static Widget _detailsScreenRouteBuilder(BuildContext context, GoRouterState state) =>  DetailsScreen(state.params[]);
  static Widget errorWidget(BuildContext context, GoRouterState state) => const Text("asd");



  /// use this in [MaterialApp.router]
  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(path: root, builder: _homePageRouteBuilder),
      GoRoute(path: login, builder: _loginScreenRouteBuilder),
      GoRoute(path: register, builder: _registerScreenRouteBuilder),
      GoRoute(
          path: "/details/:barbershopId",
          builder: (BuildContext context, GoRouterState state){
            final String bs = state.params['barbershopId']!;
            return DetailsScreen(barbershopId:bs);
          }
      ),
      GoRoute(
          path: "/admin",
          builder: (BuildContext context, GoRouterState state){
            return adminScreen();
          }
      ),
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}