# Use an official OpenJDK 11 image as the base image
FROM openjdk:11-jre-slim

# Set environment variables for JMeter
ENV JMETER_VERSION 5.5
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV PATH $JMETER_HOME/bin:$PATH
ENV JMETER_SERVER_PORT 1099

# Install necessary utilities and download JMeter
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -xvzf apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
    rm -rf apache-jmeter-${JMETER_VERSION}.tgz && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR $JMETER_HOME

# Expose JMeter Server port (Default is 1099 for RMI)
EXPOSE 1099

# Start JMeter in server mode
ENTRYPOINT ["jmeter", "-s", "-Dserver_port=1099"]
