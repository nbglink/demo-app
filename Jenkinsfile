#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@main', retriever: modernSCM(
    [$class: 'GitSCMSource',
     remote: 'https://github.com/nbglink/jenkins-shared-library.git',
     credentialsId: 'github-credentials'
    ]
)
// CI part
def user_choice = ""
pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    environment {
        IMAGE_NAME = 'nbglink/demo-app:jma-11'
        APPLICATION_NAME = 'demo-app'
    }
    stages {
        stage('build app') {
            steps {
               script {
                  echo 'building application jar...'
                  buildJar()
               }
            }
        }
        stage('build image') {
            steps {
                script {
                   echo 'building docker image...'
                   buildImage(env.IMAGE_NAME)
                   dockerLogin()
                   dockerPush(env.IMAGE_NAME)
                   sh "mkdir --parents ./argocd-app-config/$env.APPLICATION_NAME/ && mv ./target/classes/META-INF/dekorate/kubernetes.yml $_"
                }
            }
        }
        stage('Update GIT and Deloy in ArgoCD') {
          steps {
            script {
              catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                withCredentials([usernamePassword(credentialsId: 'github-credentials', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    def encodedPassword = URLEncoder.encode("$GIT_PASSWORD",'UTF-8')
                    sh "git add argocd-app-config/"
                    sh "git commit -m 'Triggered Build: ${env.BUILD_NUMBER}'"
                    sh "git push https://${GIT_USERNAME}:${encodedPassword}@github.com/${GIT_USERNAME}/DevOpsUpskill-FinalProject-Infra.git HEAD:main"
                }
              }
            }
          }
        }
    }
}
