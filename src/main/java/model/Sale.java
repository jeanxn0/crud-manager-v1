package model;

import java.time.LocalDateTime;
import java.math.BigDecimal;

/** Venda registrada pelo administrador ou pedido iniciado por uma conta da loja. */
public record Sale(int id, Integer jogo_id, Integer quantidade, BigDecimal valor_total,
                   LocalDateTime data_venda, String status_pagamento, Integer conta_id) {
    public int getId() { return id; }
    public Integer getJogo_id() { return jogo_id; }
    public Integer getQuantidade() { return quantidade; }
    public BigDecimal getValor_total() { return valor_total; }
    public LocalDateTime getData_venda() { return data_venda; }
    public String getStatus_pagamento() { return status_pagamento; }
    public Integer getConta_id() { return conta_id; }
}
