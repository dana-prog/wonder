import java.io.FileInputStream
import java.util.Properties

fun getEnvVar(name: String): String =
    System.getenv(name)?.trim()?.takeIf { it.isNotEmpty() }
        ?: throw GradleException("Missing or empty env var: $name")

fun loadKeyStoreProperties(): Properties {
    val props = Properties()
    if (System.getenv("CI").toBoolean()) {
        println("Running in CI environment, loading keystore properties from environment variables.")
        props["keyAlias"] = getEnvVar("CM_KEY_ALIAS")
        props["keyPassword"] = getEnvVar("CM_KEY_PASSWORD")
        props["storeFile"] = getEnvVar("CM_KEYSTORE_PATH")
        props["storePassword"] = getEnvVar("CM_KEYSTORE_PASSWORD")
    } else {
        // TODO: should we move the upload-keystore.jks, upload_certificate.pem and key.properties to a safer location?
        val keystorePropertiesFile = rootProject.file("key.properties")
        println("Running in LOCAL environment, loading keystore properties from: ${keystorePropertiesFile.absolutePath}.")
        if (!keystorePropertiesFile.exists()) {
            throw GradleException("Missing keystore file: ${keystorePropertiesFile.absolutePath}")
        }
        props.load(FileInputStream(keystorePropertiesFile))
    }

    return props;
}

val keystoreProperties = loadKeyStoreProperties()

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.wonder.manage"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.wonder.manage"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        ndk {
            // TODO: added because of a build error (probably we can leave it as is but need to understand the reason and verify)
            abiFilters += listOf("armeabi-v7a", "arm64-v8a")
        }
    }

    signingConfigs {
        create("release") {
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            isDebuggable = false
        }
    }

    bundle {
        language {
            enableSplit = false
        }
    }
}
