install the Android SDK and install the Android 21 SDK tools

export $ANDROID_HOME to the SDK Manager directory

install the Android NDK

export $NDK_ROOT to the top directory of the NDK (the one with ndk-build in it)

cd into the directory you wanna build in and run hold-my-beer.sh (it will ask for su perms... just type the password... do NOT run as su!!!)

copy output folder onto your device and install wine.apk

launch wine and open explorer

navigate to your sdcard in explorer (Z:/sdcard)

copy the qemu folder from the output folder to C:/qemu

in wine cmd, run "C:\qemu\qemu.exe foo.exe" where foo is replaced with the exe you wanna run