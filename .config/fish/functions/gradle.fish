function gradle --description "Gradle wrapper to prefer gradlew"
    if test -x gradlew
        ./gradlew $argv
    else
        command gradle $argv
    end
end
