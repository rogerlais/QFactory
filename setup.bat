@echo off
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

:DATABASE_NEW
if exist %predir%\DB\QFactoryDB\db.sqlite3 goto :DATABASE_OLD
git clone https://github.com/rogerlais/QFactoryDB.git DB\QFactoryDB
goto :UPDATE_DB

:DATABASE_OLD
@echo "Atualizando a base de dados com repo remoto..."
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
pip install -r requirements.txt 
if %ERRORLEVEL% neq 0 goto :HAS_ERROR
@echo "Requisitos atualizados com sucesso"

:REBUILD_STATICS
call rebuild_static.bat
if %ERRORLEVEL% neq 0 goto :HAS_ERROR

:RUN_SERVER
python manage.py runserver

goto :END

:HAS_ERROR
cd %predir%
echo [91mProblemas com a preparacao do ambiente[0m
pause


:END
call %predir%\djenv\scripts\deactivate.bat
@echo "Processo finalizado"