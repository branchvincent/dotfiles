function _tide_item_java --description 'Show Java version'
    if set -q tide_java_always_display || test -f pom.xml -o -f build.gradle -o -f build.gradle.kts
        _tide_language_version -i -c5382A1 java -Xinternalversion
    end
end
