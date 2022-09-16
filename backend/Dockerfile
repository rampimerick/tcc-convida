#ldap.cce.ufpr.br:389 QzfBGhHFKaV1XzgVTrCx
#2d0411950c5c81d99d5b95d7ae736b393b513a59

FROM gradle:jdk8

RUN git clone https://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@github.com/ufpr-convida/backend.git

#RUN rm -r backend/build

WORKDIR backend/
RUN gradle build
RUN pwd
RUN ls build/libs

ENV JAVA_OPTS=""

FROM openjdk:8

COPY --from=0 /home/gradle/backend/build/libs/convida-0.0.1-SNAPSHOT.jar /

EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/convida-0.0.1-SNAPSHOT.jar" ]
