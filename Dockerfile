FROM eclipse-temurin:11-jre

WORKDIR /app

# Replace the following variables with your real values
ENV NEXUS_URL=http://nexus:8081/repository/maven-releases
ENV GROUP_ID=org.springframework.samples
ENV ARTIFACT_ID=spring-petclinic
ENV VERSION=2.7.0
ENV JAR_NAME=${ARTIFACT_ID}-${VERSION}.jar

# Convert group ID to path
ENV GROUP_PATH=$(echo ${GROUP_ID} | tr '.' '/')

# Download the artifact from Nexus
RUN apt-get update && apt-get install -y curl && \
    curl -fSL ${NEXUS_URL}/${GROUP_PATH}/${ARTIFACT_ID}/${VERSION}/${JAR_NAME} -o app.jar && \
    apt-get remove -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Run the JAR
CMD ["java", "-jar", "app.jar"]
