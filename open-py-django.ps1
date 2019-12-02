<#
References: https://docs.djangoproject.com/pt-br/2.2/howto/windows/
#>


<#
1 - como administrador instalar o viertualnenv
	pip install virtualenv
2 - como user criar um virtual env em pasta de desenvolvimento. A dica é ter um ambiente para cada projeto separadamente
	<swd>\python\<my-project-name>\<my-project-env>
3 - alternar para o ambiente de desenvolvimento e instalar o django nele ou iniciar o vscode e executar o activate.ps1
	nota: O rootfolder para o vscode deve estar um nível acima do ambiente!!!!
	pip install django
4 - criar o app a partir do template do framwaork apontando para a pasta atual(rootfolder do projeto)
	django-admin startproject <nome-app> .
5 - Abrir o script rais managae.py e depura-lo

#>

#!Obrigatorio no inicio
param([switch]$NoServer=$true)


function Start-Env( $NoServer ) {
	$name_env = "BkendDjango"
	$name_prj = "BkendApp"

	Write-Host "Preparando ambiente Python-Django: $name_env"
	Write-Host "Iniciando projeto $name_prj"

	##Verificação do virtualenvwrappere-win e suas dependencias
	$process = start-process "pip"  -ArgumentList "show virtualenvwrapper-win" -PassThru -Wait -NoNewWindow
	if( $process.ExitCode -eq 0 ) {
		Write-Host "show virtualenvwrapper-win - OK" -ForegroundColor $checkedColor
	} else {
		$process = start-process "pip" -ArgumentList "install virtualenvwrapper-win" -PassThru -Wait -NoNewWindow
		if( $process.ExitCode -ne 0 ) {
			Write-Error "Erro instalando virtualenvwrapper-win"
			return $false
		} else {
			Write-Host "Virtualenvwrapper-win instalado com sucesso!!!" -ForegroundColor $alteredColor
		}
	}

	##Verificação do ambiente anterior
	$envPath = "$env:USERPROFILE\Envs\$name_env"
	if( -not( Test-Path $envPath ) ) {
		$process = start-process "mkvirtualenv" -ArgumentList $name_env -PassThru -Wait -NoNewWindow
		if( $process.ExitCode -ne 0 ) {
			Write-Error "Erro criando ambiente $name_env"
			return $false
		} else {
			Write-Host "Ambiente $name_env criado com sucesso!!!" -ForegroundColor $alteredColor
		}
	} else {
		Write-Host "Tentando usar ambiente pre-existente em: $env:USERPROFILE\Envs\$name_env"
	}

	#alteração de ambiente ativo com script PS fornecido pelo próprio django
	& $envPath\Scripts\activate.ps1
	<#
	$process = start-process "workon" -ArgumentList $name_env -PassThru -Wait -NoNewWindow
	if( $process.ExitCode -ne 0 ) {
		Write-Error "Erro alternando para ambiente $name_env"
		return $false 
	}
	#>

	##Verificação da instalação do Django já no ambiente virtual criado e ativo acima
	$process = start-process "pip" -ArgumentList "show django" -PassThru -Wait -NoNewWindow
	if( $process.ExitCode -ne 0 ) {
		$process = start-process "pip" -ArgumentList "install django" -PassThru -Wait -NoNewWindow
		if( $process.ExitCode -ne 0 ) {
			Write-Error "Erro instalando Django"
			return $false
		} else {
			Write-Host "Django instalado com sucesso!!!" -ForegroundColor $alteredColor
		}
	} else {
		Write-Host "Django pre-existente - OK" -ForegroundColor $checkedColor
	}

	#Verificação dos fontes da solução
	$homePrj = Join-Path -Path $(Get-Location) -ChildPath $name_prj
	if( -not ( Test-Path -path $homePrj ) ) {
		$process = start-process "django-admin" -ArgumentList "startproject $name_prj" -PassThru -Wait -NoNewWindow
		Write-Host "Pasta do projeto criada: $homePrj" -ForegroundColor $alteredColor
	} else {
		Write-Host "Pasta do projeto encontrada a ser ativada" -ForegroundColor $checkedColor
	}

	Set-Location -Path $homePrj
	New-Item -Path $(Get-Location) -Name $name_prj -ItemType Directory -ErrorAction SilentlyContinue
	New-Item -Path "$(Get-Location)\$name_prj" -Name "src" -ItemType Directory -ErrorAction SilentlyContinue
	New-Item -Path "$(Get-Location)\$name_prj\src" -Name "model" -ItemType Directory -ErrorAction SilentlyContinue
	New-Item -Path "$(Get-Location)\$name_prj\src" -Name "view" -ItemType Directory -ErrorAction SilentlyContinue
	New-Item -Path "$(Get-Location)\$name_prj\src" -Name "templates" -ItemType Directory -ErrorAction SilentlyContinue
	Write-Host "Coding for $homePrj\" -ForegroundColor $checkedColor

	#Inicia o app-server da app
	if( $NoServer ) {
		$manager = ".\manage.py"
		$process = start-process "python" -ArgumentList "$manager runserver" -PassThru 
	}
	Set-Location -Path $(Get-Item -Path $homePrj).Parent.Parent.FullName
	return $true
}

Clear-Host
$script:alteredColor = [System.ConsoleColor]::DarkYellow
$script:checkedColor = [System.ConsoleColor]::DarkBlue
if( start-env( $NoServer) ) {
	Write-Host "Ambiente configurado com suceso!!!" -ForegroundColor $checkedColor
} else {
	Write-Error "Falha preparando o ambiente"
}