+ 为了简洁，避免错误，我们吧公共的部分移入_help.tpl中
```
{{- define "labels"}}
    author: "zxk"
    email: "mckj_zhangxk@163.com"
    app: {{ .Release.Name }}
{{- end }}
```

+ 在需要的部分引入上面的模板：
```
labels:
    {{-template "label" . }}
    {{-end }}

```
<font color="red">上面的.表示scope在root,这样我们才可以引用{{.Release.Name}}</font>


+ 需要的地方都引入以上模板模板：

```
labels:
    {{- template "label" . }}
...
    labels:
        {{-template "label" . }}
以上会造成indent出现问题!
```
<font color="BLUE">正确的方法是：使用include函数替换template( action),pipe上一个 indent函数</font>
```

labels:
    {{- include "labels" .}}
...
    labels:
        {{- include "label" . |indent 2}}
```