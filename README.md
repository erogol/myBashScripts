<b>Some Bash Scripts for Linux </b>

<b>installCuda5.sh</b> - It installs CUDA5 with all the work necessary to correct the installation at Ubuntu 12.10. You might get it and change the 
parameters and file path as your needs then run it. Please acknowledge me for any trouble.

<b>installCudaToUbuntu12_10Optimus.sh</b> - More general script for installation of CUDA to NVIDIA Optimus kind of graphic cards. Before the installation
with this script please set the path variable of the CUDA installtion script gathered from https://developer.nvidia.com/cuda-downloads with respect to 
your system configuration (I am at Ubuntu 12.10 with GT635m so I install the kid for Ubuntu 11.10 64bit). In addition if you are with Optimus card
 on linux environment you need to install blessed nvidia interface bumblebee with the commands :

sudo add-apt-repository ppa:bumblebee/stable
sudo add-apt-repository ppa:ubuntu-x-swat/x-updates
sudo apt-get update
sudo apt-get install bumblebee bumblebee-nvidia

then reboot or relogin.

for more information about bumblebee: http://bumblebee-project.org/install.html


