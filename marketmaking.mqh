
// Variáveis globais
double Bid;
double Ask;
int Spread;
double MinSpread;
double MaxSpread;
int Slippage = 3;
int MagicNumber = 12345;

// Função de inicialização do Expert Advisor
int OnInit()
{
    // Define os valores mínimos e máximos para o spread
    MinSpread = SymbolInfoInteger(_Symbol, SYMBOL_SPREAD_MIN);
    MaxSpread = SymbolInfoInteger(_Symbol, SYMBOL_SPREAD);
    
    return INIT_SUCCEEDED;
}

// Função de execução do Expert Advisor
void OnTick()
{
    // Obtém as informações de cotação atualizadas
    Bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    Ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    Spread = (int)SymbolInfoInteger(_Symbol, SYMBOL_SPREAD);
    
    // Verifica se o spread está dentro dos limites desejados
    if (Spread < MinSpread || Spread > MaxSpread)
    {
        // Calcula os preços para fazer o market making
        double NewBid = NormalizeDouble(Ask - MinSpread / 2.0, _Digits);
        double NewAsk = NormalizeDouble(Bid + MinSpread / 2.0, _Digits);
        
        // Verifica se os preços calculados são válidos
        if (NewBid > 0.0 && NewAsk > 0.0)
        {
            // Envia as ordens de compra e venda
            int BuyTicket = OrderSend(_Symbol, OP_BUY, 1.0, NewAsk, Slippage, 0, 0, "Buy Order", MagicNumber);
            int SellTicket = OrderSend(_Symbol, OP_SELL, 1.0, NewBid, Slippage, 0, 0, "Sell Order", MagicNumber);
            
            // Verifica se as ordens foram enviadas com sucesso
            if (BuyTicket > 0 && SellTicket > 0)
            {
                Print("Ordens de Market Making enviadas: Compra a", NewAsk, " e Venda a", NewBid);
            }
            else
            {
                Print("Falha ao enviar as ordens de Market Making!");
            }
        }
    }
}
