// lib/core/error/failure.dart

/// کلاس پایه برای نمایش خطاها در لایه‌های مختلف اپ
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// خطای مربوط به مشکل در سرور یا پاسخ غیرمنتظره
class ServerFailure extends Failure {
  const ServerFailure([super.message = "خطایی در سرور رخ داده است"]);
}

/// خطای مرتبط با اتصال اینترنت یا شبکه
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "اتصال اینترنت برقرار نیست"]);
}

/// خطای ورودی نامعتبر (مثلاً پارامتر نامعتبر)
class InvalidInputFailure extends Failure {
  const InvalidInputFailure([super.message = "ورودی معتبر نیست"]);
}

/// خطای عدم دریافت داده (مثلاً لیست خالی)
class EmptyDataFailure extends Failure {
  const EmptyDataFailure([super.message = "داده‌ای یافت نشد"]);
}
