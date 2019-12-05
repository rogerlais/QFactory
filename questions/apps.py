"""
autor: Roger

Class QuestionsConfig registra a aplicação no site pela app raiz qfapp

"""

from django.apps import AppConfig


class QuestionsConfig(AppConfig):  #Método registrado em qfapp em settings.pv:INSTALLED_APPS
    name = 'questions'
    verbose_name = 'Banco de questões'
