#!/bin/bash

CUDA_VER64="cuda_5.0.35_linux_64_ubuntu11.10-1.run"
#CUDA_VER64="cuda_5.0.35_linux_64_ubuntu11.10-1.run"
CUDA_VER32="cuda_5.0.35_linux_32_ubuntu11.10-1.run"
#CUDA_VER SHOULD INITIALLY BE THE SAME AS CUDA_VER32
CUDA_VER="cuda_5.0.35_linux_64_ubuntu11.10-1.run"

echo "Friendly CUDA Scripts brought to you by AmmarkoV ( http://ammar.gr )"


if [ -e $CUDA_VER64 ]
then 
  echo "Detected an existing 64bit executable of cuda"  
fi

if [ -e $CUDA_VER32 ]
then 
  echo "Detected an existing 32bit executable of cuda"  
fi


MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == "x86_64" ]; then
  echo "This machine should best install a 64bit version of CUDA"
  echo
  echo   
  echo "Would you like a 32 bit installation , despite your 64bit capable machine ?"
  echo
  echo -n "            (Y/N)?"
  read answer
  if test "$answer" != "Y" -a "$answer" != "y";
  then 
    CUDA_VER=$CUDA_VER64
   fi
else
  echo "This machine should best install a 32bit version of CUDA" 
  #CUDA_VER SHOULD ALREADY BE SET TO $CUDA_VER32
fi
 
echo "Working with $CUDA_VER" 

if [ -e $CUDA_VER ]
then 
  echo "StartingUP! :)"
else
  echo "This script is fixed to run for $CUDA_VER , if you want you can change the CUDA_VER variable in the start of the script to match a version that exists in your current directory  the other option is to try and download it now from nvidia!"
  echo
  echo
  echo "Would you like to try and download cuda from nvidia now ? "
  echo
  echo -n "                Do you want to proceed (Y/N)?"
  read answer
  if test "$answer" != "Y" -a "$answer" != "y";
  then exit 0;
  fi
  wget "http://developer.download.nvidia.com/compute/cuda/5_0/rel-update-1/installers/$CUDA_VER"
  if [ -e $CUDA_VER ]
  then 
   echo "Downloaded a fresh copy of $CUDA_VER , lets hope it is good :)"
  else
   echo "Could not download  $CUDA_VER "
   exit 0
  fi 
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

exit 0
