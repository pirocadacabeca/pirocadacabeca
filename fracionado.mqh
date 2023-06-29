// Define as variáveis globais
double LotSize = 1.0;              // Tamanho do lote
string FractionalSymbol = "PETR4F";  // Símbolo da ação fracionada
string LotSymbol = "PETR4";         // Símbolo da ação em lote cheio

//+------------------------------------------------------------------+
//| Função de inicialização do Expert Advisor                         |
//+------------------------------------------------------------------+
int OnInit()
{
    // Verifica se os símbolos estão disponíveis na corretora
    if (!SymbolInfoDouble(FractionalSymbol, SYMBOL_BID) || !SymbolInfoDouble(LotSymbol, SYMBOL_BID))
    {
        Print("Os símbolos necessários não estão disponíveis na corretora.");
        return INIT_FAILED;
    }

    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Função principal do Expert Advisor                                |
//+------------------------------------------------------------------+
void OnTick()
{
    // Verifica a diferença de preço entre os símbolos
    double fractionalPrice = SymbolInfoDouble(FractionalSymbol, SYMBOL_BID);
    double lotPrice = SymbolInfoDouble(LotSymbol, SYMBOL_BID);

    // Compra o mais barato e vende o mais desvalorizado
    if (fractionalPrice < lotPrice)
    {
        // Compra a ação fracionada
        double volume = NormalizeDouble(LotSize, 2); // Normaliza o tamanho do lote
        ulong ticket = OrderSend(FractionalSymbol, OP_BUY, volume, fractionalPrice, 3, 0, 0, "Arbitrage", 0, 0, Green);
        if (ticket <= 0)
        {
            Print("Erro ao enviar a ordem de compra para ", FractionalSymbol);
        }
    }
    else if (fractionalPrice > lotPrice)
    {
        // Vende a ação em lote cheio
        double volume = NormalizeDouble(LotSize, 2); // Normaliza o tamanho do lote
        ulong ticket = OrderSend(LotSymbol, OP_SELL, volume, lotPrice, 3, 0, 0, "Arbitrage", 0, 0, Red);
        if (ticket <= 0)
        {
            Print("Erro ao enviar a ordem de venda para ", LotSymbol);
        }
    }
}

//+------------------------------------------------------------------+
