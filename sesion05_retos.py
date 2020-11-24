from pymongo import MongoClient
import re
import os

password = os.environ["MONGODB_PASS"]
client = MongoClient(
    f"mongodb+srv://ivand890:{password}@clusterbedu.dj9lq.mongodb.net/test?authSource=admin&replicaSet=atlas-wa6ki3-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true"
)
db = client["sample_airbnb"]["listingsAndReviews"]
################ Reto 01 ###############

filter = {"house_rules": re.compile(r"(?i)no parties")}
result = db.count_documents(filter)
print(f"Propiedades que no permiten fiestas: {result}")

################
filter = {"house_rules": re.compile(r"(?i)pets allowed")}
result = db.count_documents(filter)
print(f"Propiedades que permiten mascotas: {result}")

################
filter = {"house_rules": re.compile(r"(?i)no smoking")}
result = db.count_documents(filter)
print(f"Propiedades que no permiten fumar: {result}")

################
filter = {"house_rules": re.compile(r"(?i)no smoking|no parties")}
result = db.count_documents(filter)
print(f"Propiedades que no permiten fumar ni fiestas: {result}")

################ Reto 02 ###############
filter = {
    "number_of_reviews": {"$gte": 50},
    "review_scores.review_scores_rating": {"$gte": 80},
    "amenities": {"$in": [re.compile(r"Ethernet")]},
    "address.country_code": "BR",
}
result = db.count_documents(filter)
print(f"comentarios >= 50 ,rating >= 80, Ethernet, Brazil: {result}")

################ Reto 02 ###############
filter = {
    "amenities": {"$in": ["Ethernet", "Wifi"]},
}
result = db.count_documents(filter)
print(f"Ethernet & WiFi: {result}")