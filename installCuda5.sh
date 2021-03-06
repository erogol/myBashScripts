#!/bin/bash

# change the path accordinly
CUDA_VER="cuda_5.0.35_linux_64_ubuntu11.10-1.run"

if [ -e $CUDA_VER ]
then
echo "StartingUP!  "
else
echo "This script is fixed to run for $CUDA_VER , if you want you can change the CUDA_VER variable in the start of the script to match your version!"
echo "Hope nothing breaks!  ,you ve been warned I have no responsibility!"
exit 0
fi

sudo apt-get install build-essential gcc-4.4 g++-4.4 freeglut3-dev
sudo ./$CUDA_VER -override compiler

cd ~/NVIDIA_CUDA-5.0_Samples
mkdir gccMagic
cd gccMagic

ln -s /usr/bin/cpp-4.4 cpp
ln -s /usr/bin/gcc-4.4 gcc
ln -s /usr/bin/g++-4.4 g++

if cat /usr/local/cuda/bin/nvcc.profile | grep -q "compiler-bindir"
then
echo "GCC switching magic seems to be ok!"
else
echo "Adding a switched GCC Version!"
sudo sh -c 'echo "compiler-bindir = `pwd`" >>/usr/local/cuda/bin/nvcc.profile'
fi

if echo $PATH | grep -q "cuda-5.0/bin"
then
echo "CUDA already mentioned in PATH "
else
echo "Adding CUDA to PATH using bashrc!"
sudo sh -c 'echo "export PATH=$PATH:/usr/local/cuda-5.0/bin" >>~/.bashrc'
fi

if [ -d "/usr/local/cuda-5.0/lib64" ]
then
echo "Detected 64bit lib folder"
#64bit lib folder
if echo $LD_LIBRARY_PATH | grep -q "cuda-5.0/lib64"
then
echo "CUDA already in LD_LIBRARY_PATH "
else
echo "Adding CUDA to LD_LIBRARY_PATH using bashrc!"
sudo sh -c 'echo "export LD_LIBRARY_PATH=/usr/local/cuda-5.0/lib64:/lib" >>~/.bashrc'
fi
elif [ -d "/usr/local/cuda-5.0/lib" ]
then
echo "Detected 32bit lib folder"
#32bit lib folder
if echo $LD_LIBRARY_PATH | grep -q "cuda-5.0/lib"
then
echo "CUDA already in LD_LIBRARY_PATH "
else
echo "Adding CUDA to LD_LIBRARY_PATH using bashrc!"
sudo sh -c 'echo "export LD_LIBRARY_PATH=/usr/local/cuda-5.0/lib" >>~/.bashrc'
fi
fi

sudo ldconfig /usr/local/cuda-5/lib
sudo ldconfig /usr/local/cuda-5/lib64

echo "Installation is completed! If any error will occur please let me know to check the script!" 

exit 0