pipeline {
   agent any
    options {
      buildDiscarder(logRotator(numToKeepStr:'30'))
      timeout(time: 10, unit: 'MINUTES')
      timestamps()
      skipDefaultCheckout true
    }   
    environment{
        EXPECTED_RESULT = 'Running'
    }
   stages {
      stage('Pull code from Repo') {
         steps {
            echo 'Pull the ps1 code from the Repo'
            cleanWs()
            git credentialsId: 'github-pat', url: 'https://github.com/miken-hg5/JMeter'             
         }
      }
      stage('Execute JMeter') {
          steps {
            echo 'JMeter command line syntax'
            bat 'set OUT=jmeter.save.saveservice.output_format'
            bat 'set JMX=DVLA_Lookup.jmx'
            bat 'set JTL=DVLA_Lookup.report.jtl'
            bat 'C:\\apache-jmeter-5.4\\bin\\jmeter -n -t DVLA_Lookup.jmx -l DVLA_Lookup.report.jtl'            
            //bat 'jmeter -n –t ${WORKSPACE}\\ -l testresults.jtl'
      }
      }
      stage('Generate Report output') {
          steps {
            echo 'Generate Report'
            bat 'C:\\apache-jmeter-5.4\\bin\\jmeter -g  DVLA_Lookup.report.jtl -o  HTML'
      }
      }      
   }
    post 
    {
        success 
        {
            //archiveArtifacts artifacts: "HTML\\index.html", onlyIfSuccessful: true
            publishHTML target: [
              allowMissing: false,
              alwaysLinkToLastBuild: false,
              keepAll: true,
              reportDir: 'HTML',
              reportFiles: 'index.html',
              reportName: 'JMeter_Test_Report'
            ]            
            powershell('write-host "Archived"')
        }
    }      
}
