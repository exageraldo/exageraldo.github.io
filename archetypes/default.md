+++
date = '{{ .Date }}'
lastmod = '{{ .Date }}'
title = '{{ replace .Name "-" " " | title }}'
summary = 'Some info here'
description = 'Some description'
author = ''
tags = ['some', 'tags', 'here']
categories = ['some', 'categories', 'here']
slug = '{{ .Name }}'
aliases = ['/{{ .Name }}']
draft = true
+++

