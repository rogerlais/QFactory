from django.shortcuts import render
from django.http import HttpResponse
from .models import Question


# Create your views here.
def index( request ):  #Responde para a url / == index
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    output = ', '.join([q.question_text for q in latest_question_list])    
    return HttpResponse(output)

def login( request ): #Responde ao login
    out = "Pedido da url raiz!!!!"
    return HttpResponse( out )