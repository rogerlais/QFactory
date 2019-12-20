cls
@ECHO off
@ECHO "Certifique-se que o server esta off antes de continuar"

pause "Deseja continuar?(ctrl-c = cancela)"

cd .\DB
git pull --force
if %ERRORLEVEL% neq 0 GOTO :LASCOU

REM pause "Operacao de pull foi realizada?(ctrl-c = cancela copia)"

:UPDATED
cd ..
cd
copy .\DB\QFactoryDB\db.sqlite3 /y
if %ERRORLEVEL% neq 0 GOTO :LASCOU
@ECHO "Base atualizada com sucesso"
pause

exit

:LASCOU
pause "Ocorreu um erro"
