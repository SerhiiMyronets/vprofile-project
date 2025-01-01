FROM arm64v8/maven:3.9.9-eclipse-temurin-17 AS build

RUN git clone https://github.com/SerhiiMyronets/vprofile-project

WORKDIR /vprofile-project

RUN git checkout containers && mvn install

FROM tomcat:10-jdk17-temurin

RUN rm -rf webapps/*

COPY --from=build vprofile-project/target/vprofile-v2.war webapps/ROOT.war

EXPOSE 8080

# CMD ["sleep", "5000"]
CMD ["catalina.sh", "run"]