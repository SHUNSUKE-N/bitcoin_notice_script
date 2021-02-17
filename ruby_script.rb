require 'net/http'
require 'uri'
require 'json'

def get_current_hash
  uri = URI.parse('https://blockchain.info/latestblock')
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  req = Net::HTTP::Get.new(uri.path)
  res = https.request(req)
  JSON.parse(res.body)
end

def slack_notice(diff:)
  uri  = URI.parse('WEBHOOK_URL')
  params = { username: 'notice_bot', channel: 'latest_block_notice', text: "latest block numberに差分#{diff}のdiffが生まれています" }
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  https.start do
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(payload: params.to_json)
    https.request(request)
  end
end

latest_curl_num = File.read('/Users/shunsuke/bitcoin_notice_script/latest_curl.json').split(':')[1].strip.split(',')[0].to_i
latest_api_num = get_current_hash['height'].to_i
diff = latest_curl_num - latest_api_num

slack_notice(diff: diff)　if diff > 2 || diff < -2
