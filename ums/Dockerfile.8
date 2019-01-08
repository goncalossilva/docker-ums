FROM debian:stretch-slim
MAINTAINER Gonçalo Silva <goncalossilva@gmail.com>

# ensure man page directory exists so that the slim variant builds
RUN mkdir -p /usr/share/man/man1

# install packages per https://github.com/UniversalMediaServer/UniversalMediaServer/wiki/Linux-install-instructions
RUN (dpkg --add-architecture i386 &&\
  apt-get update &&\
  DEBIAN_FRONTEND=noninteractive apt-get install -y dcraw flac libfreetype6:i386 libstdc++6:i386 libbz2-1.0:i386 lib32z1 lib32ncurses5 mediainfo mencoder mplayer openjdk-8-jre vlc wget &&\
  rm -rf /var/lib/apt/lists/*)

ENV UMS_PROFILE /opt/ums/UMS.conf

# get latest release number and use that to install UMS; fail to install if version is not 7.x
RUN (UMSVER=$(wget -q -O - https://api.github.com/repos/UniversalMediaServer/UniversalMediaServer/releases/latest | python -c "import sys, json; print json.load(sys.stdin)['name']") &&\
  if [ "$(echo $UMSVER | awk -F '.' '{print $1}')" -ne "7" ]; then echo "Latest version number is no longer 7"; exit 1; fi &&\
  wget "http://sourceforge.net/projects/unimediaserver/files/Official%20Releases/Linux/UMS-${UMSVER}.tgz/download" -O /opt/UMS-${UMSVER}.tgz &&\
  cd /opt &&\
  tar zxf UMS-${UMSVER}.tgz &&\
  rm UMS-${UMSVER}.tgz &&\
  mv ums-${UMSVER} ums &&\
  mkdir /opt/ums/database /opt/ums/data)

WORKDIR /opt/ums
EXPOSE 1900/udp 2869 5001 9001
VOLUME ["/tmp","/opt/ums/database","/opt/ums/data"]
CMD ["/opt/ums/UMS.sh"]
