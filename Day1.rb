# install watir
# https://github.com/watir/watir/
# gem install watir
#
# Komuro's env version
# $ rbenv local
# 2.0.0-p353

require "watir"
require "watir-webdriver"

browser = Watir::Browser.new
browser.goto("https://portal.aws.amazon.com/gp/aws/developer/registration/index.html")

email = "ayakomuro+test00001@gmail.com"
password = "F00BarUStay0ffBuster!"
myname = "Aya Komuro"
address1 = "1-10-24 Tenjin Chuoku"
address2 = "OnRamp 2F"
city = "Fukuoka"
state = "Fukuoka"
zip = "810-0001"
phone = "03-5579-8029"


# Page 1 Yes, I'm new!
item = browser.text_field(:name, "email")
item.value = email
item2 = browser.radio(:name => 'create').set
item3 = browser.button(:src, /sign-in-secure/).click

browser.wait

# Page 2 Account Information
item4 = browser.text_field(:name, "customerName")
item4.value = myname

item5 = browser.text_field(:name, "emailCheck")
item5.value = email

item6 = browser.text_field(:name, "password")
item6.value = password

item7 = browser.text_field(:name, "passwordCheck")
item7.value = password
item8 = browser.button(:src, /buttons\/continue/).click

browser.wait

# Page 3 Personal Information
item9 = browser.text_field(:name, "Name")
item9.value = myname

item10 = browser.select_list(:id, "Country").select("Japan")
item11 = browser.text_field(:name, "Address1")
item11.value = address1
item12 = browser.text_field(:name, "Address2")
item12.value = address2
item13 = browser.text_field(:name, "City")
item13.value = city
item14 = browser.text_field(:name, "State")
item14.value = state
item15 = browser.text_field(:name, "Zip")
item15.value = zip
item16 = browser.text_field(:name, "Phone")
item16.value = phone

p "Day 1. You start from here! Good Luck!"
