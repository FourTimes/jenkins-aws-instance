pipeline {
    agent any 
     environment {
        AWS_ACCESS_KEY_ID     = credentials('ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('SECRET_KEY')
        REGION                = 'us-east-1'
    }      
    stages {
        stage('AWS LOGIN') {
            steps {
                sh '''
                    aws configure set region $REGION
                '''
            } 
        }
        stage('TERRAFORM INIT') {
            steps {
                sh '''
                    terrform init
                '''
            } 
        }
        stage('TERRAFORM VALIDATE') {
            steps {
                sh '''
                    terraform validate
                '''
            } 
        }
        stage('TERRAFORM FORMAT') {
            steps {
                sh '''
                    terraform fmt
                '''
            } 
        }
        stage('TERRAFORM PLAN') {
            steps {
                sh '''
                    terraform plan
                '''
            } 
        }
        stage('TERRAFORM APPLY') {
            steps {
                sh '''
                    terraform apply -auto-approve
                '''
            } 
        }
    }
}
