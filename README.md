# Projeto de Exemplo com OpenTelemetry

Este projeto demonstra a instrumentação de duas aplicações, uma em Go e outra em Node.js, utilizando OpenTelemetry para rastreamento distribuído com Zipkin.

## Estrutura

- `/goapp`: Uma aplicação web em Go que expõe um endpoint e faz uma requisição para a aplicação Node.js.
- `/nodejs`: Uma API em Node.js com Express que se conecta a um banco de dados SQLite.

## Pré-requisitos

- Go
- Node.js
- Docker (para executar o Zipkin)

## Como Executar

1. **Iniciar o Zipkin:**

    ```bash
    docker run -d -p 9411:9411 openzipkin/zipkin
    ```

2. **Executar a aplicação Node.js:**
    Consulte o `nodejs/README.md` para mais detalhes.

3. **Executar a aplicação Go:**
    Consulte o `goapp/README.md` para mais detalhes.

Após executar as aplicações, acesse `http://localhost:8888` no seu navegador. As requisições serão rastreadas e os traces estarão visíveis na interface do Zipkin em `http://localhost:9411`.
