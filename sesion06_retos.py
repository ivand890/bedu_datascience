from typing import Collection
from pymongo import MongoClient
import re
import os

password = os.environ["MONGODB_PASS"]
client = MongoClient(
    f"mongodb+srv://ivand890:{password}@clusterbedu.dj9lq.mongodb.net/test?authSource=admin&replicaSet=atlas-wa6ki3-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true"
)
db = client["sample_airbnb"]["listingsAndReviews"]

print("###################### Reto 1 ###############")
result = db.aggregate([
    {
        '$match': {
            'property_type': 'House', 
            'bedrooms': {
                '$gte': 1
            }
        }
    }, {
        '$addFields': {
            'costo_recamara': {
                '$divide': [
                    '$price', '$bedrooms'
                ]
            }
        }
    }, {
        '$group': {
            '_id': '$address.country', 
            'recamaras': {
                '$sum': 1
            }, 
            'total': {
                '$sum': '$costo_recamara'
            }
        }
    }, {
        '$addFields': {
            'pais': '$_id', 
            'costo_promedio': {
                '$divide': [
                    '$total', '$recamaras'
                ]
            }
        }
    }, {
        '$project': {
            '_id': 0, 
            'pais': 1, 
            'costo_promedio': 1
        }
    }
])

for doc in result:
    print(doc)

print("####################### Reto 2 #####################")
result = db.aggregate([
    {
        '$lookup': {
            'from': 'users', 
            'localField': 'name', 
            'foreignField': 'name', 
            'as': 'usuario'
        }
    }, {
        '$addFields': {
            'usuario_objeto': {
                '$arrayElemAt': [
                    '$usuario', 0
                ]
            }
        }
    }, {
        '$addFields': {
            'usuario_password': '$usuario_objeto.password'
        }
    }, {
        '$project': {
            '_id': 0, 
            'name': 1, 
            'email': 1, 
            'usuario_password': 1
        }
    }
])

for doc in list(result)[:5]:
    print(doc)