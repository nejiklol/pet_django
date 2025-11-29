from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import (
    ItemListCreateView,
    ItemRetrieveUpdateDeleteView,
    HealthCheckView,
    ItemViewCustom
)

router = DefaultRouter()
router.register("custom_items", ItemViewCustom, basename="items")

urlpatterns = [
    path("general/check/", HealthCheckView.as_view()),

    path("items/", ItemListCreateView.as_view(), name="items-list-create"),
    path("items/<int:pk>/", ItemRetrieveUpdateDeleteView.as_view(), name="items-rud"),

]

urlpatterns += router.urls