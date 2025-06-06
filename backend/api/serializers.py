from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import Item, Contact

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'first_name', 'last_name', 'is_active', 'created_at', 'updated_at')
        read_only_fields = ('created_at', 'updated_at')
        extra_kwargs = {
            'password': {'write_only': True}
        }

    def create(self, validated_data):
        password = validated_data.pop('password', None)
        instance = self.Meta.model(**validated_data)
        if password is not None:
            instance.set_password(password)
        instance.save()
        return instance

class ItemSerializer(serializers.ModelSerializer):
    reporter = UserSerializer(read_only=True)
    
    class Meta:
        model = Item
        fields = ('id', 'title', 'description', 'item_type', 'status', 'location', 
                 'date_reported', 'image', 'reporter', 'created_at', 'updated_at')
        read_only_fields = ('created_at', 'updated_at')

class ContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contact
        fields = ('id', 'name', 'email', 'subject', 'message', 'created_at', 'is_read')
        read_only_fields = ('created_at', 'is_read') 