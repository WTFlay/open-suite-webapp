FROM gradle:5.6.4-jdk8

WORKDIR /app

COPY build.gradle .
COPY gradle.properties .
COPY settings.gradle .
COPY src src
COPY gradle/style.gradle gradle/style.gradle
COPY gradle/spotless.xml.prefs gradle/spotless.xml.prefs

RUN gradle build

FROM tomcat:8.5.87-jdk8-corretto

COPY --from=0 /app/build/libs/axelor-erp*.war /usr/local/tomcat/webapps/ROOT.war
