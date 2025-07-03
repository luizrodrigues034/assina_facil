# Configuração do Firebase

## Passos para configurar o Firebase no projeto

### 1. Criar projeto no Firebase Console

1. Acesse [Firebase Console](https://console.firebase.google.com/)
2. Clique em "Criar projeto"
3. Digite o nome do projeto: `assina-facil-app`
4. Siga os passos para criar o projeto

### 2. Configurar Authentication

1. No Firebase Console, vá para "Authentication"
2. Clique em "Get started"
3. Vá para a aba "Sign-in method"
4. Habilite "Email/Password"
5. Clique em "Save"

### 3. Configurar Firestore Database

1. No Firebase Console, vá para "Firestore Database"
2. Clique em "Create database"
3. Escolha "Start in test mode" (para desenvolvimento)
4. Escolha a localização mais próxima
5. Clique em "Done"

### 4. Configurar Android

1. No Firebase Console, clique no ícone do Android
2. Digite o package name: `com.example.assina_facil`
3. Clique em "Register app"
4. Baixe o arquivo `google-services.json`
5. Substitua o arquivo `android/app/google-services.json` pelo arquivo baixado

### 5. Configurar iOS (opcional)

1. No Firebase Console, clique no ícone do iOS
2. Digite o Bundle ID: `com.example.assinaFacil`
3. Clique em "Register app"
4. Baixe o arquivo `GoogleService-Info.plist`
5. Adicione o arquivo ao projeto iOS

### 6. Regras do Firestore

Configure as regras do Firestore para permitir acesso autenticado:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Usuários podem ler e escrever apenas seus próprios dados
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Documentos podem ser lidos e escritos apenas pelo usuário proprietário
    match /documents/{documentId} {
      allow read, write: if request.auth != null && 
        resource.data.email == request.auth.token.email;
    }
  }
}
```

### 7. Testar a configuração

1. Execute `flutter pub get`
2. Execute `flutter run`
3. Teste o cadastro e login

## Estrutura do Firestore

### Coleção: users
```json
{
  "id": "user_uid",
  "firstName": "João",
  "lastName": "Silva",
  "email": "joao@email.com",
  "cpf": "12345678901",
  "createdAt": "2024-01-01T00:00:00.000Z"
}
```

### Coleção: documents (futuro)
```json
{
  "id": "document_id",
  "name": "documento.pdf",
  "email": "joao@email.com",
  "filePath": "path/to/file",
  "uploadDate": "2024-01-01T00:00:00.000Z",
  "fileSize": 1024000
}
```

## Funcionalidades implementadas

- ✅ Firebase Authentication (Email/Password)
- ✅ Firestore Database para dados do usuário
- ✅ Página de perfil com informações do usuário
- ✅ Logout funcional
- ✅ Deletar conta
- ✅ Tratamento de erros de autenticação
- ✅ Validação de formulários
- ✅ Navegação protegida por autenticação

## Próximos passos

- [ ] Implementar Firebase Storage para upload de PDFs
- [ ] Sincronizar documentos com Firestore
- [ ] Implementar recuperação de senha
- [ ] Adicionar autenticação social (Google, Apple)
- [ ] Implementar notificações push 