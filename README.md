# OpenStack Swift in a container

This is a containerized OpenStack swift node, based on Alpine Linux


Some things here needed to be done manually, because of how Alpine and Python work out of the box. Here's what you would find in the Dockerfile:

* manually install pip3:
  * Alpine does not have pip3 in the repos, so installing it manually

* Get liberasurecode:
  * not available in pip. note that after compiling and installing, I copy the libs to Python's external library folder, as Python does not find them when they are in /usr/local/lib

* Compile and install xattr
  * Swift requires python's xattr, which fails to compile. The reason is that lib_build is looking for the C type u_int32_t, when it should be uint32_t. So, download the entire src, sed to replace and compile

* compiling pyeclib
  * initially as I could not figure out what it failed to install with pip (see liberasurecode above). consider turning to 'pip install pyeclib'
