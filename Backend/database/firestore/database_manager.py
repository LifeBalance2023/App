import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore_async

cred = credentials.Certificate("./database/firestore/credentials.json")

# Initialize the Firebase Admin SDK
firebase_admin.initialize_app(cred)


class DatabaseManager:
    def __init__(self):
        self.db = firestore_async.client()

        if self.db is None:
            raise RuntimeError("Error creating Firestore client")

    def get_firestore_client(self):
        return self.db
