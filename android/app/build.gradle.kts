
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Android-specific configurations
android {
    namespace = "com.webhopers.websuites"
    compileSdk = 35
    ndkVersion = "27.2.12479018"


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.webhopers.websuites" // This should match your namespace
        minSdk = 23
        targetSdk = 35
        versionCode = flutter.versionCode // Ensure flutter.versionCode is defined
        versionName = flutter.versionName // Ensure flutter.versionName is defined
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Flutter configuration
flutter {
    source = "../.." // Update this path as needed
}
