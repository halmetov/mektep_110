from django.db import models
import datetime

# Create your models here.

class Category(models.Model):
    title = models.CharField(max_length=200, blank=True)
    parent = models.ForeignKey("Category", on_delete=models.CASCADE, null=True, blank=True)
    level = models.IntegerField(blank=True, default=0)

    def __str__(self):
        result_title = self.title
        parent_model = self.parent
        while parent_model:
            result_title = parent_model.title + " ---> " + result_title
            parent_model = parent_model.parent
        return result_title


class Doc(models.Model):
    title = models.CharField(max_length=200, blank=True)
    category = models.ForeignKey("Category", on_delete=models.CASCADE)
    level = models.IntegerField(blank=True, default=0)
    mini_description = models.TextField(blank=True)
    date = models.DateField(blank=True,null=True)
    doc = models.FileField(upload_to='file', blank=True)

    def __str__(self):
        return f'{self.category} --> {self.title} '


class News(models.Model):
    title = models.CharField(max_length=300, blank=True)
    main_desc = models.TextField(blank=True)
    description = models.TextField(blank=True)
    date = models.DateTimeField(blank=True)
    logo = models.ImageField(upload_to='upload', blank=True)
    status = models.IntegerField(default=0, blank=True)
    rating = models.IntegerField(default=0, blank=True)

    def __str__(self):
        return self.title

class Ramizder(models.Model):
    title = models.CharField(max_length=300, blank=True)
    main_desc = models.TextField(blank=True)
    avtor = models.TextField(blank=True)
    description = models.TextField(blank=True)
    logo = models.ImageField(upload_to='upload', blank=True)

    def __str__(self):
        return self.title


class Comment(models.Model):
    name = models.CharField(max_length=300, blank=True)
    email = models.CharField(max_length=300, default='', blank=True)
    subject = models.CharField(max_length=300, blank=True)
    message = models.TextField(blank=True)

    def __str__(self):
        return self.subject

class Ustaz(models.Model):
    first_name = models.CharField(max_length=300, blank=True)
    last_name = models.CharField(max_length=300, blank=True)
    logo = models.ImageField(upload_to='upload', blank=True)
    description = models.TextField(blank=True)
    status = models.IntegerField(default=0, blank=True)
    rating = models.IntegerField(default=0, blank=True)

    def __str__(self):
        return f'{self.last_name}  {self.first_name}'


class Info(models.Model):
    phone = models.CharField(max_length=200,blank=True)
    logotip = models.ImageField(upload_to='upload', blank=True)
    email = models.CharField(max_length=300, blank=True)
    whatsapp = models.CharField(max_length=300, blank=True)

    def __str__(self):
        return self.phone