FROM eclipse-temurin:21-jdk AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY gradlew .
COPY settings.gradle .
COPY gradle gradle
COPY app app
RUN chmod a+x gradlew
RUN ./gradlew assemble

FROM eclipse-temurin:21-jre
COPY --from=build /workspace/app/build/libs/*.jar app.jar
EXPOSE 6379
ENTRYPOINT ["java","-jar","app.jar"]