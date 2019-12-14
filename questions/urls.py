"""questions URL Configuration

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
from django.urls import path
from . import views

# Reuso do login nativo do django
from django.contrib.auth.views import LoginView
from django.conf.urls import url
from django.contrib import admin
from django.urls import path, include # new

# todo inserir as urls a serem tratadas aqui
urlpatterns = [
    path('questions/', views.index, name='index'),  # Resolve pelo metodo index de questions.apps
    #path('', views.login, name='login'),  # !Resolve pelo metodo index de questions.apps
    #url(r'^login/$', LoginView.as_view(template_name='admin/login.html',extra_context={'login': 'QFactory Login Header', })),
]
