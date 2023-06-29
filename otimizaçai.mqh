void OnTick()
{
   try
   {
      // Executar seções mais pesadas primeiro
      Section1();
      Section2();
      // ...

      // Executar seções mais leves
      SectionN();
      SectionNPlus1();
      // ...
   }
   catch (Exception e)
   {
      // Lidar com exceção (opcional)
      Print("Exceção capturada: ", e);
   }
}

void Section1()
{
   // Lógica para a seção 1 (mais pesada)
}

void Section2()
{
   // Lógica para a seção 2 (mais pesada)
}

// ...

void SectionN()
{
   // Lógica para a seção N (mais leve)
}

void SectionNPlus1()
{
   // Lógica para a seção N + 1 (mais leve)
}

// ...
