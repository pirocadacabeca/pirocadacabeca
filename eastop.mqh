//+------------------------------------------------------------------+
//|                     Expert Advisor Start Function                |
//+------------------------------------------------------------------+
void OnTick()
{
   // Verificar se há uma posição aberta
   if (PositionSelect(_Symbol))
   {
      // Verificar se a posição atingiu o stop loss
      if (PositionGetDouble(POSITION_SL) > 0 && Ask <= PositionGetDouble(POSITION_SL))
      {
         // Aumentar o tamanho da posição após um stop loss
         double positionVolume = PositionGetDouble(POSITION_VOLUME);
         double newVolume = positionVolume * 2.0; // Aumento em 100%
         
         if (PositionModify(_Symbol, newVolume))
         {
            // Registro do evento
            Print("Aumentou o tamanho da posição após o stop loss. Novo volume: ", newVolume);
         }
      }
      
      // Verificar se a posição atingiu o take profit
      if (PositionGetDouble(POSITION_TP) > 0 && Ask >= PositionGetDouble(POSITION_TP))
      {
         // Aumentar o tamanho da posição após um take profit
         double positionVolume = PositionGetDouble(POSITION_VOLUME);
         double newVolume = positionVolume * 2.0; // Aumento em 100%
         
         if (PositionModify(_Symbol, newVolume))
         {
            // Registro do evento
            Print("Aumentou o tamanho da posição após o take profit. Novo volume: ", newVolume);
         }
      }
   }
}
