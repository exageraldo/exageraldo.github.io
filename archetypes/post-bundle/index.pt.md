+++
date = '{{ .Date }}'
lastmod = '{{ .Date }}'
title = '{{ .Name }}'
summary = 'Alguma coisa aqui'
description = 'Alguma descrição'
author = ''
tags = ['algumas', 'tags', 'aqui']
categories = ['algumas', 'categorias', 'aqui']
slug = '{{ .Name }}'
aliases = ['/pt/{{ .Name }}']
draft = true

# https://gohugo.io/content-management/build-options/
[build]
  list = 'never'
  publishResources = true
  render = 'always'
+++
