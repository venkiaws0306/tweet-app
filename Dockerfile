# Stage 1: Build
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=builder /app/target/demo-workshop-2.1.2.jar ttrend.jar
ENTRYPOINT ["java", "-jar", "ttrend.jar"]



#FROM openjdk:8
#ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.4.jar ttrend.jar 
#ADD target/demo-workshop-2.1.4.jar ttrend.jar 
#ENTRYPOINT [ "java", "-jar", "ttrend.jar" ]
