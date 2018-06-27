FROM ataber/petsc

RUN apt-get update --fix-missing \
&&  apt-get upgrade -y --force-yes \
&&  apt-get install -y --force-yes \
    git \
    m4 \
    pkg-config \
    libvtk6-dev \
    libmetis-dev \
    libhypre-dev \
&&  apt-get clean \
&&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN cd /tmp && \
    git clone https://github.com/mfem/mfem.git && \
    cd libmesh && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/opt/mfem \
             -DMFEM_THREAD_SAFE=YES \
             -DMFEM_USE_OPENMP=YES \
             -DMFEM_USE_MPI=YES && \
    make -j $(cat /proc/cpuinfo | grep processor | wc -l) && \
    make install && \
    cd /tmp && rm -rf mfem
ENV MFEM_DIR /opt/mfem
