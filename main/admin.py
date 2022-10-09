from django.contrib import admin
from main.models import *

# Register your models here.
admin.site.register(Category)
admin.site.register(Doc)
admin.site.register(Ustaz)
admin.site.register(Info)

class RamizderAdmin(admin.ModelAdmin):
    pass

admin.site.register(Ramizder, RamizderAdmin)

class NewsAdmin(admin.ModelAdmin):
    pass

admin.site.register(News, NewsAdmin)

class CommentAdmin(admin.ModelAdmin):
    pass

admin.site.register(Comment, CommentAdmin)