+++
date = '{{ .Date }}'
lastmod = '{{ .Date }}'
title = '{{ .Name }}'
summary = 'Some info here'
description = 'Some description'
author = ''
tags = ['some', 'tags', 'here']
categories = ['some', 'categories', 'here']
slug = '{{ .Name }}'
aliases = ['/en/{{ .Name }}']
draft = true

# https://gohugo.io/content-management/build-options/
[build]
  list = 'never'
  publishResources = true
  render = 'always'
+++
