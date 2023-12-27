from google.cloud.firestore_v1 import DocumentSnapshot
from pydantic import BaseModel
from typing import Type, TypeVar

T = TypeVar("T", bound=BaseModel)


class FirestoreTranslator:
    @staticmethod
    def document_to_object(doc: DocumentSnapshot, obj_model: Type[T]) -> T:
        obj_data = doc.to_dict()
        obj_data['id'] = doc.id

        obj_data = {key: value for key, value in obj_data.items()}

        return obj_model(**obj_data)

    @staticmethod
    def update_base_object(base_doc: DocumentSnapshot, obj_model: Type[T], update_model: T):
        base_model = FirestoreTranslator.document_to_object(base_doc, obj_model)
        for field, value in update_model.dict().items():
            if value is not None:
                setattr(base_model, field, value)

        return base_model
