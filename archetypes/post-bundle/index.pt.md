+++
date = '{{ .Date }}'
lastmod = '{{ .Date }}'
title = 'Titulo da nova postagem'
description = 'Essa descrição vai abaixo do titulo'
summary = 'Algum resumo para ir na miniatura ou cartão de visualização'
author = 'Geraldo Castro'
tags = []
categories = []
slug = '{{ .Name }}-{{ substr (.Name | base64Encode) 0 5 }}'
aliases = [
    '/pt/{{ .Name }}',
]

# Remove these parameters when publishing
# or change everything to 'false'
draft = true
hiddenInHomeList = true
searchHidden = true
+++
