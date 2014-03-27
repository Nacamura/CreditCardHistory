require 'mechanize'
require 'json'

class NetAnswer
  def call
    csv = get_mechanize_res
    csv.save_as('./detail_' + Time.now.strftime("%Y%m") + '.csv')
  end

  def get_mechanize_res
    auth = open('./auth.txt') {|i| JSON.load(i)}
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    login = agent.get 'https://netanswerplus.saisoncard.co.jp/WebPc/welcomeSCR.do'
    login_form = login.form
    login_form.field_with(:name=>'inputId').value = auth['id']
    login_form.field_with(:name=>'inputPassword').value = auth['password']
    mypage = login_form.click_button
    detail = mypage.link_with(:text=>'利用明細確認').click
    csv = detail.link_with(:text=>'CSVダウンロード').click
    mypage.link_with(:text=>'ログアウト').click
    csv
  end
end