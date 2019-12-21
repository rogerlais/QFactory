call .\djenv\scripts\activate.bat
python manage.py collectstatic --no-input
if %ERRORLEVEL% neq 0 goto :HAS_ERROR
@echo "Recursos estaticos atualizados com sucesso"
goto :END

:HAS_ERROR
echo "Problema ocorrido"

:END
pause