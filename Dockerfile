# Clone project using GIT
FROM bitnami/git:2.37.0 AS Gitclone
RUN mkdir /cal
WORKDIR /cal
RUN git clone https://github.com/VirtualHost101/project.git


# Packaging SRC Using Maven for Binaries
FROM maven:3.8-openjdk-11 AS Mavenbuild
WORKDIR /cal
COPY --from=Gitclone /cal/project/ ./
#COPY pom.xml pom.xml
RUN mvn clean
RUN mvn package


# Base Image Tomcat - Pushing War 
FROM tomcat:8.0
COPY --from=Mavenbuild /cal/target/*.war /usr/local/tomcat/webapps
EXPOSE 8080
