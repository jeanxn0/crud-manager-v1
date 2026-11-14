package model;

import java.time.*;
import java.math.BigDecimal;

public record Game(int id, String titulo, String descricao, LocalDate data_lancamento, BigDecimal preco, Integer usuario_id) {}
