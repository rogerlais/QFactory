from django.db import models
from django.core import signing
from django.utils import timezone
from django.utils.crypto import get_random_string
from django.core.validators import MaxLengthValidator

import datetime

import uuid

# Create your models here.
class Matter(models.Model):
    name = models.CharField(max_length=40, validators=[MaxLengthValidator(40)], verbose_name="Nome disciplina",
                            default="Digite o nome da disciplina",
                            help_text="Nome da disciplina(limite 40 caracteres)")


class Question(models.Model):
    question_text = models.CharField(max_length=1024, validators=[MaxLengthValidator(250)], verbose_name="Enunciado",
                                     default="Digite aqui o texto da questão",
                                     help_text="As questões são limitadas a 1024 caracteres")
    pub_date = models.DateTimeField(verbose_name='Publicado em', auto_now=False,
                                    null=False, help_text="Data de edição da questão")



class Choice(models.Model):
    RESP = 'Resp:'
    ALTERNATIVE_A = 'A'
    ALTERNATIVE_B = 'B'
    ALTERNATIVE_C = 'C'
    ALTERNATIVE_D = 'D'
    ALTERNATIVE_E = 'E'
    ALTERNATIVE_F = 'F'

    ALTERNATIVE_LABELS_CHOICES = (
        ('', 'Escolha rótulo da alternativa'),
        (str(ALTERNATIVE_A), ALTERNATIVE_A),
        (str(ALTERNATIVE_B), ALTERNATIVE_B),
        (str(ALTERNATIVE_C), ALTERNATIVE_C),
        (str(ALTERNATIVE_D), ALTERNATIVE_D),
        (str(ALTERNATIVE_E), ALTERNATIVE_E),
        (str(ALTERNATIVE_F), ALTERNATIVE_F),
        (str(RESP), RESP)
    )

    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(
        max_length=200, verbose_name='Alternativa',
        null=False, help_text="Informe o conteúdo da alternativa")
    choice_label = models.CharField(choices=ALTERNATIVE_LABELS_CHOICES, max_length=5, blank=False)
    is_correct = models.BooleanField(verbose_name="Correta", default=False)

    def __str__(self):  #Representação em str da alternativa usada na exibição
        if self.is_correct:
            ret = '[X]'
        else:
            ret = '[ ]'
        return ret + self.choice_label

class Professor(models.Model):
    
    pass 