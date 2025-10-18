pipeline {
  agent any
  options { timestamps(); ansiColor('xterm') }

  environment {
    HEADLESS = '1'          // si tu test web lo usa (opcional)
    // PERSIST = '0'        // si implementas el flag en mock_api.py para no escribir db.json en CI
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Python venv + deps') {
      steps {
        bat '''
        py -m venv .venv
        call .venv\\Scripts\\activate
        python -m pip install -U pip
        pip install -U robotframework robotframework-seleniumlibrary selenium
        pip install -U robotframework-requests robotframework-databaselibrary
        pip install -U flask
        '''
      }
    }

    stage('Start mock API (Flask)') {
      steps {
        powershell '''
        . .\\.venv\\Scripts\\Activate.ps1

        # Arranca mock_api.py en background y guarda el PID
        $p = Start-Process -FilePath python -ArgumentList "mock_api.py" -PassThru -WindowStyle Hidden
        Set-Content -Path mock.pid -Value $p.Id

        # Espera a que el puerto 5000 responda (máx 30s)
        $max = 30
        for ($i=0; $i -lt $max; $i++) {
          if (Test-NetConnection -ComputerName 127.0.0.1 -Port 5000 -InformationLevel Quiet) { break }
          Start-Sleep -Seconds 1
        }
        if (-not (Test-NetConnection -ComputerName 127.0.0.1 -Port 5000 -InformationLevel Quiet)) {
          Write-Error "Mock API no levantó en 5000"
        }
        '''
      }
    }

    stage('Run tests') {
      steps {
        bat '''
        call .venv\\Scripts\\activate
        robot -d results -v BASE:http://127.0.0.1:5000 tests
        '''
      }
    }
  }

  post {
    always {
      // Apaga el mock aunque fallen tests
      powershell '''
      if (Test-Path mock.pid) {
        $pid = Get-Content mock.pid
        try { Stop-Process -Id $pid -Force } catch { }
      }
      '''
      archiveArtifacts artifacts: 'results/**/*', fingerprint: true
      robot outputPath: 'results', outputFileName: 'output.xml'
    }
  }
}
