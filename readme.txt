Título :  Projeto de Cálculo Numérico - Aplicação de Métodos Numéricos para Analise de Acidez Relativa e pH de vinho Tinto.

Autores:  João Victor Pacheco
          Andrew da Silva
          Leonardo Vitor de Freitas
          Leonardo Sartori
          
Projeto Disponível em: https://github.com/jovictorp1/ProjetoCalculoNumerico/

Descrição: O objetivo desse projeto é analisar a relação entre a Acidez Relativa e o pH para amostras coletadas de vinho Tinto.
Os dados foram obtidos através da base de dados winequality-red presente no "UCI Machine Learning Repository", onde encontramos
uma base de dados com 1600 dados, e após fazer o tratamento, reduzindo os outliers, trabalhamos com  1400 dados. Fazendo a média 
desses 1400 pontos, obtendo finalmente 14 pontos para que os métodos pudessem ser melhor aplicado, visto que os mesmos não 
funcionam bem para uma nuvem de dados tão densa.
  Esse projeto aplica os seguintes Métodos Numéricos:
  - Metodo dos Minimos Quadrados(MMQ)
  - Interpolação Polinomial de Lagrange.
  
O projeto final é composto por um programa em linguagem R, que aplica esses métodos, e faz a plotagem de um gráfico de Dispersão
para os 14 pontos obtidos pelo Cálculo da Média,traça a curva obtida pelo MMQ e printa em tela testes de valores obtidos através
da Interpolação Polinomial.

Para o funcionamento correto do código, no mesmo diretório devem estar o programa .R e o arquivo winequality-red.csv, pois o
programa .R busca dados do arquivo csv para fazer a análise.

para compilar via terminal no Ubuntu é recomendado seguir os seguintes passos:
1.  Abrir o Terminal
2.  Entrar no diretório do projeto
3.  Abrir a plataforma R, utilizando o comando "~$ R"
4.  Dentro da plataforma R, rodar o programa utilizando o comando source(). "> source("projetoNumerico.r")"
    O Programa printará dados de tempo de execução e os valores obtidos no terminal e abrirá uma nova janela no sistema com o gráfico.
    
5.  Fechar a plataforma R, utilizando o comando "q()" e escolhendo se deseja ou não salvar o Workspace.
