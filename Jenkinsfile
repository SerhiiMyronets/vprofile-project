pipeline {

    agent any

    tools {
        maven "MAVEN3"
        jdk "OracleJDK8"
    }

    environment {
        SNAP-REPO = 'vprofile-snapshot'
        RELEASE-REPO = 'vprofile-release'
        CENTRAL-REPO = 'vpro-maven-central'
        NEXUS-GRP-REPO = 'vpro-maven-group'
        NEXUS-USER = 'admin'
        NEXUS-PASS = '4iGD6EKGt4fV4WU'
        NEXUSIP = '172.31.31.136'
        NEXUSPORT = '8081'
        NEXUS-LOGIN = 'nexus-login'

    }

    stages {
        stage('Build') {
            steps () {
                sh 'mvn -DskipTests install'
            }
        }
    }
}