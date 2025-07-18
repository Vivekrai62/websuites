import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

// Define repositories for all projects
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Change default build directory for root and subprojects
val newBuildDir = layout.buildDirectory.dir("../../build").get()
layout.buildDirectory.set(newBuildDir)

subprojects {
    layout.buildDirectory.set(newBuildDir.dir(name))
}

// Force subprojects to evaluate after `:app`
subprojects {
    evaluationDependsOn(":app")
}

// Define a clean task to delete the build directory
tasks.register<Delete>("clean") {
    delete(layout.buildDirectory)
}

