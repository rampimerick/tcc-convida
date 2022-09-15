# Tutorial para rodar o Convida localmente

# Pré-requisitos 

</hr>
<ul>
<li>Ter o docker instalado na sua máquina <a href="https://docs.docker.com/engine/install/">(tutorial de instalação do docker)</a></li>
<li>Ter o docker-compose instalado na sua máquina <a href="https://docs.docker.com/compose/install/">(tutorial de instalação do docker composer)</a></li>
<li>Ter o Git instalado na sua máquina <a href="https://git-scm.com/book/en/v2/Getting-Started-Installing-Git">(tutorial de instalação do git)</a></li>
</ul>

# Tutorial  

</hr>

### Passo 1: Clonar o projeto do backend

Dentro de uma pasta de sua preferencia, rode o seguinte comando: </br>

<code>$ git clone https://github.com/ufpr-convida/backend.git</code> </br>

### Passo 2: Fazer o download do repositório de backups

No <a href="https://github.com/ufpr-convida/backup">site do repositório do backup</a> faça o download do repositório como arquivo zip;</br>
Em seguida, descompacte o .zip em uma pasta de sua preferencia.

### Passo 3: Rodar os containers docker:

Na pasta raiz do projeto clonado abrir um terminal e rodar o comando: </br>

<code>$ sudo docker-compose build</code></br>

Se tudo ocorrer corretamente, você deverá ver algo parecido com a seguinte mensagem:</br>

 ![img1](https://raw.githubusercontent.com/danivm1/erickao/main/docs/images/img1.PNG)


> **NOTA:** Esse comando pode demorar um pouco para ser concluído, principalmente da primeira vez que for rodado.</br> 

Em seguida rodar:</br>

<code>$ sudo docker-compose up</code></br>

Caso o comando seja bem sucedido,você verá algo como essa imagem:</br> 

 ![img2](https://github.com/danivm1/erickao/blob/main/docs/images/img2.PNG?raw=true)
 
### Passo 4: Ver o ID de um container na lista de containers:

Com os containers rodando, em um **novo terminal**, digite o seguinte comando: <br>

<code>$ sudo docker ps</code></br>
 
Você deverá obter uma saída como essa:</br>

![img3](https://github.com/danivm1/erickao/blob/main/docs/images/img3.PNG?raw=true)

Copie o CONTAINER ID do container mongo.</br>  

### Passo 5: Copiar a pasta de backup convida para dentro do container MongoDB:

Em um terminal rode o seguinte comando: </br>

<code>$ sudo docker cp caminhodapastaconvida iddocontainermongo:bin/dump</code></br> 

**Exemplo:** </br>
<code>sudo docker cp /home/alethor/Downloads/backup-main/backup-9-10-2020 6b5e7708d23d:/bin/dump</code></br>

### Passo 6: Abrir um terminal dentro do container do banco de dados mongo:

Em um terminal rode o seguinte comando: </br> 

<code>$ sudo docker exec -it iddocontainermongo bash</code></br>

Seu terminal ficará dessa forma:</br>

![img4](https://github.com/danivm1/erickao/blob/main/docs/images/img4.PNG?raw=true)

### Passo 7: Realizar a restauração do backup no container do MongoDB:

<code># cd /bin</code></br>

Em seguida rodar:</br>

<code># mongorestore</code></br>

Caso o comando seja bem sucedido você verá algo como essa saída:</br>

![img5](https://github.com/danivm1/erickao/blob/main/docs/images/img5.PNG?raw=true)

Dessa forma você terá uma cópia do banco de dados da produção rodando localmente na sua máquina.</br>
Caso você precise iniciar novamente os container, repita o Passo 3.</br>

### Passo 8: Alterar a url no projeto mobile

No arquivo <code>mobile/convida/lib/app/shared/global/globals.dart</code> alterar a variável URL para o seu IP local;


