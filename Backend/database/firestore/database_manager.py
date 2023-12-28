import firebase_admin
from firebase_admin import credentials, firestore_async
from settings import SETTINGS


class DatabaseManager:
    db = None
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(DatabaseManager, cls).__new__(cls)
            cls._instance.db = None
        return cls._instance

    def init_db(self):
        if self.db is None:
            cred = credentials.Certificate(SETTINGS.credentials_path)
            firebase_admin.initialize_app(cred)

            self.db = firestore_async.client()
            if self.db is None:
                raise RuntimeError("Error creating Firestore client")

    def get_firestore_client(self):
        if self.db is None:
            self.init_db()
        return self.db


db_manager = DatabaseManager()
firestore_client = db_manager.get_firestore_client()
