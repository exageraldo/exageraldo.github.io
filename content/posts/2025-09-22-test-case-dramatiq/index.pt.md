+++
date = '2025-09-22T15:58:02-03:00'
lastmod = '2025-09-22T15:58:02-03:00'
title = 'Caso de Teste: Dramatiq'
summary = 'Alguma coisa aqui'
description = 'Alguma descrição'
tags = ['python', 'dramatiq', 'testes']
categories = ['testes']
slug = 'caso-de-teste-dramatiq'
aliases = [
    '/pt/caso-de-teste-dramatiq',
    '/caso-de-teste-dramatiq',
]
draft = true

[build]
  list = 'never'
  publishResources = true
  render = 'always'
+++

## Dramatiq

Dramatiq é uma biblioteca Python que fornece uma estrutura simples e confiável para a criação de filas de tarefas assíncronas e distribuídas e sistemas de processamento de tarefas em segundo plano. Ela funciona enviando mensagens para um broker de mensagens como `RabbitMQ` ou `Redis`, que então distribui essas tarefas para processos de trabalho que executam as tarefas em segundo plano. Os principais recursos incluem uma API direta, suporte para trabalhadores baseados em threads para maior eficiência, reconhecimento automático de mensagens para maior confiabilidade e a capacidade de definir tarefas como “atores” para execução assíncrona, semelhante a linguagens como Elixir e Akka. 

Exemplo de uso copiado da documentação:
```python {linenos=table}
import dramatiq
import requests


@dramatiq.actor
def count_words(url):
    response = requests.get(url)
    count = len(response.text.split(" "))
    print(f"There are {count} words at {url!r}.")


# Synchronously count the words on example.com in the current process
count_words("http://example.com")

# or send the actor a message so that it may perform the count
# later, in a separate process.
count_words.send("http://example.com")
```

### Comparação com outras bibliotecas

{{< components/tabs title="Atualizado em">}}
{{< components/tab name="2019" >}}

<div class="fixed-table"></div>

|                                     | Dramatiq | Celery | Huey   | RQ  |
|-------------------------------------|:--------:|:------:|:------:|:---:|
| Suporte ao Python 2                 | ❌        | ✅     | ✅     | ✅  |
| Suporte ao Windows                  | ✅        | ❌     | ✅     | ❌  |
| Implementação simples               | ✅        | ❌ [^3]| ✅     | ✅  |
| Retentativas automáticas            | ✅        | ❌     | ✅     | ❌  |
| Entrega confiável                   | ✅        | ⁉️ [^1]| ❌     | ❌  |
| Locks e rate limiting               | ✅        | ❌     | ✅     | ❌  |
| Priorização de tarefas              | ✅ [^4]   | ❌ [^4]| ✅     | ✅  |
| Delayed tasks                       | ✅        | ✅ [^2]| ✅     | ❌  |
| Agendamento ao estilo Cron          | ❌ [^5]   | ✅     | ✅     | ❌  |
| Chaining / Pipelining               | ✅        | ✅     | ✅     | ❌  |
| Armazenamento de resultados         | ✅        | ✅     | ✅     | ✅  |
| Recarregamento automático do código | ✅        | ❌     | ❌     | ❌  |
| Suporte ao RabbitMQ                 | ✅        | ✅     | ✅     | ❌  |
| Suporte ao Redis                    | ✅        | ✅     | ✅     | ✅  |
| Suporte a in-memory broker          | ✅        | ❌     | ✅     | ❌  |
| Suporte ao Greenlet                 | ✅        | ✅     | ✅     | ❌  |

{{< components/alert type="note" title="Nota da documentação" blocked="true">}}
Esta tabela [apresentada pela documentação](https://dramatiq.io/motivation.html#compared-to) foi atualizada pela última vez em 2019. É possível que várias partes da tabela abaixo estejam desatualizadas.
{{< /components/alert >}}

[^1]: Celery acks tasks as soon as they’re pulled by a worker by default. This is easy to change, but a bad default. Dramatiq doesn’t let you change this: tasks are only ever acked when they’re done processing.
[^2]: Celery has poor support for delayed tasks. Delayed tasks are put on the same queue that is used for normal tasks and they’re simply pulled into worker memory until they can be executed, making it hard to autoscale workers by queue size. Dramatiq enqueues delayed tasks on a separate queue and moves them back when they’re ready to be executed.
[^3]: Celery’s source code is spread across 3 different projects (celery, billiard and kombu) and it’s impenetrable. Its usage of runtime stack frame manipulation leads to heisenbugs.
[^4]: Celery doesn’t support task prioritization. Dramatiq supports global prioritization under RabbitMQ via the broker_priority. It also provides worker-local prioritization of prefetched messages.
[^5]: For cron-like scheduling functionality, you can combine Dramatiq with APScheduler or Periodiq. 3rd-party packages exist which implement this approach for various frameworks, like: Dramatiq-Crontab

{{< /components/tab >}}{{/*<!-- /2019 --> */}}


{{< components/tab name="2025" >}}

<div class="fixed-table"></div>

|                                     | Dramatiq | Celery | Huey   | RQ     |
|-------------------------------------|:--------:|:------:|:------:|:------:|
| **Suporte ao Python 2**             | ❌        | ❌ [^1]| ✅     | ❌ [^2]|
| **Suporte ao Windows**              | ✅        | ✅ [^1]| ✅     | ❌     |
| Implementação simples               | ✅        | ❌     | ✅     | ✅     |
| **Retentativas automáticas**        | ✅        | ✅     | ✅     | ✅     |
| Entrega confiável                   | ✅        | ⁉️     | ❌     | ❌     |
| **Locks e rate limiting**           | ✅        | ✅     | ✅     | ❌     |
| Priorização de tarefas              | ✅        | ❌     | ✅     | ✅     |
| Delayed tasks                       | ✅        | ✅     | ✅     | ❌     |
| Agendamento ao estilo Cron          | ❌        | ✅     | ✅     | ❌     |
| **Chaining / Pipelining**           | ✅        | ✅     | ✅     | ⁉️     |
| Armazenamento de resultados         | ✅        | ✅     | ✅     | ✅     |
| Recarregamento automático do código | ✅        | ❌     | ❌     | ❌     |
| Suporte ao RabbitMQ                 | ✅        | ✅     | ✅     | ❌     |
| Suporte ao Redis                    | ✅        | ✅     | ✅     | ✅     |
| Suporte a in-memory broker          | ✅        | ❌     | ✅     | ❌     |
| **Suporte ao Greenlet**             | ✅        | ✅     | ✅     | ✅     |

[^1]: https://pypi.org/project/celery/
[^2]: https://pypi.org/project/rq/

{{< components/alert type="note" title="Nota do autor" blocked="true">}}
Esta seção foi atualizada pela última vez em Janeiro/2025.
{{< /components/alert >}}

{{< /components/tab >}}{{/*<!-- /2025 --> */}}
{{< /components/tabs >}}


## Casos de teste

Apesar da biblioteca fornecer uma API/implementação simples, tive algumas dificuldades para realizar os testes unitários.

Ferramentas utilizadas:
- `docker` (28.4.0)
- `docker-compose` (2.39.4)
- `Make` (3.81)
- `uv` (0.8.19)
- `python` (3.10)

O repositório com os casos de teste está organizado da seguinte forma:

```
dramatiq-example/
├── app/                        <-- aplicações
│   ├── tc_01/
│   │   ├── __init__.py
│   │   ├── .env                <-- aplicações
│   │   ├── config.py           <-- aplicações
│   │   ├── routes.py           <-- aplicações
│   │   └── tasks.py            <-- aplicações
│   └── ...
├── dockerfiles/                <-- dockerfiles
│   ├── Dockerfile.tc_01
│   └── ...
├── tests/                      <-- testes
│   ├── tc_01/
│   │   ├── __init__.py
│   │   ├── conftest.py         <-- testes
│   │   └── test_app.py         <-- testes
│   └── ...
├── docker-compose.yml          <-- orquestração
├── Makefile                    <-- comandos
├── pyproject.toml              <-- dependências
└── uv.lock                     <-- dependências
```

```sh
make run.all
make test.all
```

### [01] - Seguindo a documentação

Uma abordagem mais direta, apenas seguindo as documentações de [um exemplo básico do `FastAPI`](https://fastapi.tiangolo.com/#example) +  [um exemplo básico do `dramatiq`](https://dramatiq.io/).

https://12factor.net/pt_br/config

{{< components/tabs>}}
{{< components/tab name="tasks.py" >}}
Exemplo de uso copiado da documentação:
```python {linenos=table}
import dramatiq
import requests


@dramatiq.actor
def count_words(url):
    response = requests.get(url)
    count = len(response.text.split(" "))
    print(f"There are {count} words at {url!r}.")


# Synchronously count the words on example.com in the current process
count_words("http://example.com")

# or send the actor a message so that it may perform the count
# later, in a separate process.
count_words.send("http://example.com")
```
{{< /components/tab >}}{{/*<!-- /tasks.py --> */}}
{{< /components/tabs >}}

```sh
make run.c01
make test.c01
```

### [02] - Imports locais + mocks

https://stackoverflow.com/questions/1699108/local-import-statements-in-python
https://stackoverflow.com/questions/4177735/best-practice-for-lazy-loading-python-modules

dependencia ciclica

```sh
make run.c02
make test.c02
```

### [03] - testcontainers

https://testcontainers-python.readthedocs.io/en/latest/#docker-in-docker-dind

```sh
make run.c03
make test.c03
```

### [04] - docker-compose

```sh
make run.c04
make test.c04
```
