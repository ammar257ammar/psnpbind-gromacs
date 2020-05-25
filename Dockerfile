# ubuntu 18 tags docker: 18.04, bionic-20191029, bionic, latest
FROM        ubuntu:bionic-20191029
MAINTAINER  ammar257ammar@gmail.com

USER root

ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive 

# update and install dependencies
RUN         apt-get update \
                && apt-get install -yq \
                    software-properties-common \
                    wget \
		    libopenmpi-dev \
		    openmpi-bin \
		    openjdk-8-jdk \
		    expect \
                && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
                && apt-get update \
                && apt-get install -yq \
                    make \
                    git \
                    curl \
                    vim \
                    vim-gnome \
		    grace=1:5.1.25-5build1 \
                && apt-get install -yq cmake=3.10.2-1ubuntu2.18.04.1 \
                && apt-get install -yq \
                    gcc-8 g++-8 gcc-8-base \
                && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 100 \
                && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 100


WORKDIR /gromacs

COPY gromacs-2019.4.tar.gz ./

RUN tar xfz gromacs-2019.4.tar.gz

WORKDIR /gromacs/gromacs-2019.4
RUN mkdir build-normal
WORKDIR /gromacs/gromacs-2019.4/build-normal
RUN cmake .. -DGMX_BUILD_OWN_FFTW=ON -DCMAKE_INSTALL_PREFIX=/usr/local/gromacs
RUN make -j 12
RUN make install
RUN make check
WORKDIR /gromacs/gromacs-2019.4
RUN mkdir build
WORKDIR /gromacs/gromacs-2019.4/build
RUN cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON -DGMX_BUILD_MDRUN_ONLY=ON -DGMX_MPI=on -DCMAKE_INSTALL_PREFIX=/usr/local/gromacs
RUN make -j 12
RUN make install
RUN /bin/bash -c "source /usr/local/gromacs/bin/GMXRC"

WORKDIR /command
COPY gromacs-em.sh ./
COPY psbap-gromacs-0.0.1-SNAPSHOT-jar-with-dependencies.jar ./
COPY config.mdp ./

RUN chmod 755 gromacs-em.sh
RUN chmod 755 psbap-gromacs-0.0.1-SNAPSHOT-jar-with-dependencies.jar

ENTRYPOINT ["java", "-jar", "/command/psbap-gromacs-0.0.1-SNAPSHOT-jar-with-dependencies.jar"]
CMD ["-h"]

