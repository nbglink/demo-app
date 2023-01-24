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
        IMAGE_NAME = 'nbglink/demo-app:java-maven-8.0'
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
                }
            }
        }
        // stage('Update GIT and Deloy in ArgoCD') {
        //   steps {
        //     script {
        //       catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
        //         withCredentials([usernamePassword(credentialsId: 'github-credentials', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
        //             def encodedPassword = URLEncoder.encode("$GIT_PASSWORD",'UTF-8')
        //             sh "git add terraform-eks-infra/"
        //             sh "git commit -m 'Triggered Build: ${env.BUILD_NUMBER}'"
        //             sh "git push https://${GIT_USERNAME}:${encodedPassword}@github.com/${GIT_USERNAME}/DevOpsUpskill-FinalProject.git HEAD:main"
        //         }
        //       }
        //     }
        //   }
        // }
    }
}
