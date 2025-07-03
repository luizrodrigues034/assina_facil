# Assina Fácil

Um aplicativo Flutter para gerenciamento de documentos PDF com interface moderna e intuitiva.

## Funcionalidades

- **Página Inicial**: Tela de boas-vindas com descrição do app e opções de login/cadastro
- **Autenticação**: Sistema de login e cadastro com validação de formulários
- **Upload de PDF**: Interface para seleção e upload de arquivos PDF
- **Lista de Documentos**: Visualização organizada dos PDFs do usuário
- **Visualizador de PDF**: Visualização completa com zoom e navegação

## Design

O aplicativo utiliza um design moderno com:
- Cores principais: Azul e branco
- Bordas curvadas em todos os elementos
- Interface limpa e intuitiva
- Animações suaves
- Feedback visual para ações do usuário

## Tecnologias Utilizadas

- **Flutter**: Framework principal
- **Firebase Auth**: Autenticação de usuários
- **Cloud Firestore**: Banco de dados em tempo real
- **Go Router**: Navegação entre páginas
- **File Picker**: Seleção de arquivos PDF
- **Syncfusion PDF Viewer**: Visualização de PDFs com zoom
- **Path Provider**: Gerenciamento de arquivos locais
- **Email Validator**: Validação de emails

## Estrutura do Projeto

```
lib/
├── main.dart                 # Arquivo principal com rotas
├── models/                   # Modelos de dados
│   ├── document.dart        # Modelo de documento
│   └── user.dart            # Modelo de usuário
├── pages/                   # Páginas do aplicativo
│   ├── welcome_page.dart    # Página inicial
│   ├── login_page.dart      # Página de login
│   ├── register_page.dart   # Página de cadastro
│   ├── home_page.dart       # Página principal
│   ├── upload_page.dart     # Página de upload
│   └── pdf_viewer_page.dart # Visualizador de PDF
├── services/                # Serviços
│   ├── auth_service.dart    # Autenticação
│   └── document_service.dart # Gerenciamento de documentos
├── utils/                   # Utilitários
│   └── validators.dart      # Validações de formulário
└── widgets/                 # Widgets reutilizáveis
    ├── custom_button.dart   # Botão personalizado
    └── custom_text_field.dart # Campo de texto personalizado
```

## Como Executar

1. **Configurar Firebase**:
   - Siga as instruções em [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
   - Configure o arquivo `google-services.json` para Android

2. **Instalar dependências**:
   ```bash
   flutter pub get
   ```

3. **Executar o aplicativo**:
   ```bash
   flutter run
   ```

## Funcionalidades Detalhadas

### Página Inicial (Welcome)
- Logo/ícone do aplicativo
- Descrição das funcionalidades
- Botões para login e cadastro

### Login
- Campo de email com validação
- Campo de senha com toggle de visibilidade
- Validação de formulário
- Autenticação via Firebase Auth
- Tratamento de erros específicos
- Redirecionamento automático após login

### Cadastro
- Campos: Nome, Sobrenome, Email, CPF, Senha, Confirmação de Senha
- Validação completa de todos os campos
- Máscara automática para CPF
- Criação de conta via Firebase Auth
- Salvamento de dados no Firestore
- Tratamento de erros específicos

### Página Principal (Home)
- Header com informações do usuário
- Botão de perfil no canto superior direito
- Botão de upload de PDF
- Lista de documentos com informações detalhadas
- Estado vazio quando não há documentos

### Upload de PDF
- Seleção de arquivo PDF
- Preview do arquivo selecionado
- Informações de tamanho do arquivo
- Feedback de progresso

### Visualizador de PDF
- Visualização completa do PDF
- Zoom in/out com botões e gestos
- Navegação entre páginas
- Seleção de texto
- Interface responsiva

### Página de Perfil
- Informações completas do usuário
- Avatar com iniciais ou foto de perfil
- Dados pessoais (nome, email, CPF, data de cadastro)
- Opção de logout
- Opção de deletar conta
- Design moderno e responsivo

## Validações Implementadas

- **Email**: Formato válido e obrigatório
- **Senha**: Mínimo 6 caracteres
- **CPF**: Formato e validação de dígitos verificadores
- **Nomes**: Mínimo 2 caracteres
- **Confirmação de senha**: Deve coincidir com a senha

## Armazenamento

- **Usuários**: Dados salvos no Firebase Auth e Firestore
- **Documentos**: Salvos localmente no dispositivo (preparado para Firebase Storage)
- **Autenticação**: Gerenciada pelo Firebase Auth
- **Persistência**: Dados do usuário persistem entre sessões

## Próximas Melhorias

- Persistência de dados com banco local
- Compartilhamento de documentos
- Assinatura digital de PDFs
- Categorização de documentos
- Busca e filtros
- Backup na nuvem
