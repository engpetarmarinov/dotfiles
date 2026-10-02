export PATH="$PATH:/opt/android-studio/bin"

if [[ "$(uname -s)" = "Linux" ]]; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    export JAVA_HOME="/opt/android-studio/jbr"
    export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
fi
