
import '../models/featured.dart';
import '../models/featutedProduct.dart';
import '../models/post_model.dart';
import '../models/slider.dart';
import '../models/todaysdeal.dart';
import 'dio_helper.dart';

class Repository {
  static final DioHelper _dioHelper = DioHelper();

  Future<postModel> responseInMap(Object requestBody) async {
    Map<String, dynamic> response = await _dioHelper.post(
      url: 'https://reqres.in/api/users?page=2',requestBody: requestBody
    );
    return postModel.fromJson(response);
  }

  Future<Sliders> getSliders() async {
    Map<String ,dynamic> response = await _dioHelper.get(
      url: 'https://www.beta.takesell.com.bd/api/v2/sliders',
    );
    return Sliders.fromJson(response);
  }
  Future<Categories> getFeaturedCategories() async {
    Map<String ,dynamic> response = await _dioHelper.get(
      url: 'https://www.beta.takesell.com.bd/api/v2/categories/featured',
    );
    return Categories.fromJson(response);
  }
  Future<Products> getTodaysDealProducts() async {
    try {
      Map<String, dynamic> response = await _dioHelper.get(
        url: 'https://www.beta.takesell.com.bd/api/v2/products/todays-deal',
      );
      return Products.fromJson(response);
    } catch (error) {
      throw Exception('Error fetching today\'s deal products: $error');
    }
  }
  Future<FeaturedProducts> getFeaturedProducts() async {
    try {
      Map<String, dynamic> response = await _dioHelper.get(
        url: 'https://www.beta.takesell.com.bd/api/v2/products/featured',
      );
      return FeaturedProducts.fromJson(response);
    } catch (error) {
      throw Exception('Error fetching featured products: $error');
    }
  }

  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    try {
      Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
      };

      Map<String, dynamic> response = await _dioHelper.post(
        url: 'https://www.beta.takesell.com.bd/api/v2/auth/login',
        requestBody: requestBody,
      );

      return response;
    } catch (error) {
      throw Exception('Login failed: $error');
    }
  }
  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String name, // Assuming you need a name for sign up
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
        'name': name, // Include the name field
      };

      Map<String, dynamic> response = await _dioHelper.post(
        url: 'https://www.beta.takesell.com.bd/api/v2/auth/signup',
        requestBody: requestBody,
      );

      return response;
    } catch (error) {
      throw Exception('Sign up failed: $error');
    }
  }
}
