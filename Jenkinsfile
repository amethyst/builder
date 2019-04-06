pipeline {
    agent {
	label 'docker'
    }
    stages {
	stage("build") {
	    steps {
		sh './scripts/build.sh'
	    }
	}
    }
}
