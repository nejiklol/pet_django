from rest_framework import generics, viewsets, status
from .models import Item
from .serializers import ItemSerializer
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.views import APIView

class HealthCheckView(APIView):
    async def get(self, request):
        return Response({"status": "ok"})

class ItemListCreateView(generics.ListCreateAPIView):
    queryset = Item.objects.all()
    serializer_class = ItemSerializer


class ItemRetrieveUpdateDeleteView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Item.objects.all()
    serializer_class = ItemSerializer


class ItemViewCustom(viewsets.ModelViewSet):
    queryset = Item.objects.all()
    serializer_class = ItemSerializer

    @action(detail=True, methods=["post"])
    def publish(self, request, pk=None):
        item = self.get_object()
        item.description = (item.description or "") + "\n[PUBLISHED]"
        item.save()
        return Response(ItemSerializer(item).data)

    @action(detail=False, methods=["delete"])
    def delete_all(self, request):
        count = Item.objects.count()
        Item.objects.all().delete()
        return Response({"deleted": count}, status=status.HTTP_200_OK)