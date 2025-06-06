from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework.authtoken.views import obtain_auth_token
from . import views

router = DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'items', views.ItemViewSet)
router.register(r'contacts', views.ContactViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('auth/token/', obtain_auth_token, name='api_token_auth'),
    path('auth/register/', views.register, name='api_register'),
    path('auth/login/', views.login, name='api_login'),
    path('users/me/', views.get_current_user, name='api_current_user'),
] 