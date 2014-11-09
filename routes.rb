# Actions
#
# @param [String] collection
# @param [String] action
# @param [String] id optional
# @return [JSON] id or action result
# @example curl -i 'localhost:4567/volumes/create' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: uCFyNr9NrYLmxrUFTBQ1quwVUFjQ8yaBeElkhuG5' -d 'options[][availability_zone]=eu-central-1a' -d 'options[][size]=1' -X GET
# @example curl -i 'localhost:4567/snapshots/exists%3F' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: uCFyNr9NrYLmxrUFTBQ1quwVUFjQ8yaBeElkhuG5' -d 'id=snap-007e3b85' -X GET
get '/:collection/:action' do
  respond_to_action(params: params)
end

# Images
#
# @param [Array] filters optional
# @return [JSON] array of images
# @example curl -i 'localhost:4567/images' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: uCFyNr9NrYLmxrUFTBQ1quwVUFjQ8yaBeElkhuG5' -d 'filters[][name]=platform' -d 'filters[][values][]=windows' -X GET
get '/images*' do
  respond_with_collection(collection: :images, set: :images, filters: params['filters'])
end

# Instances
#
# @param [Array] filters optional
# @return [JSON] array of instances
# @example curl -i 'localhost:4567/instances' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: uCFyNr9NrYLmxrUFTBQ1quwVUFjQ8yaBeElkhuG5' -X GET
get '/instances*' do
  respond_with_collection(collection: :instances, set: :reservation, filters: params['filters'])
end

# Volumes
#
# @param [Array] filters optional
# @return [JSON] array of volumes
# @example curl -i 'localhost:4567/volumes' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: uCFyNr9NrYLmxrUFTBQ1quwVUFjQ8yaBeElkhuG5' -X GET
get '/volumes*' do
  respond_with_collection(collection: :volumes, set: :volume, filters: params['filters'])
end

# Snapshots
#
# @param [Array] filters optional
# @return [JSON] array of snapshots
# @example curl -i 'localhost:4567/snapshots' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: uCFyNr9NrYLmxrUFTBQ1quwVUFjQ8yaBeElkhuG5' -X GET
get '/snapshots*' do
  respond_with_collection(collection: :snapshots, set: :snapshot, filters: params['filters'])
end
