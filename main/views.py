import datetime
from math import ceil
from django.shortcuts import render
from main.models import *
from django.http import JsonResponse
from django.shortcuts import redirect
from django.contrib.auth import authenticate
from django.contrib.auth.models import User
from django.db.models import Q


# Create your views here.

def indexHandler(request):
    categories = Category.objects.all()
    news = News.objects.filter(status=0)
    info = Info.objects.all()[:1]
    page = "gl"
    return render(request, 'index.html', {
        'categories': categories,
        'news': news,
        'info': info,
        'page': page,
    })


def aboutHandler(request):
    categories = Category.objects.all()
    news = News.objects.filter(status=0)
    info = Info.objects.all()[:1]
    page = 'about'

    return render(request, 'about.html', {
        'categories': categories,
        'news': news,
        'info': info,
        'page': page,
    })

def newsItemHandler(request, news_id):
    categories = Category.objects.all()
    news = News.objects.filter(status=0)
    info = Info.objects.all()[:1]
    snew = News.objects.get(id=int(news_id))
    page = "new"

    return render(request, 'single.html', {
        'categories': categories,
        'news': news,
        'info': info,
        'snew': snew,
        'page': page,

    })



def ramizderHandler(request):
    categories = Category.objects.all()
    news = News.objects.filter(status=0)
    info = Info.objects.all()[:1]
    ramizder = Ramizder.objects.all()
    page = "ramiz"

    return render(request, 'ramiz.html', {
        'categories': categories,
        'news': news,
        'info': info,
        'ramizder': ramizder,
        'page': page,
    })

def ramizder_singleHandler(request, ramiz_id):
    categories = Category.objects.all()
    news = News.objects.filter(status=0)
    info = Info.objects.all()[:1]
    ramiz = Ramizder.objects.get(id=int(ramiz_id))
    page = "ramiz"

    return render(request, 'ramiz_single.html', {
        'categories': categories,
        'news': news,
        'info': info,
        'ramiz': ramiz,
        'page': page,
    })

def contactHandler(request):
    if request.method == 'POST':
        r = Comment()
        name = request.POST.get('name', '')
        email = request.POST.get('email', '')
        subject = request.POST.get('subject', '')
        message = request.POST.get('text', '')

        r.name = name
        r.email = email
        r.subject = subject
        r.message = message
        r.save()

    categories = Category.objects.all()
    news = News.objects.filter(status=0)
    info = Info.objects.all()[:1]
    page = "contact"
    return render(request, 'contact.html', {
        'categories': categories,
        'news': news,
        'info': info,
        'page': page,
    })


def catHandler(request, cat_id):
    categories = Category.objects.all()
    news = News.objects.filter(status=0)
    info = Info.objects.all()[:1]
    active_cat = Category.objects.get(id=cat_id)
    documents = Doc.objects.filter(category__id=cat_id)

    return render(request, 'cat.html', {
        'categories': categories,
        'news': news,
        'info': info,
        'active_cat': active_cat,
        'documents': documents,

    })

def docHandler(request, doc_id):
    categories = Category.objects.all()
    news = News.objects.filter(status=0)
    info = Info.objects.all()[:1]
    active_doc = Doc.objects.get(id=doc_id)

    return render(request, 'doc.html', {
        'categories': categories,
        'news': news,
        'info': info,
        'active_doc': active_doc,

    })


def ustazHandler(request):
    ustazdar = Ustaz.objects.filter(status=0)
    categories = Category.objects.all()
    news = News.objects.filter(status=0)
    info = Info.objects.all()[:1]
    info = Info.objects.all()[:1]
    page = "ustaz"

    return render(request, 'ustaz.html', {
        'ustazdar': ustazdar,
        'categories': categories,
        'news': news,
        'info': info,
        'page': page,
    })