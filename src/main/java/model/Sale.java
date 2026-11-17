package model;

import java.time.LocalDateTime;
import java.math.BigDecimal;

/** Venda registrada pelo administrador ou pedido iniciado por uma conta da loja. */
public record Sale(int id, Integer jogo_id, Integer quantidade, BigDecimal valor_total,
                   LocalDateTime data_venda, String status_pagamento, Integer conta_id) {}
