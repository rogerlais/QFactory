

call .\DjEnv\Scripts\Actibat.bat

python manage.py makemigrations

pause "Deseja efetivar as migrações?(ctrl+c = cancelar)"

python manage.py migrate

pause