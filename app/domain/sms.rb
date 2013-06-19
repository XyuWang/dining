# coding: UTF-8
class SMS

  def initialize
    @balance_url =  "http://api.c123.com/mm/"
    @send_sms_url = "http://api.c123.com/tx/"
    @account = SMS_ACCOUNT
    @password = SMS_PASSWORD
  end

  def send(phone, content)
    uri = URI(@send_sms_url)
    params = { uid: @account, pwd: @password, :mobile => phone, :content => content, encode: "utf8"}
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)

    res.body
  end

  def balance
    uri = URI(@balance_url)
    params = { uid: @account, pwd: @password }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)

    status = res.body.to_i
    if status == 100
      return "#{res.body[res.body.index("||") + 2, res.body.size]}"
    else
      return "查询失败..."
    end
  end
end
