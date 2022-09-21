#Variables
ARG SONAR_LOGIN
ARG SONAR_HOST
ARG SONAR_PROJ

# Use the official maven/Java 8 image to create a build artifact.
# https://hub.docker.com/_/maven
FROM maven:3.8.6-jdk-11 as builder

# Copy local code to the container image.
WORKDIR /app

RUN mkdir ./m2
COPY settings.xml ./m2
COPY pom.xml .
COPY src ./src

# Build a release artifact.
#RUN mvn package -DskipTests

RUN mvn clean install -q -DskipTests -s ./m2/settings.xml

RUN mvn package -ntp -q -s ./m2/settings.xml

RUN echo "$SONAR_LOGIN"
RUN echo "$SONAR_HOST"
RUN echo "$SONAR_PROJ"

#RUN mvn sonar:sonar  -Dsonar.projectKey=User-Demo  -Dsonar.host.url=http://34.175.69.230:9000  -Dsonar.login=075a8f98ef594014eb3fdc6169165f7c6cd1fabb
RUN mvn sonar:sonar  -Dsonar.projectKey=$SONAR_PROJ  -Dsonar.host.url=$SONAR_HOST  -Dsonar.login=$SONAR_LOGIN


FROM adoptopenjdk/openjdk11:alpine-slim

# Copy the jar to the production image from the builder stage.
COPY --from=builder /app/target/demouser*.jar /demoUser.jar

# Run the web service on container startup.
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/demoUser.jar"]
