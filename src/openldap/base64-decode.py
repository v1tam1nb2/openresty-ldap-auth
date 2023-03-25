import base64

# テストデータの生成
# python base64-decode.py > testuser.ldif
for num in range(5):
    user = "test" + str(0) + str(0) + str(num + 1)
    password = base64.b64encode(user.encode()).decode()
    print("dn: cn=" + user + ",dc=my-company,dc=com")
    print("givenName:" + user)
    print("sn:" + user)
    print("cn:" + user)
    print("mail:" + user + "@my-company.com")
    print("userPassword::" + password)
    print("objectClass: inetOrgPerson")
    print("objectClass: top")
    print("")