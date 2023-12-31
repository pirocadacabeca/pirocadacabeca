//+------------------------------------------------------------------+
//|                 Exemplo básico de código MQL5                    |
//|          para redução de latência usando servidor VPS            |
//+------------------------------------------------------------------+

// Variáveis globais
int g_socketHandle;  // Handle do soquete
string g_serverAddress = "127.0.0.1";  // Endereço IP do servidor VPS
int g_serverPort = 12345;  // Porta do servidor VPS

// Função de inicialização
int OnInit()
{
   // Inicializar a conexão com o servidor VPS
   g_socketHandle = SocketCreate();
   if (g_socketHandle == INVALID_HANDLE)
   {
      Print("Erro ao criar o soquete!");
      return INIT_FAILED;
   }

   // Conectar ao servidor VPS
   if (!SocketConnect(g_socketHandle, g_serverAddress, g_serverPort, 5000))
   {
      Print("Erro ao conectar-se ao servidor VPS!");
      return INIT_FAILED;
   }

   // Configurar o soquete para operação não bloqueante
   SocketSetBlocking(g_socketHandle, false);

   return INIT_SUCCEEDED;
}

// Função de encerramento
void OnDeinit(const int reason)
{
   // Encerrar a conexão com o servidor VPS
   SocketClose(g_socketHandle);
}

// Função de atualização
void OnTick()
{
   // Verificar se há dados disponíveis para leitura
   if (SocketIsReady(g_socketHandle))
   {
      // Ler os dados do servidor VPS
      string data = SocketReadString(g_socketHandle, 4096);
      
      // Processar os dados recebidos do servidor
      // ...
   }
   
   // Enviar dados para o servidor VPS (exemplo)
   string message = "Dados a serem enviados para o servidor VPS";
   SocketWriteString(g_socketHandle, message);
}


