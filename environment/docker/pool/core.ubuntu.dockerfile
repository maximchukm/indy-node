FROM --platform=linux/amd64 indybase

ARG uid=1000

# Install environment
RUN apt-get update -y && apt-get install -y \
	git \
	wget \
	python3.5 \
	python3-pip \
	python-setuptools \
	python3-nacl \
	apt-transport-https \
	ca-certificates
RUN pip3 install -U \
	'pip<10.0.0' \
	'setuptools<=50.3.2'
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CE7709D068DB5E88
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BD33704C
RUN echo "deb https://repo.sovrin.org/deb xenial master" >> /etc/apt/sources.list
RUN echo "deb https://repo.sovrin.org/sdk/deb xenial master" >> /etc/apt/sources.list
RUN useradd -ms /bin/bash -l -u $uid indy
RUN apt-get update -y && apt-get install -y \
        python3-orderedset=2.0 \
        python3-psutil=5.4.3 \
        python3-pympler=0.5 \
        indy-plenum=1.12.1~dev989 \
        indy-node=1.12.1~dev1172 libindy
RUN pip3 install python3-indy
USER indy
WORKDIR /home/indy
