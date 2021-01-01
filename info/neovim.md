# show selection count

useful when showcmd is disabled
g^G

# build release

## https://github.com/mikelxc/Workarounds-for-ARM-mac

git clone git@github.com:neovim/neovim
cd neovim
git remote add qvacua git@github.com:qvacua/neovim.git
git fetch qvacua
git checkout build-arm64-mac
echo "DEPS_CMAKE_FLAGS += -DCMAKE_OSX_DEPLOYMENT_TARGET=11.00" > local.mk
make SDKROOT=`xcrun --show-sdk-path` CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/nvim"
