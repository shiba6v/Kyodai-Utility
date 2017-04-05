require 'mechanize'

if ARGV[1] == nil
  puts "引数1: ECS-ID"
  puts "引数2: パスワード"
  exit!
end

login_id = ARGV[0]
login_pass = ARGV[1]
LOGIN_URL = "https://student.iimc.kyoto-u.ac.jp/"

agent = Mechanize.new

# 全学共通ポータル
portal_page = agent.get(LOGIN_URL)
puts "==================#{LOGIN_URL}======================"
puts portal_page.links
login_link = portal_page.links.find{|item| item.text.include?("ログイン")}
login_page = login_link.click
puts "==================#{login_link.href}======================"
puts login_page.links

# ログイン
login_form = login_page.forms.first
login_form["j_username"] = login_id
login_form["j_password"] = login_pass
login_button = login_form.button_with()

# リダイレクト
redirect_page = login_form.click_button(login_button)
redirect_form = redirect_page.forms.first
redirect_button = redirect_form.button_with()

# 利用サービス選択
portal_page = redirect_form.click_button(redirect_button)
puts portal_page.links
redirect_link = portal_page.links.find{|item| item.href.include?("https://www.k.kyoto-u.ac.jp")}
puts "==================#{redirect_link.href}======================"
puts portal_page.links

# リダイレクト
redirect_page = redirect_link.click
redirect_form = redirect_page.forms.first
redirect_button = redirect_form.button_with()

# 履修登録トップページ
kulasis_page = redirect_form.click_button(redirect_button)
register_pre_link = kulasis_page.links.find{|item| item.text.include?("履修登録")}
puts "==================#{register_pre_link.href}======================"
puts kulasis_page.links
register_pre_page = register_pre_link.click
register_link = register_pre_page.links.find{|item| item.href.include?("timeslot_list")}
puts "==================#{register_link.href}======================"
puts register_pre_page.links

# 履修登録テーブル
register_page = register_link.click
table = register_page.xpath("//div[@id='frame']/div[@id='wrapper']/div[@class='contents']/div[@class='content']/table[2]").first
table_content = table.xpath("//td[@class='timetable_filled' or @class='timetable_null']")

index = 0
lecture_table = [[],[],[],[],[]]

# 履修登録テーブルから科目を抜き出す
table_content.each do |cell|
  a = cell.xpath("table/tr/td/div/a")
  lecture_name = ""
  if a.count != 0
    lecture_name = a.first.attributes['title'].value
    lecture_name.slice!(/\s\(.*\)$/)
  end
  lecture_table[index/5][index%5] = lecture_name
  index += 1
end

# 出力
puts "==================出力======================"
DAYS = ["月", "火", "水", "木", "金"]
loop_count = 0
lecture_table.each do |lecture_row|
  puts "======#{DAYS[loop_count]}曜日======="
  puts lecture_row
  loop_count += 1
end
puts "==============="


