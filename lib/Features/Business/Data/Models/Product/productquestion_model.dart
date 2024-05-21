import '../../../Domain/Entities/Product/productquestion_entity.dart';

class ProductQuestionModel extends ProductQuestionEntity {
  ProductQuestionModel({
    super.userId,
    super.productId,
    super.questionParentId,
    super.question,
  });

  factory ProductQuestionModel.fromJson(Map<String, dynamic> json) {
    return ProductQuestionModel(
      userId: json['user_id'],
      productId: json['product_id'],
      questionParentId: json['question_parent_id'],
      question: json['question'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'question_parent_id': questionParentId,
      'question': question,
    };
  }
}
