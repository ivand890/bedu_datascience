from pymongo import MongoClient
import os

password = os.environ["MONGODB_PASS"]
client = MongoClient(
    f"mongodb+srv://ivand890:{password}@clusterbedu.dj9lq.mongodb.net/test?authSource=admin&replicaSet=atlas-wa6ki3-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true"
)


######### reto 1 ##############################

filter = {}
project =   { 
            "date": 1, 
            "name": 1, 
            "text": 1
            }

result = client["sample_mflix"]["comments"].find(filter=filter, projection=project)

# convertir el resultado en una lista de objetos
print(list(result))
###############
filter = {}
project = {"title": 1, "cast": 1, "year": 1}

result = client["sample_mflix"]["movies"].find(filter=filter, projection=project)

# convertir el resultado en una lista de objetos
print(list(result))
##########################
filter = {}
project = {"name": 1, "password": 1}

result = client["sample_mflix"]["users"].find(filter=filter, projection=project)

# convertir el resultado en una lista de objetos
print(list(result))


######### reto 2 ##############################
filter = {"name": "Greg Powell"}

result = client["sample_mflix"]["comments"].find(filter=filter)

# convertir el resultado en una lista de objetos
print(list(result))
######################################
filter = {"$or": [{"name": "Greg Powell"}, {"name": "Mercedes Tyler"}]}

result = client["sample_mflix"]["comments"].find(filter=filter)

# convertir el resultado en una lista de objetos
print(list(result))
#####################################
filter = {}
project = {"num_mflix_comments": 1}
sort = list({"num_mflix_comments": -1}.items())
limit = 1

result = client["sample_mflix"]["movies"].find(
    filter=filter, projection=project, sort=sort, limit=limit
)

# convertir el resultado en una lista de objetos
print(list(result))
###########################################
filter = {}
project = {"title": 1}
sort = list({"num_mflix_comments": -1}.items())
limit = 5

result = client["sample_mflix"]["movies"].find(
    filter=filter, projection=project, sort=sort, limit=limit
)

# convertir el resultado en una lista de objetos
print(list(result))