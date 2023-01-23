from faker_generator import FakerGenerator

f = FakerGenerator(providers=[
    "address", "bank", "barcode", "color", "company", "credit_card",
    "currency", "file", "geo", "internet", "isbn", "job", "lorem", "person",
    "phone_number", "ssn", "user_agent"
])

print(f.generate())