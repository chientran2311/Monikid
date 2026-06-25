# flutter_gemma / MediaPipe LiteRT rules
-keep class com.google.mediapipe.** { *; }
-keep class com.google.protobuf.** { *; }
-keep class com.google.ai.edge.localagents.** { *; }

# Flutter engine + plugins
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Keep native method names (JNI)
-keepclasseswithmembernames class * {
    native <methods>;
}

# MediaPipe proto + auto-value (referenced reflectively, optional at runtime)
-keep class com.google.mediapipe.proto.** { *; }
-dontwarn com.google.mediapipe.proto.**
-dontwarn com.google.auto.value.**

# Google ML Kit text recognition — keep all script options, drop unused language models
-keep class com.google.mlkit.vision.text.** { *; }
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**
