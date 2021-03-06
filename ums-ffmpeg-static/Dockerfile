FROM debian:stretch-slim
MAINTAINER Gonçalo Silva <goncalossilva@gmail.com>

# install packages per https://github.com/UniversalMediaServer/UniversalMediaServer/wiki/Linux-install-instructions
# libfreetype6 is necessary to make tsMuxeR work
# removing the EUID check is necessary to make vlc work under root
RUN (mkdir -p /usr/share/man/man1 &&\
	dpkg --add-architecture i386 &&\
	apt-get update &&\
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends openjdk-8-jre wget xz-utils mediainfo mencoder dcraw flac mplayer vlc-nox lib32z1 lib32ncurses5 libbz2-1.0:i386 libstdc++6:i386 libfreetype6:i386 p7zip &&\
  sed -i 's/geteuid/getppid/' `which vlc` &&\
  rm -rf /var/lib/apt/lists/* /usr/share/man/*)

ENV UMS_PROFILE /opt/ums/UMS.conf

# get latest release number and use that to install UMS
ARG UMS_VERSION
RUN (cd /opt &&\
  UMS_VERSION=${UMS_VERSION:=`wget -qO- https://api.github.com/repos/UniversalMediaServer/UniversalMediaServer/releases/latest | python -c "import sys, json; print json.load(sys.stdin)['name']"`} &&\
  wget -qO- "https://github.com/UniversalMediaServer/UniversalMediaServer/releases/download/${UMS_VERSION}/UMS-${UMS_VERSION}.tgz" | tar zx &&\
  mv ums-${UMS_VERSION} ums &&\
  rm -rf ums/linux/jre-*/ &&\
  mkdir /opt/ums/database /opt/ums/data)

# update ffmpeg to the latest version
RUN (cd /opt/ums/linux &&\
  wget -qO- "https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz" | tar Jx --wildcards */ffmpeg &&\
  mv */ffmpeg ffmpeg64 &&\
  wget -qO- "https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-i686-static.tar.xz" | tar Jx --wildcards */ffmpeg &&\
  mv */ffmpeg ffmpeg &&\
  rmdir ffmpeg-*)

WORKDIR /opt/ums
EXPOSE 1900/udp 2869 5001 9001
VOLUME ["/tmp","/opt/ums/database","/opt/ums/data"]
CMD ["/opt/ums/UMS.sh"]
