# Backend

* Dockerfile
    1. Go to Backend path
    2. Fill `FIRESTORE_CREDENTIALS` in `.env` by your path to firestore credentials file
    3. Build docker image \
        ```docker build -t life_balance .```
    4. Run docker image \
        ```docker run -p xx:80 life_balance``` \
        change `xx` to another port number

* Virtual environment 
    1. Go to Backend path
    2. Fill `FIRESTORE_CREDENTIALS` in `.env` by your path to firestore credentials file
    3. Create and active virtual environment \
        ```python3 -m venv venv``` \
        ```venv/bin/activate``` 
    4. Install requirements \
        ```pip install -r requirements.txt```
    5. Run application \
        ```uvicorn main:app --reload```