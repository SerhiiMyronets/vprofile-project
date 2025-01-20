pipeline {

    agent any

    environment {
        NEXUSPASS = credentials("nexuspass")
    }

    stages {

        stage ("Setup paramaters") {
            steps {
                script {
                    properties([
                        parameters([
                            string(defaultValue: '', name: 'BUILD'),
                            string(defaultValue: '', name: 'TIME')
                        ])
                    ])
                }
            }

        }

        stage ("Ansible Deploy to prod") {
            steps {
                ansiblePlaybook([
                    inventory                : 'ansible/prod.inventory',
                    playbook                 : 'ansible/site.yml',
                    installation             : 'ansible',
                    colorized                : true,
                    credentialsId            : 'applogin-prod',
                    disableHostKeyChecking   : 'true',
                    extraVars                : [
                        USER: "admin",
                        PASS: "${NEXUSPASS}",
                        nexusip: "nexus.serhii.link",
                        reponame: "vprofile-release",
                        groupid: "QA",
                        time: "${env.TIME}",
                        build: "${env.BUILD}",
                        artifactid: "vproapp",
                        vprofile_version: "vproapp-${env.BUILD}-${env.TIME}.war"
                    ]
                ])
            }
        }
    }
}