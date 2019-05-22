module JsonHelper
  def parsed_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def json_time(time)
    time.as_json
  end
end
