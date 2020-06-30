import urllib.request
import urllib.parse
import json
content = input('请输入需要翻译的内容：')
url = 'http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule'

data = {}
data['i'] = content
data['from'] = 'AUTO'
data['to'] = 'AUTO'
data['smartresult'] = 'dict'
data['client'] = 'fanyideskweb' 
data['salt'] = '15858808868649' 
data['sign'] = 'de4c5b49c45ed272d75d4873513754b2' 
data['ts'] = '1585880886864' 
data['bv'] = '70244e0061db49a9ee62d341c5fed82a' 
data['doctype'] = 'json' 
data['version'] = '2.1' 
data['keyfrom'] = 'fanyi.web' 
data['action'] = 'FY_BY_REALTlME' 

data = urllib.parse.urlencode(data).encode('utf-8')
response = urllib.request.urlopen(url, data)
html = response.read().decode('utf-8')
target = json.loads(html)
print('翻译结果：%s' % (target['translateResult'][0][0]['tgt']))

