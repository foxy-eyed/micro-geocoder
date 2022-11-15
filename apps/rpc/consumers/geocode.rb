# frozen_string_literal: true

channel = Core::RabbitMq.consumer_channel
queue = channel.queue("geocoding", durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, _properties, payload|
  payload = JSON(payload)
  result = Geocoder::Services::FetchCoordinates.new.call(city: payload["city"])

  if result.success?
    AdsService::HTTP::Client.new.update_ad(payload["id"], result.value!)
    channel.ack(delivery_info.delivery_tag)
  end
end
