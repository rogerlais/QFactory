from django.shortcuts import render
from django.http import HttpResponse
from django.views import View

from .models import Question

# Create your views here.

class QuestionsListView(View):  #/questions/questions
    def get(self, request) :
        stuff = Question.objects.all()
        cntx = { 'qst_list': stuff }
        #cntx  = { "qst" : Question.objects.order_by('-pub_date')[:5] }
        return render( request, 'questions/roger_question_list.html', cntx )

class QuestionsRootView(View): #/questions/
    def get(self, request) :
        return render( request, 'home.html' )


class QuestionDetailView(View): #/questions/questions/qid/<pk_id>
    def get( self, request ):
        #todo montar contexto e template
        return render( request, 'questions/roger_detail_qid.html' )

def index( request ):  #Responde para a url / == index
    stuff = Question.objects.all()
    cntx = { 'qst_list': stuff }
    #cntx  = { "qst" : Question.objects.order_by('-pub_date')[:5] }
    #output = ', '.join([q.question_text for q in latest_question_list])
    return render( request, 'questions/roger_test.html', cntx )
    #return HttpResponse(output)

def login( request ): #Responde ao login
    out = "Pedido da url raiz!!!!"
    return HttpResponse( out )