+++
# https://gohugo.io/content-management/front-matter/

author = ''
date = '{{ .Date }}'
modified = '{{ .Date }}'

title = '{{ replace .Name "-" " " | title }}'
summary = 'Some info here'
description = 'Some description'

tags = ['some', 'tags', 'here']
categories = ['some', 'categories', 'here']
keywords = ['some', 'keywords', 'here']

slug = '{{ .Name }}'
aliases = ['/{{ .Name }}']

draft = true
+++

