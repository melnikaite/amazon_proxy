# curl -i 'localhost:4567/volumes/create' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -d 'options[][availability_zone]=eu-central-1a' -d 'options[][size]=1' -X GET
get '/:collection/:action' do
  respond_to_action(params: params)
end

# curl -i 'localhost:4567/images' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -d 'filters[][name]=platform' -d 'filters[][values][]=windows' -X GET
get '/images*' do
  respond_with_collection(collection: :images, set: :images, filters: params['filters'])
end

get '/instances*' do
  respond_with_collection(collection: :instances, set: :reservation, filters: params['filters'])
end

get '/volumes*' do
  respond_with_collection(collection: :volumes, set: :volume, filters: params['filters'])
end

get '/snapshots*' do
  respond_with_collection(collection: :snapshots, set: :snapshot, filters: params['filters'])
end
