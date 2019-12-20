from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.views import View
from django.urls.base import reverse_lazy

from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.edit import CreateView, UpdateView, DeleteView

from .models import Question
from .forms import QuestionForm


def get_menu( request ):
    s = render( request, '_menu.html')
    return s.content.decode()

# Create your views here.

class QuestionsListView(View):  #/questions/questions
    def get(self, request) :
        data = Question.objects.all()
        detCntx = { 'qst_list': data, 'title': 'Lista de questões' }
        main_area = render( request, '_question_table.html', detCntx )
        shellCntx = { 'menu': get_menu( request ), 'main_area': main_area.content.decode(), 'operations': '' }
        return render( request, 'shell.html', shellCntx )

class QuestionsRootView(View): #/questions/
    def get(self, request) :
        s = render( request, '_menu.html')
        cntx = { 'menu': s.content.decode(), 'main_area': '', 'operations': '' }
        return render( request, 'shell.html', cntx )


class QuestionDetailView(View): #/questions/questions/qid/<pk_id>
    def get( self, request, pk_from_url ):
        #todo montar contexto e template (main_area e menu são calculados sempre)
        obj = Question.objects.get(pk=pk_from_url)
        cntx = { 'qst': obj }
        table = render( request, '_question_detail.html', cntx )
        cntx = { 'main_area' : table.content.decode() }
        return render( request, 'shell.html', cntx )


class QuestionCreate(LoginRequiredMixin,CreateView):
    model = Question
    fields = '__all__'  #todo tentar filtrar com algo parecido a fields = ['name']
    success_url = reverse_lazy('questions:questions')

class QuestionUpdate(LoginRequiredMixin, UpdateView):
    model = Question
    fields = '__all__'
    success_url = reverse_lazy('questions:questions')

class QuestionDelete(LoginRequiredMixin, DeleteView):
    model = Question
    fields = '__all__'
    success_url = reverse_lazy('questions:questions')

'''
class QuestionCreate(LoginRequiredMixin, View):
    template = 'question_form.html'
    success_url = reverse_lazy('/questions/') #success_url = reverse_lazy('questions:questions')
    def get(self, request) :
        form = QuestionForm()
        ctx = { 'form': form }
        return render(request, self.template, ctx)

    def post(self, request) :
        form = QuestionForm(request.POST)
        if not form.is_valid() :
            ctx = {'form' : form}
            return render(request, self.template, ctx)

        make = form.save()
        return redirect(self.success_url)
'''



'''

def index( request ):  #Responde para a url / == index
    data = Question.objects.all()
    cntx = { 'qst_list': data }
    #cntx  = { "qst" : Question.objects.order_by('-pub_date')[:5] }
    #output = ', '.join([q.question_text for q in latest_question_list])
    return render( request, 'questions/roger_test.html', cntx )
    #return HttpResponse(output)

def login( request ): #Responde ao login
    out = "Pedido da url raiz!!!!"
    return HttpResponse( out )



'''