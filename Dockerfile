FROM ubuntu

# Android NDK
# TODO: Use specified NDK version. Use ndk r14b as default.
ENV ANDROID_NDK_VERSION r16b
ENV ANDROID_NDK="/opt/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64"
ENV PMD_HOME=/opt/pmd/pmd-bin-6.8.0

# Install git lfs support.
RUN apt-get -qq update && \
# apt-get
    apt-get install -qqy curl cppcheck ssh make cmake valgrind unzip gcc g++ && \
# git-lfs valgrid
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -qqy git-lfs && \
    git lfs install && \
    apt-get -qqy autoremove && \
    apt-get -qqy autoclean && \
# download ndk
    mkdir /opt/android-ndk-tmp && \
    cd /opt/android-ndk-tmp && \
    wget -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
# uncompress ndk
    unzip -q android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
# move to its final location
    mv ./android-ndk-${ANDROID_NDK_VERSION} ${ANDROID_NDK} && \
# remove temp dir
    cd ${ANDROID_NDK} && \
    rm -rf /opt/android-ndk-tmp && \
# Configure PMD
    mkdir /opt/pmd && \
    cd /opt/pmd && \
    wget -q https://github.com/pmd/pmd/releases/download/pmd_releases%2F6.8.0/pmd-bin-6.8.0.zip && \
# uncompress
    unzip -q pmd-bin-6.8.0.zip && \
    rm pmd-bin-6.8.0.zip

# Update ENV PATH
ENV PATH="${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_NDK}:${PATH}"
