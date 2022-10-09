# Generated by Django 3.0.11 on 2022-10-06 16:48

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(blank=True, max_length=200)),
                ('level', models.IntegerField(blank=True, default=0)),
                ('parent', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='main.Category')),
            ],
        ),
        migrations.CreateModel(
            name='Doc',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(blank=True, max_length=200)),
                ('level', models.IntegerField(blank=True, default=0)),
                ('mini_description', models.TextField(blank=True)),
                ('date', models.DateField(blank=True, null=True)),
                ('doc', models.FileField(blank=True, upload_to='file')),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main.Category')),
            ],
        ),
    ]