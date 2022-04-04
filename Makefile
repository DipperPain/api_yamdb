MANAGE_PY=cd api_yamdb && ../venv/bin/python3 manage.py
PROJECT_NAME=api_yamdb

runserver::
	$(MANAGE_PY) runserver --insecure


collectstatic::
	$(MANAGE_PY) collectstatic

makemigrations::
	$(MANAGE_PY) makemigrations

migrate:: makemigrations
	$(MANAGE_PY) migrate 

lint:: format
	./venv/bin/flake8  api_yamdb

format::
	./venv/bin/black --line-length 79 $(PROJECT_NAME)
	./venv/bin/isort --profile django $(PROJECT_NAME)


test::
	./venv/bin/pytest

dj-test::
	cd api_yamdb && \
	../venv/bin/coverage run --source='posts,users,about' --omit='*/*/test_*' manage.py test -v 2 \
	&& ../venv/bin/coverage report --skip-covered \
	&& ../venv/bin/coverage html

createsuperuser:: 
	$(MANAGE_PY) createsuperuser
