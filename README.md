# quake-log-parser

Programa feito para resolver as tarefas do quake log parser(https://gist.github.com/akitaonrails/97310463c52467d2ecc6), que é basicamente ler o arquivo games.log e detalhar todas as kills do jogo.

## Solução
A solução que eu utilizei foi fazer duas classes para facilitar o armazenamento de dados, que são o Game e Player, o Player é utilizado para armazenar a quantidade de kills, o nome e o id do jogador(para casos quando o jogar muda de nome) e a classe Game, é utilizado para detalhar as kills do jogo inteiro e métodos para facilitar a busca por jogadores do jogo. A classe Log é feita para ler o arquivo e armazenar todos os jogos e emitir um relatório do jogo com o ranking dos jogadores.

## Como rodar
```
$ git clone https://github.com/hugoandregg/quake-log-parser
$ cd quake-log-parser
$ ruby Main.rb games.log
```

Para rodar os testes:

```
$ ruby tests/PlayerTest.rb
$ ruby tests/GameTest.rb
$ ruby tests/LogTest.rb
```
