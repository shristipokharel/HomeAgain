from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils import timezone

# Create your models here.

class User(AbstractUser):
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    # Add related_name to avoid conflicts
    groups = models.ManyToManyField(
        'auth.Group',
        related_name='custom_user_set',
        blank=True,
        help_text='The groups this user belongs to.',
        verbose_name='groups',
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        related_name='custom_user_set',
        blank=True,
        help_text='Specific permissions for this user.',
        verbose_name='user permissions',
    )

class Item(models.Model):
    ITEM_TYPES = [
        ('LOST', 'Lost Item'),
        ('FOUND', 'Found Item'),
    ]
    
    STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('CLAIMED', 'Claimed'),
        ('RESOLVED', 'Resolved'),
    ]

    title = models.CharField(max_length=200)
    description = models.TextField()
    item_type = models.CharField(max_length=5, choices=ITEM_TYPES)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='PENDING')
    location = models.CharField(max_length=200)
    date_reported = models.DateTimeField(default=timezone.now)
    image = models.ImageField(upload_to='items/', null=True, blank=True)
    reporter = models.ForeignKey(User, on_delete=models.CASCADE, related_name='reported_items')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.title} ({self.get_item_type_display()})"

class Contact(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()
    subject = models.CharField(max_length=200)
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)

    def __str__(self):
        return f"Contact from {self.name} - {self.subject}"
