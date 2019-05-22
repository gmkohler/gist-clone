module JsonapiHelper
  def jsonapi_request_headers
    {
      CONTENT_TYPE: "application/vnd.api+json",
      HTTP_ACCEPT: "application/vnd.api+json"
    }
  end

  def jsonapi_get(url, query_params = {}, headers = {})
    get(url, {
      params: query_params,
      headers: {
        **jsonapi_request_headers,
        **headers
      }
    })
  end

  def jsonapi_post(url, payload, headers = {})
    post(url, {
      params: payload.to_json,
      headers: {
        **jsonapi_request_headers,
        **headers
      }
    })
  end

  def jsonapi_put(url, payload, headers = {})
    put(url, {
      params: payload.to_json,
      headers: {
        **jsonapi_request_headers,
        **headers
      }
    })
  end
end
