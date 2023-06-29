
// Símbolos das moedas
input string Symbol1 = "EURUSD";  // Moeda com menor valor inicialmente
input string Symbol2 = "EURGBP";  // Moeda com valor intermediário
input string Symbol3 = "GBPUSD";  // Moeda com maior valor inicialmente

// Variáveis globais
double LotSize = 0.01;  // Tamanho do lote a ser negociado
int Slippage = 3;       // Deslizamento máximo aceitável em pontos
int MagicNumber = 12345; // Número mágico para identificar as ordens

// Função de inicialização do Expert Advisor
int OnInit()
{
    // Verifica se os símbolos são válidos
    if (!SymbolInfoDouble(Symbol1, SYMBOL_BID) ||
        !SymbolInfoDouble(Symbol2, SYMBOL_BID) ||
        !SymbolInfoDouble(Symbol3, SYMBOL_BID))
    {
        Print("Símbolos de moeda inválidos!");
        return INIT_FAILED;
    }
    
    // Verifica se os símbolos têm os mesmos dígitos
    if (SymbolInfoInteger(Symbol1, SYMBOL_DIGITS) != SymbolInfoInteger(Symbol2, SYMBOL_DIGITS) ||
        SymbolInfoInteger(Symbol1, SYMBOL_DIGITS) != SymbolInfoInteger(Symbol3, SYMBOL_DIGITS))
    {
        Print("Os símbolos de moeda não têm o mesmo número de dígitos!");
        return INIT_FAILED;
    }
    
    // Verifica se os símbolos têm o mesmo modo de cotação
    if (SymbolInfoInteger(Symbol1, SYMBOL_TRADE_MODE) != SymbolInfoInteger(Symbol2, SYMBOL_TRADE_MODE) ||
        SymbolInfoInteger(Symbol1, SYMBOL_TRADE_MODE) != SymbolInfoInteger(Symbol3, SYMBOL_TRADE_MODE))
    {
        Print("Os símbolos de moeda não têm o mesmo modo de cotação!");
        return INIT_FAILED;
    }
    
    return INIT_SUCCEEDED;
}

// Função de execução do Expert Advisor
void OnTick()
{
    // Obtém as taxas de câmbio atuais dos símbolos
    double Rate1 = SymbolInfoDouble(Symbol1, SYMBOL_BID);
    double Rate2 = SymbolInfoDouble(Symbol2, SYMBOL_BID);
    double Rate3 = SymbolInfoDouble(Symbol3, SYMBOL_BID);
    
    // Verifica se as taxas de câmbio são válidas
    if (Rate1 == 0.0 || Rate2 == 0.0 || Rate3 == 0.0)
    {
        Print("Taxas de câmbio inválidas!");
        return;
    }
    
    // Calcula o spread ponderado
    double WeightedSpread = (Rate1 * Rate2) / Rate3 - 1.0;
    
    // Verifica se o spread ponderado é maior que zero
    if (WeightedSpread > 0.0)
    {
        // Calcula os volumes para as ordens
        double Volume1 = NormalizeDouble(LotSize, 2);
        double Volume2 = NormalizeDouble(LotSize * Rate1 / Rate2, 2);
        double Volume3 = NormalizeDouble(LotSize * Rate1, 2);
        
        // Envia as ordens
        int Ticket1 = OrderSend(Symbol1, OP_SELL, Volume1, SymbolInfoDouble(Symbol1, SYMBOL_BID), Slippage, 0, 0, "Order 1", MagicNumber);
        int Ticket2 = OrderSend(Symbol2, OP_BUY, Volume2, SymbolInfoDouble(Symbol2, SYMBOL_ASK), Slippage, 0, 0, "Order 2", MagicNumber);
        int Ticket3 = OrderSend(Symbol3, OP_BUY, Volume3, SymbolInfoDouble(Symbol3, SYMBOL_ASK), Slippage, 0, 0, "Order 3", MagicNumber);
        
        // Verifica se as ordens foram enviadas com sucesso
        if (Ticket1 <= 0 || Ticket2 <= 0 || Ticket3 <= 0)
        {
            Print("Falha ao enviar as ordens!");
            return;
        }
    }
}
