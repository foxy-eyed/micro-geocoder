# frozen_string_literal: true

logger = Core::Logger.instance
channel = Core::RabbitMq.consumer_channel
queue = channel.queue("geocoding", durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  Thread.current[:request_id] = properties.headers["request_id"]
  payload = JSON(payload)
  result = Geocoder::Services::FetchCoordinates.new.call(city: payload["city"])

  if result.success?
    coordinates = result.value!
    AdsService::HTTP::Client.new.update_ad(payload["id"], coordinates)
    channel.ack(delivery_info.delivery_tag)
    logger.info("fetch coordinates", status: "success", details: { city: payload["city"], coordinates: coordinates })
  else
    logger.info("fetch coordinates", status: "failure", details: result.failure)
  end
end
