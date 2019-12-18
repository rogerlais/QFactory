"""qfapp URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include #inserido include para importar toda subarvore de "questions"
from django.views.generic.base import TemplateView
from django.conf.urls.static import static
from django.conf import settings

'''
operação de login baseados a partir de: 
https://wsvincent.com/django-user-authentication-tutorial-login-and-logout/
'''

urlpatterns = [
    path('admin/', admin.site.urls),
    path('login/', include('django.contrib.auth.urls')), #* roger - reuso da app para login
    path('questions/', include('questions.urls')), #* roger - insere tratamento do app questions
    path('', TemplateView.as_view(template_name='home.html'), name='home'), #* roger - Carga da home page
] # modo simplesw remove isso + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
