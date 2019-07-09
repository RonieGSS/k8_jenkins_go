// Revel Staging Environment

// Pipeline Variables
def app = "revel"

// Pipeline Functions

/** 
 * Blue/Green Deployment Functions
 */

/**
 * Reads the site deploy from staging deploy.txt file
 *
 * @param deploymentDir the directory path towards deploy.txt file
 * @return deploy -> either "blue" or "green" - the service to deploy
 */
def getCurrentDeployment(deploymentDir) {
	def deployCode = readFile("./ops/docker/$deploymentDir/deploy.txt").trim()
	return deployCode
}
/**
 * Get the switch code based from deploy
 *
 * @param deploymentDir the directory path towards deploy.txt file
 * @return deploy code -> either empty string('') or '-green' - the service to switch to
 */
def getSwitchCode(deploymentDir) {
	def currentDeployment = getCurrentDeployment(deploymentDir)
	def codes = ['green':'', 'blue':'-green']

	if (currentDeployment == 'blue' || currentDeployment == 'green') {
		return codes.get(currentDeployment)
	}
	return 'Error'
}
/**
 * Get the deployment code based from deploy
 *
 * @param deploymentDir the directory path towards deploy.txt file
 * @return deploy -> either "blue" or "green" - the service to deploy
 */
def getDeploymentCode(deploymentDir) {
	def currentDeployment = getCurrentDeployment(deploymentDir)
	def codes = ['blue':'', 'green':'-green']

	if (currentDeployment == 'blue' || currentDeployment == 'green') {
		return codes.get(currentDeployment)
	}
	return 'Error'
}

// Pipeline Stages
pipeline {
	agent any
	environment {
		CLOUD_REGISTRY = credentials('CLOUD_REGISTRY')
		PROJECT        = credentials('PROJECT')
	}
	stages {
		stage('SCM') {
			steps {
				checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'freenance-repo-jenkins-key', url: 'git@github.com:qmu-jp/frnc-backend.git']]])
			}
		}
		stage('Build Original Image') {
			steps {
				echo "Build Original Image"
				script {
					docker.build("hxhroniegss/revel", "./ops/docker/original/revel")
				}
			}
		}
		stage('Set Production Configuration') {
			steps {
				sh("cp src/revel/app/lib/db.go.prod src/revel/app/lib/db.go")
				sh("cp src/revel/conf/app.conf.prod src/revel/conf/app.conf")
			}
		}
		stage('Build Node Modules') {
			steps {
				echo "Production script"
				sh("touch ./src/index.js")
				script {
					docker.image('qmu1/webpack:latest').withRun("-v $WORKSPACE:/workspace") { c ->
						sh 'cd src/front; npm install'
					}
					docker.image('qmu1/webpack:latest').withRun("-e NODE_ENV=production -v $WORKSPACE:/workspace") { c ->
						sh 'cd src/front; webpack \
					         --env.production \
					         --mode=production \
					         --optimize-dedupe \
					         --optimize-occurrence-order \
					         --optimize-max-chunks 15 \
					         --optimize-min-chunk-size 10000 \
					         --optimize-minimize'
					}
				}
			}
		}
		stage('Build and Push Production Image') {
			steps {
				echo "Production Revel Image"
				script {
					withDockerRegistry(credentialsId: 'gcr:freenance', url: "https://$CLOUD_REGISTRY") {
					    def productionImage = docker.build("$CLOUD_REGISTRY/revel", "--no-cache -f ops/docker/production/revel/Dockerfile ./")
					    productionImage.push()
					}
				}
				sh("docker rmi $CLOUD_REGISTRY/revel")
			}	
		}
		stage('Staging Deployment') {
			when {
				not {
					anyOf {
						equals expected: 'Error', actual: getSwitchCode('staging');
						equals expected: 'Error', actual: getDeploymentCode('staging')
					}
				}
			}
			environment {
				KUBERNETES_IP      = credentials('KUBERNETES_IP')
				STAGING_URL        = credentials('ADMIN_STAGING_URL')
				STAGING_URL_IP     = credentials('ADMIN_STAGING_URL_IP')
			}
			steps {
				script {
					withKubeConfig(credentialsId: 'kubernetes-user-pass', serverUrl: "https://$KUBERNETES_IP") {
						sh("kubectl get pods")
						/**
					 	 *
					 	 * Setup for Blue/Green Deployment
					 	 *
						 */
						echo "Start Blue/Green Deployment"

						/**
						 *
						 * Service Deployment
						 *
						 */
						 def env                       = 'staging'
						 def dir                       = 'staging/revel'
						 def switchCode                = getSwitchCode('staging')
						 def deploymentCode            = getDeploymentCode('staging')
						 def switchToServiceLabel      = "${app}${switchCode}"
						 def deployServiceLabel        = "${app}${deploymentCode}"

						 // Switch Traffic to Another Revel Service
						sh("LOAD_BALANCER=$STAGING_URL_IP \
							envsubst < ./ops/docker/${dir}/service.yaml | kubectl patch \
							-p '{\"spec\":{\"selector\": {\"app\": \"${switchToServiceLabel}-${env}\"}}}' -f -")

						// Switch labels of https pod
						sh("kubectl label pod https-${app} app=${switchToServiceLabel}-${env} --overwrite")

						// Revel Deployment
						sh("kubectl set image deployment/${deployServiceLabel} revel=$CLOUD_REGISTRY/${app}:latest")
						sh("kubectl set image deployment/${deployServiceLabel} revel=$CLOUD_REGISTRY/${app}")

						// Check rollout status of deployment until success
						sh("kubectl rollout status deploy/${deployServiceLabel}")
						
						// Switch to Updated Revel Service
						sh("LOAD_BALANCER=$STAGING_URL_IP \
							envsubst < ./ops/docker/${dir}/service.yaml | kubectl patch \
							-p '{\"spec\":{\"selector\": {\"app\": \"${deployServiceLabel}-${env}\"}}}' -f -")

						// Switch back labels of https pod
						sh("kubectl label pod https-${app} app=${deployServiceLabel}-${env} --overwrite")
					}
				}
			}
		}
		stage('Production Deployment') {
			when {
				not {
					anyOf {
						equals expected: 'Error', actual: getSwitchCode('production');
						equals expected: 'Error', actual: getDeploymentCode('production')
					}
				}
			}
			environment {
				KUBERNETES_IP         = credentials('PROD_KUBERNETES_IP')
				PRODUCTION_URL        = credentials('ADMIN_PROD_URL')
				PRODUCTION_URL_IP     = credentials('ADMIN_PROD_URL_IP')
			}
			steps {
				script {
					withKubeConfig(credentialsId: 'kube_prod_user_pass', serverUrl: "https://$KUBERNETES_IP") {
						sh("kubectl get pods")
						/**
						 *
						 * Setup for Blue/Green Deployment
						 *
						 */
						echo "Blue/Green Deployment"

						/**
						 *
						 * Production Deployment
						 *
						 */
						 def env                       = 'prod'
						 def dir                       = 'production/revel'
						 def switchCode                = getSwitchCode('production')
						 def deploymentCode            = getDeploymentCode('production')
						 def switchToServiceLabel      = "${app}${switchCode}"
						 def deployServiceLabel        = "${app}${deploymentCode}"

						 // Switch Traffic to Another Revel Service
						sh("LOAD_BALANCER=$PRODUCTION_URL_IP \
							envsubst < ./ops/docker/${dir}/service.yaml | kubectl patch \
							-p '{\"spec\":{\"selector\": {\"app\": \"${switchToServiceLabel}-${env}\"}}}' -f -")

						// Switch labels of https pod
						sh("kubectl label pod https-${app} app=${switchToServiceLabel}-${env} --overwrite")

						// Revel Deployment
						sh("kubectl set image deployment/${deployServiceLabel} revel=$CLOUD_REGISTRY/${app}:latest")
						sh("kubectl set image deployment/${deployServiceLabel} revel=$CLOUD_REGISTRY/${app}")

						// Check rollout status of deployment until success
						sh("kubectl rollout status deploy/${deployServiceLabel}")
						
						// Switch to Updated Revel Service
						sh("LOAD_BALANCER=$PRODUCTION_URL_IP \
							envsubst < ./ops/docker/${dir}/service.yaml | kubectl patch \
							-p '{\"spec\":{\"selector\": {\"app\": \"${deployServiceLabel}-${env}\"}}}' -f -")

						// Switch back labels of https pod
						sh("kubectl label pod https-${app} app=${deployServiceLabel}-${env} --overwrite")
					}
				}
			}	
		}
	} // stages end	
} // pipeline end
