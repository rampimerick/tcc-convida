# Como rodar o projeto

## Pré-requisitos

- Ter o [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) instalado na sua máquina;
- Ter um [editor de código](https://balta.io/blog/visual-studio-code-instalacao-customizacao) ou [IDE](https://confluence.jetbrains.com/pages/viewpage.action?pageId=54920165) de sua preferência;
- Ter o [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado em seu sistema operacional;
- Para o desenvolvimento da aplicação, será necessário um celular Android (a App Store traz algumas complicações para testes no IOS, então por isso nesta etapa tomamos o Android como base). Você pode utilizar um celular Android [configurado para desenvolvimento](https://canaltech.com.br/android/como-ativar-modo-desenvolvedor-android/) ou também um [emulador](https://www.androidpro.com.br/blog/desenvolvimento-android/emulador-de-android/).


## Passo a Passo

### Passo 1:

Dentro de uma pasta de sua preferência, faça o clone do projeto: 

```bash
git clone https://github.com/ufpr-convida/backend.git
```

Obs.: Você também pode fazer o clone usando uma chave [SSH](https://docs.github.com/pt/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

### Passo 2:

Agora, precisamos instalar as dependências do projeto. Portanto, rode o seguinte comando dentro da pasta "convida":

```bash
flutter pub get
```

Você também pode baixá-las através do seu ambiente de desenvolvimento:

- VSCode:\
![vscode-packages](https://user-images.githubusercontent.com/43693277/121826220-f7370d00-cc8c-11eb-9bca-0c94e7de9cd5.png)


- Android Studio/Intellij IDEA:\
![intellij-packages](https://user-images.githubusercontent.com/43693277/121826221-f8683a00-cc8c-11eb-80fa-f5d89c108d08.png)

### Passo 3:

Por fim, podemos executar o projeto, através do ambiente de desenvolvimento. Vale ressaltar que você deverá selecionar o arquivo main.dart e o celular/emulador a ser utilizado:

- VSCode:\
![vscode-run](https://user-images.githubusercontent.com/43693277/121826200-e2f31000-cc8c-11eb-89da-7e93d03ff8e7.png)
- Android Studio/Intellij IDEA:\
![intellij-run](https://user-images.githubusercontent.com/43693277/121826109-7f68e280-cc8c-11eb-8bec-f2dddc103785.png)

Ao final do passo 3 você deverá ter o arquivo build.gradle criado e o app baixado :)
