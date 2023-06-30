//+------------------------------------------------------------------+
//|                      MainExpert.mq5                              |
//|                                 Copyright 2023, ChatGPT          |
//|                        https://github.com/openai/chatgpt          |
//+------------------------------------------------------------------+
#property copyright "2023, ChatGPT"
#property link      "https://github.com/openai/chatgpt"
#property version   "1.00"
#property strict

// Inclua os arquivos .mqh necessários
#include "cripto.mqh"
#include "deltaforex.mqh"
#include "ea.mqh"
#include "eastop.mqh"
#include "forex.mqh"
#include "fracionado.mqh"
#include "marketmaking.mqh"
#include "noticia.mqh"
#include "otimizacao.mqh"
#include "pricing.mqh"

// Variáveis globais
datetime HoraInicial;
datetime HoraFinal;
datetime HoraFechamento;

// Função de inicialização do Expert Advisor
int OnInit()
{
    // Inicialização das variáveis de tempo
    if (!SetTimeParams())
    {
        Print("Os horários fornecidos são inválidos.");
        return INIT_FAILED;
    }

    // Resto do código de inicialização
    // ...
    
    return INIT_SUCCEEDED;
}

// Função para definir os parâmetros de tempo
bool SetTimeParams()
{
    datetime currentDateTime = TimeCurrent();
    
    // Conversão dos horários fornecidos em datetime
    HoraInicial = StringToTime(HoraInicial);
    HoraFinal = StringToTime(HoraFinal);
    HoraFechamento = StringToTime(HoraFechamento);
    
    // Verificação de inconsistências nos horários
    if (HoraInicial == 0 || HoraFinal == 0 || HoraFechamento == 0 ||
        HoraInicial >= HoraFinal || HoraFinal >= HoraFechamento ||
        HoraInicial <= currentDateTime || HoraFinal <= currentDateTime)
    {
        return false;
    }
    
    return true;
}
