# python pip
sudo apt-get install python-pip python-dev build-essential 
sudo apt-get install python-setuptools
sudo pip install --upgrade pip
sudo pip install --upgrade virtualenv 

# python scipy
sudo apt-get install gfortran swig liblapack-dev libzmq-dev
sudo apt-get install libatlas-base-dev libjpeg-dev libhdf5-serial-dev
sudo apt-get install liblzo2-dev libsuitesparse-dev
sudo apt-get install libpng12-dev libfreetype6-dev tk-dev
# sudo apt-get build-dep matplotlib
# sudo apt-get install python-numpy

sudo pip install virtualenv
sudo pip install virtualenvwrapper
sudo pip install numpy # core numerics library
sudo pip install nose  # testing library
sudo pip install numexpr # prereq for tables
sudo pip install cython  # prereq for tables
sudo pip install tables  # hdf5 support for python (savig big arrays on disk)
sudo pip install scipy   # science stuff
sudo pip install ipython # nice interactive prompt
sudo pip install deap # mpi stuff
sudo pip install pyzmq # socket lib for ipython.parallel
sudo pip install fastcluster # fast hierarchical clustering library
sudo pip install matplotlib   # recommended

# ipython
sudo apt-get install ipython
sudo apt-get install ipython-notebook

# For Ubuntu 12
# Change matplotlib backend to use Qt4Agg via matplotlibrc
# 
# In /usr/local/lib/python2.7/dist-packages/matplotlib/mpl-data/matplotlibrc or .matplotlib/matplotlibrc
#
# backend      : Qt4Agg
