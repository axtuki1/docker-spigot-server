# args

# JDKのバージョン
# 1.17以前: openjdk-8-jre-headless
# 1.17    : openjdk-16-jre-headless
# 1.17以降: openjdk-17-jre-headless
ARG JDK_PACKAGE=openjdk-17-jre-headless

# Minecraftのバージョン
ARG MC_VERSION=1.20.2

# -----

FROM ubuntu:latest
RUN apt update && apt upgrade -y && apt install -y tzdata wget
ENV TZ Asia/Tokyo
WORKDIR /opt
ARG JDK_PACKAGE
ARG MC_VERSION
RUN apt install -y ${JDK_PACKAGE} git && wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -Xmx1024M -Xms1024M -jar ./BuildTools.jar --rev ${MC_VERSION}
COPY ./resources/run.sh ./
WORKDIR /mnt/var
CMD ["sh", "/opt/run.sh"]

