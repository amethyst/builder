pipeline {
    agent {
	label 'docker'
    }
    stage("build") {
	steps {
	    sh './scripts/build.sh'
	}
    }
}
