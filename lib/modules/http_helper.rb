module Helpers
  def http_get(url, params, http_code = 200)
    response = HTTParty.get(url, params)
    expect(response.code == http_code).to be_truthy,
      "The GET request #{url} should return a code #{http_code}, return code #{response.code} instead with #{response.body}"

    response
  end

  def http_post(url, params, http_code = 200)
    response = HTTParty.post(url, params)
    expect(response.code == http_code).to be_truthy,
      "The POST request #{url} should return a code #{http_code}, return code #{response.code} instead with #{response.body}"

    response
  end

  def get_request_headers_for_json
    {
      'Content-Type' => 'application/json;charset=UTF-8',
      'Connection' => 'keep-alive',
      'cookie' => @cookie
    }
  end

  def get_request_headers_for_form
    {
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Connection' => 'keep-alive',
      'cookie' => @cookie
    }
  end
end
