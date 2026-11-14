package model;

import java.time.*;
import java.math.BigDecimal;

public record Sale(int id, Integer jogo_id, Integer quantidade, BigDecimal valor_total, LocalDateTime data_venda, String status_pagamento) {}
