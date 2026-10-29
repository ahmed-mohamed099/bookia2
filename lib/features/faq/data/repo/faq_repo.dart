import 'package:bookia/core/network/dio_helper.dart';
import 'package:bookia/features/faq/data/models/faq_model.dart';

class FaqRepo {
  Future<List<FaqModel>> getFaqs() async {
    final res = await DioHelper.dio.get('/faqs');
    final data = res.data['data'];
    final List list = data is Map ? data['faqs'] : data;
    return list.map((e) => FaqModel.fromJson(e)).toList();
  }
}
