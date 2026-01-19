import smtplib

text = f"Subject: HELLO \n\n TEST EMAIL"

server = smtplib.SMTP("smtp.gmail.com", 587)
server.starttls()

server.login("mab88889@gmail.com", "skht smyc xmmm mhsa")
server.sendmail("mab88889@gmail.com", "mbhavsar2997@gmail.com", text)

print("Email Sent!")