Proxy for AWS::EC2
==================

Supported services:
-------------------
- Images
- Instances
- Volumes
- Snapshots

Examples:
---------
`curl -i 'localhost:4567/volumes/create' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: uCFyNr9NrYLmxrUFTBQ1quwVUFjQ8yaBeElkhuG5' -d 'options[][availability_zone]=eu-central-1a' -d 'options[][size]=1' -X GET`

`curl -i 'localhost:4567/snapshots/exists%3F' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -d 'id=snap-007e3b85' -X GET`

`curl -i 'localhost:4567/images' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -d 'filters[][name]=platform' -d 'filters[][values][]=windows' -X GET`

`curl -i 'localhost:4567/instances' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -X GET`

`curl -i 'localhost:4567/volumes' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -X GET`

`curl -i 'localhost:4567/snapshots' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -X GET`

Run:
====
`chmod +x app.rb`

`./app.rb`
