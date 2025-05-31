// lib/core/error/failure.dart

/// کلاس پایه برای نمایش خطاها در لایه‌های مختلف اپ
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// خطای مربوط به مشکل در سرور یا پاسخ غیرمنتظره
class ServerFailure extends Failure {
  const ServerFailure([String message = "خطایی در سرور رخ داده است"])
      : super(message);
}

/// خطای مرتبط با اتصال اینترنت یا شبکه
class NetworkFailure extends Failure {
  const NetworkFailure([String message = "اتصال اینترنت برقرار نیست"])
      : super(message);
}

/// خطای ورودی نامعتبر (مثلاً پارامتر نامعتبر)
class InvalidInputFailure extends Failure {
  const InvalidInputFailure([String message = "ورودی معتبر نیست"])
      : super(message);
}

/// خطای عدم دریافت داده (مثلاً لیست خالی)
class EmptyDataFailure extends Failure {
  const EmptyDataFailure([String message = "داده‌ای یافت نشد"])
      : super(message);
}
