# ==========================
# Etapa 1: Compilación
# ==========================
FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

# ==========================
# Etapa 2: Ejecución
# ==========================
FROM eclipse-temurin:21-jdk

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

# Cambiamos al puerto estándar de Eureka Server
EXPOSE 8761

ENTRYPOINT ["java","-jar","app.jar"]