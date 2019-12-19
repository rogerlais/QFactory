from django.apps import AppConfig

from django.conf import settings

class FavIconConfig(AppConfig):  #Método registrado em qfapp em settings.pv:INSTALLED_APPS
    name = 'favicon'
    verbose_name = 'Favorite Icon'


FAVICON_PATH = getattr(settings, 'FAVICON_PATH', '%sfavicon.ico' % settings.STATIC_URL)