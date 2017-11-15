#!bin/bash

PROJ4=proj-4.9.3
BASEMAP=1.1.0
VERYTMPDIR=basemap_downloads
VERYTOPDIR=$PWD
GEOS_DIR=/usr/local/
PROJ_DIR=/usr/local/

# Install and set to GCC instead of clang
brew install gcc
export CC=gcc-7

# Enter tmp directory
mkdir $VERYTMPDIR
cd $VERYTMPDIR

# Get Proj4j
wget http://download.osgeo.org/proj/${PROJ4}.tar.gz
tar -xvf ${PROJ4}.tar.gz
cd ${PROJ4}
mkdir $VERYTMPDIR # Bizarre bug fix
./configure --prefix=$PROJ_DIR
make
make install

# Get basemap
cd ../
wget https://github.com/matplotlib/basemap/archive/v${BASEMAP}.tar.gz
tar -xvf v${BASEMAP}.tar.gz
cd basemap-${BASEMAP}

# Install GEOS
cd geos-3.3.3
./configure --prefix=$GEOS_DIR
make
make install

# Install BaseMap
cd ../
python setup.py install

# Back to the top
cd $VERYTOPDIR
rm -r $VERYTMPDIR

# Install pyproj
pip install pyproj
