pipeline {

    agent any

    tools {
        maven "MAVEN3"
        jdk "OracleJDK8"
    }

    environment {
        SNAP_REPO = 'vprofile-snapshot'
        NEXUS_USER = 'admin'
        NEXUS_PASS = 'se64q7aXtCb6aA8'
        RELEASE_REPO = 'vprofile-release'
        CENTRALREPO = 'vpro-maven-central'
        NEXUSIP = '172.31.31.136'
        NEXUSPORT = '8081'
        NEXUSGRP = 'vpro-maven-group'
        NEXUS_LOGIN = 'nexus-login'
    }

    stages {
        stage('Build') {
            steps () {
                sh 'mvn -s settings.xml -DskipTests -X install'
            }
        }
    }
}