# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase related
-keep class com.google.firebase.** { *; }

# Preserve certain annotations
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# For SSL Pinning and other security plugins
-keep class com.koenidv.http_certificate_pinning.** { *; }
-keep class com.example.medical_app.** { *; }
