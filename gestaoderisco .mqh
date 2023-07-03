//+------------------------------------------------------------------+
//|            Código MQL5 para gestão de risco com detecção          |
//|                      de obstáculos                               |
//+------------------------------------------------------------------+

// Variáveis globais
double g_entryPrice = 0.0;  // Preço de entrada da posição
double g_stopLoss = 0.0;    // Preço de stop-loss
double g_takeProfit = 0.0;  // Preço de take-profit

// Função para verificar a detecção de obstáculos
bool CheckObstacle(const double price)
{
  // Função para verificar a detecção de obstáculos
bool CheckObstacle(const double price, const double obstacleLevel, const double obstacleThreshold)
{
   // Verificar se o preço está dentro do limite de distância do obstáculo
   if (MathAbs(price - obstacleLevel) <= obstacleThreshold)
   {
      return true;  // Obstáculo detectado
   }

   return false;  // Nenhum obstáculo detectado
}


   // Exemplo: Verificar se o preço está próximo de uma resistência
   double resistanceLevel = 1.2500;
   double obstacleThreshold = 0.005;  // Distância mínima para considerar um obstáculo

   if (MathAbs(price - resistanceLevel) <= obstacleThreshold)
   {
      return true;  // Obstáculo detectado
   }

   return false;  // Nenhum obstáculo detectado
}

// Função para gerenciar a posição
void ManagePosition()
{
   // Obter o preço atual
   double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);

   // Verificar se há detecção de obstáculos
   if (CheckObstacle(currentPrice))
   {
      // Encerrar a posição devido à detecção de obstáculos
      Print("Detecção de obstáculo! Encerrando a posição.");
      
      // ... realizar ações de fechamento da posição
      
      // Reiniciar as variáveis ​​de gerenciamento de risco
      g_entryPrice = 0.0;
      g_stopLoss = 0.0;
      g_takeProfit = 0.0;
   }
   else
   {
      // Verificar se o preço atingiu o stop-loss ou take-profit
      if (currentPrice <= g_stopLoss || currentPrice >= g_takeProfit)
      {
         // Encerrar a posição devido a stop-loss ou take-profit atingidos
         Print("Stop-loss ou take-profit atingido! Encerrando a posição.");
         
         // ... realizar ações de fechamento da posição
         
         // Reiniciar as variáveis ​​de gerenciamento de risco
         g_entryPrice = 0.0;
         g_stopLoss = 0.0;
         g_takeProfit = 0.0;
      }
   }
}

// Função para abrir uma posição
void OpenPosition(const double entryPrice, const double stopLoss, const double takeProfit)
{
   // Realizar ações de abertura da posição
   Print("Abrindo uma posição com entrada em ", entryPrice, ", stop-loss em ", stopLoss, " e take-profit em ", takeProfit);
   
   // Definir os valores de gerenciamento de risco
   g_entryPrice = entryPrice;
   g_stopLoss = stopLoss;
   g_takeProfit = takeProfit;
}

// Função de inicialização
int OnInit()
{
   // Abrir uma posição de exemplo
   OpenPosition(1.2400, 1.2350, 1.2450);

   return INIT_SUCCEEDED;
}

// Função de encerramento
void OnDeinit(const int reason)
{
   // Nada a fazer aqui
}

// Função de atualização
void OnTick()
{
   // Gerenciar a posição atual
   ManagePosition();
}

