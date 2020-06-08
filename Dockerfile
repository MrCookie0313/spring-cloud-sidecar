FROM registry.sensetime.com/evoa-test/maven:3.6.0-jdk-8-alpine-sh-settings as builder

WORKDIR /app
COPY . .
ENV MAVEN_HOST 10.198.20.154
RUN echo "${MAVEN_HOST} mvn.sh.sensetime.com" >> /etc/hosts && mvn clean install

FROM registry.sensetime.com/evoa-test/alpine-oraclejdk8:slim

WORKDIR /app
COPY --from=builder /app/target/*.jar /app
RUN find -name "*.jar" -exec ln -s {} app.jar \;
ENV JAVA_OPTS="-XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m -Xms512m -Xmx512m -Xmn256m -Xss256k -XX:SurvivorRatio=8 -XX:+UseConcMarkSweepGC"

CMD ["/usr/bin/java", "-jar", "app.jar", "--spring.config.location=/config/"]