up-entrypoint:
	python backend/app/manage.py migrate && \
	python backend/app/manage.py runserver 0.0.0.0:8000

local-build:
	docker compose -f docker/local-deploy/docker-compose.yaml --env-file .env -p pet_django_dev build --no-cache

local-up:
	docker compose -f docker/local-deploy/docker-compose.yaml --env-file .env -p pet_django_dev up --remove-orphans --force-recreate -d

local-down:
	docker compose -f docker/local-deploy/docker-compose.yaml --env-file .env -p pet_django_dev down

local-test:
	docker compose -f docker/local-deploy/docker-compose.yaml --env-file .env -p pet_django_dev up --remove-orphans --force-recreate -d
	docker compose --env-file .env exec backend bash -c "pytest -x"

healthcheck:
	echo "Checking health..."
	curl --request GET --url http://127.0.0.1:${BACKEND_PORT_EXTERNAL}/
	echo "OK"
