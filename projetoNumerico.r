#########################################################################
#	Projeto de Calculo Numérico - Aplicação de Métodos Numericos para Analise de Acidez Relativa e pH de vinho Tinto
#
#	Autores: 	Andrew da Silva
#			João Victor Pacheco
#			Leonardo Vitor de Freitas
#			Leonardo Sartori
#
#
#########################################################################


time<- proc.time(); #	inicio da contagem de tempo computacional

data <- read.csv("winequality-red.csv", header= TRUE); #Função que lê a matriz de dados do arquivo .csv e salva na variável data


A <- matrix (c(data[,1]),100,14); #Matriz A recebe os valores da primeira coluna da variavel data. (Acidez volátil). [(x)]
B <- matrix(c(data[,2]),100, 14); #Matriz B recebe os valores da segunda coluna da variável data. (pH). [f(x)]

x <- matrix(c(0,0),1,14);	#Criação da matriz que receberá os 14 pontos médios de X dentre os 1400 pontos coletados
y <- matrix(c(0,0),1,14);	#Criação da matriz que receberá os 14 pontos médios de f(X) dentre os 1400 pontos coletados

 

#Cálculo da média, dividido em for para somar os valores e for para dividir valores por 100, para obter a média de 100 pontos analisados.
for (j in  1:14){
	for (i in 1:100){
	x[j]<- x[j]+ A[i,j];
	y[j]<- y[j]+ B[i,j];
	

	}
}

for (k in 1:14){
	x[k]<- x[k]/100;
	y[k]<- y[k]/100;
}



#Tempo computacional para se calcular a média.
cat("Tempo utilizado para calcular a média: \n");
print(proc.time()- time); #fim da contagem de tempo para a média.


cat("\n");


timeMMQ <- proc.time() #inicio da contagem do tempo para calculo do MMQ


#####################################################
#	Aplicação do MMQ
#####################################################

d=4; #d-1= ordem


X <- matrix(c(0),d,d);
Y <- matrix(c(0),d,1);
N=14; #numero de pontos para o calculo do MMQ

# Cálculo da matriz dos X
for(j in 1:d)
{
	for(i in 1:d)
	{
		for(t in 1:N)
		{
			X[i,j] <- X[i,j] + x[t]^(i+j-2);
		}
	}
}

# Calculo da matriz dos Y
for(i in 1:d)
{
	for(t in 1:N)
	{
		Y[i,1] <- Y[i,1] + y[t]*x[t]^(i-1);
	}
}

#Temos que Ax=b, logo temos X= A, Y=b.
print(X); # A
print(Y); # b

#############################################################
# escalonamento da matriz ampliada Ax=b
#############################################################

resolve1 <- function(A,b,n)
{
X <- cbind(A,b); #função utilizada para obter a matriz ampliada.
X[1,] <- X[1,]/X[1,1]
for(i in 2:n)
{
	for(j in i:n)
	{
		X[j,] <- X[j,]-X[i-1,]*X[j,i-1];
	}
	X[i,] <- X[i,]/X[i,i]
}

for(i in n:2)
{
	for(j in i:2-1)
	{
		X[j,] <- X[j,]-X[i,]*X[j,i];
	}
}
return(X);
}

P <- resolve1(X,Y,d);

print(P); #printa a matriz escalonada.

# A partir disso, como trabalharemos com um polinomio de grau 3, temos a expressão:
# (a3)x^3 + (a2)x^2 + (a1)x + a0
# então temos abaixo os coeficientes a[0..3] recebendo os valores da quinta coluna da matriz escalonada
a0 <- P[1,5]; 
a1<- P[2,5];
a2<- P[3,5];
a3<- P[4,5];

f <- function(x){
	return(x^3*a3 + x^2*a2 + x*a1 +a0);
}

#Tempo computacional para se calcular pelo metodo do MMQ.
cat("Tempo utilizado para calcular o MMQ: \n");
print(proc.time()- timeMMQ); #fim da contagem de tempo para calculo do MMQ.


cat("\n");

timeInterpola <- proc.time(); #inicio da contagem de tempo para a interpolação


#############################################################################
#
# Aqui tenho a implementação de interpolação com polinomio de lagrange
# que fizemos em sala. Só que no caso ela apenas retorna o valor de f(x) um ponto 
# dado um ponto x qualquer
#
#############################################################################
n<-4; #Numero de Dados
b<-1; 
d<-1;
g<-3; # Grau do Polinomio

#Escolhidos pontos do experimento para determinar um polinomio de Grau 3 através da interpolação.
w<-c(x[1],x[5],x[10],x[14]);
z<-c(y[1],y[5],y[10],y[14]);

l<-c(0,n,1); #inicialização do vetor onde serão salvos os L.
polinomio<-0; #Inicialização da variavel polinomio
g<- g+1; #Incrementa o valor da variavel G, apenas para o loop ser feito 1 vez a mais, pois é necessário fazer x^g+x^(g-1)+...+x^2+x^1+x^0. Como temos esse valor x^0, então há a necessidade de incrementar em um essa variável.
L<-function(valorX){


	for (k in 1:n){
		for(i in 1:n){
		a=b*(valorX - w[i]);
		
		if(i!=k){
		b<-a;
		}
		}

		for (j in 1:n){
			c=d*(w[k]-w[j]);
			if(j!= k){
				d<-c;}
				
		}

		l[k] <- (b/d);
		b<-1;
		d<-1;

	}

	for (k in 1:(g)){
	polinomio <-polinomio+ (z[k]*l[k]); #Faz a Soma P_i(x)= y0L0 + y1Ly+...+  ynLn
	}

	return(polinomio); #Retorna o valor 

}


#fazendo o teste para pontos quaisquer do conjunto de dados (Os 14 pontos)

print(L(0.2364));
print(L(0.4095));
print(L(0.5086));
print(L(0.6367));
print(L(0.8625));


#Tempo computacional para se calcular pelo metodo da Interpolação Polinomial.
cat("Tempo utilizado para calcular a Interpolacao: \n");
print(proc.time()- timeInterpola); #fim da contagem de tempo para calculo por Interpolação.
cat("\n");

plot(x,y,main="Analise da Relacao entre Acidez Volátil e pH para o Vinho Tinto", xlab="Acidez Volatil", ylab="pH"); # plota o grafico de dispersão
curve(f, add=TRUE, col="red", n=2001); #plota sob o grafico de dispersão, a curva obtida pelo MMQ
#Tempo computacional para o programa todo, incluindo calculos, impressões e plotagem.
cat("Tempo utilizado para o programa todo (Calculos, impressoes e plotagem): \n");
print(proc.time()- time); #fim da contagem de tempo para o programa.














