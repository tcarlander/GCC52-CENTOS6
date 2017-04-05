FROM centos:6


RUN yum install -y gcc gcc-c++ make openssl-devel perl wget libuuid-devel python-devel xz

RUN mkdir /build &&\
    cd /build &&\
    wget -q http://ftpmirror.gnu.org/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2 &&\
    wget -q https://gmplib.org/download/gmp/gmp-6.0.0a.tar.xz &&\
    wget -q ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz &&\
    wget -q http://www.mpfr.org/mpfr-current/mpfr-3.1.5.tar.xz &&\
    tar xf gcc-5.2.0.tar.bz2 &&\
    tar xf gmp-6.0.0a.tar.xz &&\
    mv gmp-6.0.0 gcc-5.2.0/gmp &&\
    tar xf mpc-1.0.3.tar.gz &&\
    mv mpc-1.0.3 gcc-5.2.0/mpc &&\
    tar xf mpfr-3.1.5.tar.xz &&\
    mv mpfr-3.1.5 gcc-5.2.0/mpfr && \
    mkdir /build/gcc-5.2.0/gcc-build && \
    cd /build/gcc-5.2.0/gcc-build && \
    ../configure --prefix=/root/gcc5 \
             --disable-multilib \
             --enable-languages=c,c++ \
             --enable-libstdcxx-threads \
             --enable-libstdcxx-time \
             --enable-shared \
             --enable-__cxa_atexit \
             --disable-libunwind-exceptions \
             --disable-libada \
             --host x86_64-redhat-linux-gnu \
             --build x86_64-redhat-linux-gnu \
             --with-default-libstdcxx-abi=gcc4-compatible && \
    make -j4 && \
    make install  
    
ENV GCC5_ROOT=/root/gcc5
ENV PATH=$GCC5_ROOT/bin:$PATH
ENV MANPATH=$GCC5_ROOT/share/man:MANPATH
ENV INFOPATH=$GCC5_ROOT/share/info:$INFOPATH
ENV LD_LIBRARY_PATH=$GCC5_ROOT/lib64:$GCC5_ROOT/lib:$LD_LIBRARY_PATH
ENV LD_RUN_PATH=$GCC5_ROOT/lib64:$GCC5_ROOT/lib:$LD_RUN_PATH
ENV LIBRARY_PATH=$GCC5_ROOT/lib64:$GCC5_ROOT/lib:$LIBRARY_PATH
ENV INCLUDE_PATH=$GCC5_ROOT/include:$INCLUDE_PATH
ENV CPLUS_INCLUDE_PATH=$GCC5_ROOT/include:$CPLUS_INCLUDE_PATH
ENV C_INCLUDE_PATH=$GCC5_ROOT/include:$C_INCLUDE_PATH

