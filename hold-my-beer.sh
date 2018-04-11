export DIR=`pwd`
sudo apt install gradle
sudo apt build-dep wine
sudo apt build-dep qemu
sudo apt install x86_64-w64-mingw32-gcc
sudo apt install i686-w64-mingw32-gcc
mkdir wine-android && cd wine-android
wget https://dl.winehq.org/wine/source/3.x/wine-3.5.tar.xz
tar xf wine-3.0.tar.xz
cp -r wine-3.0 wine-3.0-native
cd wine-3.0-native
./configure --enable-win64
make
cd ..
export TOOLCHAIN_VERSION="aarch64-linux-android-4.9"
export TOOLCHAIN_TRIPLE="aarch64-linux-android"
$NDK_ROOT/build/tools/make-standalone-toolchain.sh --platform=android-21 --install-dir=android-toolchain --toolchain=$TOOLCHAIN_VERSION
export PATH=`pwd`/android-toolchain/bin:$PATH
wget https://download.savannah.gnu.org/releases/freetype/freetype-2.6.tar.gz
tar xf freetype-2.6.tar.gz
cd freetype-2.6
./configure --host=$TOOLCHAIN_TRIPLE --prefix=`pwd`/output --without-zlib --with-png=no --with-harfbuzz=no
make -j`nproc` && make install
cd ../wine-3.0
export CFLAGS="-O2"
export FREETYPE_CFLAGS="-I`pwd`/../freetype-2.6/output/include/freetype2"
export FREETYPE_LIBS="-L`pwd`/../freetype-2.6/output/lib"
./configure --host=$TOOLCHAIN_TRIPLE host_alias=$TOOLCHAIN_TRIPLE --with-wine-tools=../wine-3.0-native --prefix=`pwd`/dlls/wineandroid.drv/assets
make -j`nproc` && make install
cp ../freetype-2.6/output/lib/libfreetype.so dlls/wineandroid.drv/assets/arm64-v8a/lib/
cd dlls/wineandroid.drv/
make clean
make
cd $DIR
git clone https://github.com/AndreRH/hangover.git hangover
cd hangover
git submodule init
git submodule update
make
cp -r $DIR/hangover/build/qemu/x86_64-windows-user/ $DIR/output/qemu
cp $DIR/hangover/build/qemu/x86_64-windows-user/qemu-x86_64.exe.so $DIR/output/qemu/qemu.exe
cp $DIR/wine-3.0/dlls/wineandroid.drv/wine-debug.apk $DIR/output/wine.apk
