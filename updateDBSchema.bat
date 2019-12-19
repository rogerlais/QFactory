call .\djenv\Scripts\Activate.bat

python manage.py makemigrations

pause "Deseja efetivar as migracoes?(ctrl+c = cancelar)"

python manage.py migrate

pause