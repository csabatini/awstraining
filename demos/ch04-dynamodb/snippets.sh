# Create Table
aws dynamodb create-table --cli-input-json file://TMusic.json

# Describe Table
aws dynamodb describe-table --table-name Music

# Update Table
aws dynamodb update-table --table-name "Music" --provisioned-throughput ReadCapacityUnits=2,WriteCapacityUnits=2

# Delete Table
aws dynamodb delete-table --table-name Music

# -----------------------------------------------------------

# Put Item
aws dynamodb put-item --cli-input-json file://Item1.json
aws dynamodb put-item --cli-input-json file://Item2.json
aws dynamodb put-item --cli-input-json file://Item3.json
aws dynamodb put-item --cli-input-json file://Item4.json
aws dynamodb put-item --cli-input-json file://Item5.json

# Delete item
aws dynamodb delete-item --cli-input-json file://Item1D.json
aws dynamodb delete-item --table-name "Music" --key file://Item1Key.json
aws dynamodb delete-item --table-name "Music" --key '{ "Artist": { "S": "No One You Know" }, "SongTitle": { "S": "Call Me Today" }}'

# -----------------------------------------------------------

# Batch Delete
aws dynamodb batch-write-item --request-items file://Batch1D.json

# Batch Put
aws dynamodb batch-write-item --request-items file://Batch1P.json

# -----------------------------------------------------------

# Update Item
aws dynamodb update-item --table-name "Music" --key file://Item1Key.json --return-values ALL_NEW --update-expression "SET Price = :p" --expression-attribute-values '{":p": {"N": "2.15"}}'

# -----------------------------------------------------------

# Conditional Expressions
# 1. Put - don't overwrite an existing item
# 2. Delete - if artist in set and price > 1.00
# 3. Update - set price if artist matches expression

aws dynamodb put-item --cli-input-json file://Item1.json --condition-expression "attribute_not_exists(Artist) and attribute_not_exists(SongTitle)"
aws dynamodb delete-item --table-name "Music" --key file://Item1Key.json --condition-expression "(Artist in (:a1, :a2)) and (Price > :p)" --expression-attribute-values '{":a1": {"S": "No One You Know"}, ":a2": { "S": "The Acme Band" }, ":p": {"N": "1.00"}}'
aws dynamodb update-item --table-name "Music" --key file://Item1Key.json --return-values ALL_NEW --update-expression "SET Price = :p" --condition-expression "Artist = :a" --expression-attribute-values '{":p": {"N": "3.15"}, ":a": {"S": "No One You Know"}}' 
	
# -----------------------------------------------------------

# Query - Partition Key
aws dynamodb query --table-name "Music" --key-condition-expression "Artist = :a" --expression-attribute-values '{":a": {"S": "No One You Know"}}'
aws dynamodb query --table-name "Music" --key-condition-expression "Artist = :a" --filter-expression "Price >= :p" --expression-attribute-values '{":p": {"N": "2.00"}, ":a": {"S": "No One You Know"}}'

# Query - Partition Key + Sort Key
aws dynamodb query --table-name "Music" --key-condition-expression "Artist = :a and SongTitle = :t" --expression-attribute-values '{":a": {"S": "No One You Know"}, ":t": {"S": "Call Me Today"}}'
aws dynamodb query --table-name "Music" --key-condition-expression "Artist = :a and SongTitle between :t1 and :t2" --expression-attribute-values '{":a": {"S": "No One You Know"}, ":t1": {"S": "Call Me Today"}, ":t2": {"S": "My Dog Spot"}}'

# Scan
aws dynamodb scan --table-name "Music"
aws dynamodb scan --table-name "Music" --projection-expression "Artist, AlbumTitle, SongTitle"
aws dynamodb scan --table-name "Music" --filter-expression "Price >= :p" --expression-attribute-values '{":p": {"N": "2.00"}}'
aws dynamodb scan --table-name "Music" --filter-expression "Tags.LengthInSeconds >= :s" --expression-attribute-values '{":s": {"N": "200"}}'
aws dynamodb scan --table-name "Music" --filter-expression "contains(Tags.Composers, :c)" --expression-attribute-values '{":c": {"S": "Jones"}}'

# -----------------------------------------------------------

# Create GSI
aws dynamodb update-table --table-name "Music" --attribute-definitions AttributeName=AlbumTitle,AttributeType=S AttributeName=SongTitle,AttributeType=S --global-secondary-index-updates file://TMusicGSI.json

# Query GSI
aws dynamodb query --table-name "Music" --index-name "MusicAlbumSong" --key-condition-expression "AlbumTitle = :a" --expression-attribute-values '{":a": {"S": "Somewhat Famous"}}'


# Delete GSI
aws dynamodb update-table --table-name "Music" --global-secondary-index-updates '[{"Delete":{"IndexName": "MusicAlbumSong"}}]'


								