from django.forms import ModelForm
from questions.models import Question

# Create the form class.
class QuestionForm(ModelForm):
    class Meta:
        model = Question
        fields = '__all__'

