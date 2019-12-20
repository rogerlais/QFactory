rem @echo off
set predir=%cd%
@echo %predir%
@echo "Preparando o ambiente Python(Windows)..."
if exist %predir%\djenv\scripts\activate.bat goto :DATABASE_NEW
mkdir djenv
cd djenv
virtualenv .
@echo %ERRORLEVEL%
if %ERRORLEVEL% neq 0 goto :HAS_ERROR
@echo "Ambiente criado com sucesso"
@echo "parada venv"
pause 

:DATABASE_NEW
if exist %predir%\DB\QFactoryDB\db.sqlite3 goto :DATABASE_OLD
goto :ACTIVE_ENV

:DATABASE_OLD
cd %predir%\DB\QFactoryDB
git pull --force
if %ERRORLEVEL% neq 0 (
    cd %predir%
    goto :HAS_ERROR
) else (
    cd %predir%
)

:UPDATE_DB
copy %predir%\DB\QFactoryDB\db.sqlite3 %predir%\db.sqlite3 /y
if %ERRORLEVEL% neq 0 goto :HAS_ERROR
@echo "Base de dados atualizado com sucesso"


:ACTIVE_ENV
cd %predir%
call %predir%\djenv\scripts\activate.bat
if %ERRORLEVEL% neq 0 goto :HAS_ERROR
@echo "Ambiente ativado com sucesso, instalando depedencias"

:DEPENDENCIES
pause
pip install -r requirements.txt 
if %ERRORLEVEL% neq 0 goto :HAS_ERROR
@echo "Requisitos atualizados com sucesso"


goto :END

:HAS_ERROR
cd %predir%
echo [91mProblemas com a preparacao do ambiente[0m
pause


:END
call %predir%\djenv\scripts\deactivate.bat
@echo "Processo finalizado"