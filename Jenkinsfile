pipeline {

    agent any

    tools {
        maven "MAVEN3"
        jdk "OracleJDK8"
    }

    environment {
        SNAP-REPO = 'vprofile-snapshot'
        NEXUS-USER = 'admin'
        NEXUS-PASS = 'se64q7aXtCb6aA8'
        RELEASE-REPO = 'vprofile-release'
        CENTRAL-REPO = 'vpro-maven-central'
        NEXUSIP = '172.31.31.136'
        NEXUSPORT = '8081'
        NEXUS-GRP-REPO = 'vpro-maven-group'
        NEXUS-LOGIN = 'nexus-login'

    }

    stages {
        stage('Build') {
            steps () {
                sh 'mvn -s settings.xml -DskipTests install'
            }
        }
    }
}