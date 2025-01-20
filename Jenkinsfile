pipeline {

    agent any

    tools {
        maven "MAVEN3"
        jdk "OracleJDK8"
    }

    environment {
        SNAP_REPO = 'vprofile-snapshot'
        RELEASE_REPO = 'vprofile-release'
        CENTRAL_REPO = 'vpro-maven-central'
        NEXUS_GRP_REPO = 'vpro-maven-group'
        NEXUS_USER = 'admin'
        NEXUS_PASS = '4iGD6EKGt4fV4WU'
        NEXUSIP = '172.31.31.136'
        NEXUSPORT = '8081'
        NEXUS_LOGIN = 'nexus-login'
        SONARSERVER = 'sonar-server'
        SONARSCANNER = 'sonar-scanner'
        NEXUSPASS = credentials("nexuspass")

    }

    stages {
        stage('Build') {
            steps () {
                sh 'mvn -s settings.xml -DskipTests install'
            }
            post {
                success {
                    echo "Now Archiving."
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }

        stage('Test') {
            steps {
                sh 'mvn -s settings.xml test'
            }
        }

        stage('Checkstyle Analysis') {
            steps {
                sh 'mvn -s settings.xml checkstyle:checkstyle'
            }
        }

        stage('Sonar Analysis') {
            environment {
                scannerHome = tool "${SONARSCANNER}"
            }
            steps {
                withSonarQubeEnv("${SONARSERVER}") {
                   sh '''${scannerHome}/bin/sonar-scanner \
                   -Dsonar.projectKey=vprofile \
                   -Dsonar.projectName=vprofile \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
                }
            }
        }
        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage("Upload Artifact"){
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: "${NEXUSIP}:${NEXUSPORT}",
                    groupId: 'QA',
                    version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}",
                    repository: "${RELEASE_REPO}",
                    credentialsId: "${NEXUS_LOGIN}",
                    artifacts: [
                        [
                        artifactId: 'vproapp',
                        classifier: '',
                        file: 'target/vprofile-v2.war',
                        type: 'war'
                        ]
                    ]
                )
            }
        }
        stage ("Ansible Deploy to staging") {
            steps {
                ansiblePlaybook([
                    inventory                : 'ansible/stage.inventory',
                    playbook                 : 'ansible/site.yml',
                    installation             : 'ansible',
                    colorized                : true,
                    credentialsId            : 'applogin',
                    disableHostKeyChecking   : 'true',
                    extraVars                : [
                        USER: "admin",
                        PASS: "${NEXUSPASS}",
                        nexusip: "nexus.serhii.link",
                        reponame: "vprofile-release",
                        groupid: "QA",
                        time: "${env.BUILD_TIMESTAMP}",
                        build: "${env.BUILD_ID}",
                        artifactid: "vproapp",
                        vprofile_version: "vproapp-${env.BUILD_ID}-${env.BUILD_TIMESTAMP}.war"
                    ]
                ])
            }
        }
    }
}